# Derived from:
# https://www.axonlab.org/hcph-sops/data-management/eyetrack-qc
# Load the autoreload extension
from pathlib import Path
import json
import ppjson
from importlib import reload  # For debugging purposes

import numpy as np
import pandas as pd

import eyetrackingrun as et

from IPython.display import HTML
from matplotlib import animation
from matplotlib.animation import FuncAnimation, PillowWriter
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import copy


def cal_mask(coor_data, stand_x_upper=0.15, stand_x_lower=-0.15, stand_y_upper=0.15, stand_y_lower=-0.15):
    Disp_dict = {}
    X_coord = coor_data["x_coordinate"].values
    Y_coord = coor_data["y_coordinate"].values
    print(f'X_coord {X_coord}')
    print(f'Y_coord {Y_coord}')
    print('After cleaning nan, eminating data affected by blinking,\
            and preserving the fixation ')
    print(f'The length of X coordinate data: {len(X_coord)}')
    print(f'The length of Y coordinate data: {len(Y_coord)}')
  
    Disp_mm_eye_x =  X_coord
    Disp_mm_eye_y =  Y_coord
    
    Disp_dict['Disp_mm_eye'] = (Disp_mm_eye_x, Disp_mm_eye_y)

    med_x = np.nanmedian(Disp_mm_eye_x)
    med_y = np.nanmedian(Disp_mm_eye_y)

    Disp_dict['Disp_med'] = (med_x, med_y)

    # Subtract median
    Disp_mm_eye_x_minus_mx = Disp_mm_eye_x - med_x
    Disp_mm_eye_y_minus_my = Disp_mm_eye_y - med_y
    Disp_dict['Disp_mm_eye_minus_med'] = (Disp_mm_eye_x_minus_mx, Disp_mm_eye_y_minus_my)
    
    Ms_to_be_discarded_x_mask = (
            np.logical_or(
                Disp_mm_eye_x_minus_mx > stand_x_upper,
                Disp_mm_eye_x_minus_mx < stand_x_lower
            ) | np.isnan(Disp_mm_eye_x_minus_mx)
        )
    Ms_to_be_discarded_y_mask = (
            np.logical_or(
                Disp_mm_eye_y_minus_my > stand_y_upper,
                Disp_mm_eye_y_minus_my < stand_y_lower
            ) | np.isnan(Disp_mm_eye_y_minus_my)
        )
    Disp_dict['Ms_to_be_discarded_mask'] = (Ms_to_be_discarded_x_mask, Ms_to_be_discarded_y_mask)
    Disp_dict['stand_xy'] = (stand_x_upper, stand_x_lower, stand_y_upper, stand_y_lower)
    return Disp_dict



def plot_x_y_coord(Disp_dict, metadata, duration=None, start_sample=0, seq_name=None):
    from matplotlib.font_manager import FontProperties
    title_font = FontProperties(family='DejaVu Serif', size=24, weight='bold')
    
    Disp_mm_eye_x = Disp_dict['Disp_mm_eye'][0]
    Disp_mm_eye_y = Disp_dict['Disp_mm_eye'][1]
    Disp_mm_eye_x_minus_mx = Disp_dict['Disp_mm_eye_minus_med'][0]
    Disp_mm_eye_y_minus_my = Disp_dict['Disp_mm_eye_minus_med'][1]
    Ms_to_be_discarded_x_mask = Disp_dict['Ms_to_be_discarded_mask'][0]
    Ms_to_be_discarded_y_mask = Disp_dict['Ms_to_be_discarded_mask'][1]
    
    if duration == None:
        end_sample = len(Disp_mm_eye_x)
    else:    
        end_sample = duration*metadata["SamplingFrequency"]

    t_axis_xy = np.arange(start_sample, end_sample, 1)/metadata["SamplingFrequency"]

    # Horizontal direction!!!!!
    fig, ax= plt.subplots(figsize=(8, 4))
    
    ax.plot(
        t_axis_xy,
        Disp_mm_eye_x_minus_mx[start_sample:end_sample],
        marker='*', color='#FFBF00',
        label='Horizontal displacement in mm - med x'
    )

    if len(Ms_to_be_discarded_x_mask) != 0:
        ax.plot(
            t_axis_xy,
            Disp_mm_eye_x_minus_mx[start_sample:end_sample] * Ms_to_be_discarded_x_mask[start_sample:end_sample],
            marker='^', color='#008080',
            label= 'MS to be discarded'
        )
    ax.axhline(y=Disp_dict['stand_xy'][0], color='r', linestyle='--', label='upper boundary')
    ax.axhline(y=Disp_dict['stand_xy'][1], color='r', linestyle='--', label='lower boundary')
    ax.legend()
    ax.set_title(seq_name, fontproperties=title_font)
    plt.tight_layout()

    # Vertical direction!!!!!
    fig, ax= plt.subplots(figsize=(8, 4))
    # ax.plot(
    #     t_axis_xy,
    #     Disp_mm_eye_y[start_sample:end_sample],
    #     marker='o', color='blue',
    #     label="Vertical displacement in mm"
    # )
    ax.plot(
        t_axis_xy,
        Disp_mm_eye_y_minus_my[start_sample:end_sample],
        marker='*', color='#FFBF00',
        label='Vertical displacement in mm - med x'
    )

    if len(Ms_to_be_discarded_y_mask) != 0:
        ax.plot(
            t_axis_xy,
            Disp_mm_eye_y_minus_my[start_sample:end_sample] * Ms_to_be_discarded_y_mask[start_sample:end_sample],
            marker='^', color='#008080',
            label= 'MS to be discarded'
        )

    ax.axhline(y=Disp_dict['stand_xy'][2], color='r', linestyle='--', label='upper boundary')
    ax.axhline(y=Disp_dict['stand_xy'][3], color='r', linestyle='--', label='lower boundary')
    ax.legend()
    ax.set_title(seq_name, fontproperties=title_font)
    plt.tight_layout()


def filter_XY_coord(coor_data, Disp_dict, seq_name=None):
    from matplotlib.font_manager import FontProperties
    title_font = FontProperties(family='DejaVu Serif', size=20, weight='bold')
    axis_font = FontProperties(family='DejaVu Serif', size=20)
#     x y coordinate accordingly
    X_coord = coor_data["x_coordinate"].values
    Y_coord = coor_data["y_coordinate"].values
    Ms_to_be_discarded_x_mask = Disp_dict['Ms_to_be_discarded_mask'][0]
    Ms_to_be_discarded_y_mask = Disp_dict['Ms_to_be_discarded_mask'][1]
    
    Combined_mask = ~(Ms_to_be_discarded_x_mask|Ms_to_be_discarded_y_mask)
   
    filtered_X_coord = X_coord * Combined_mask
    filtered_Y_coord = Y_coord * Combined_mask

    zero_mask = (filtered_X_coord == 0) & (filtered_Y_coord == 0)
    filtered_X_coord[zero_mask] = np.nan
    filtered_Y_coord[zero_mask] = np.nan
    
    Discard_mask = np.where(np.isnan(filtered_X_coord) | np.isnan(filtered_Y_coord), 1, 0)

    # Example data (replace with your actual data)
    fig, ax= plt.subplots(figsize=(8, 6))
    # Plot the data, flipping X coordinates and using dots as markers
    plt.plot(filtered_X_coord, filtered_Y_coord, '.', color='#00468b',markersize=15)
    plt.xlim(0, 800)
    plt.ylim((0, 600))
    # Set plot title
    if seq_name is not None:
        plt.title(f'After filtering {seq_name}', fontproperties=title_font)
    else:     
        plt.title('After filtering', fontproperties=title_font)

    # Reverse the direction of the Y-axis
    for label in plt.gca().get_xticklabels():
        label.set_fontproperties(axis_font)

    for label in plt.gca().get_yticklabels():
        label.set_fontproperties(axis_font)
    plt.gca().invert_yaxis()
    plt.gca().invert_xaxis()
    
    coor_data["x_coordinate"] = filtered_X_coord
    coor_data["y_coordinate"] = filtered_Y_coord
    
    return coor_data, Combined_mask, Discard_mask
    


