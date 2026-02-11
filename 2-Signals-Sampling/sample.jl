using Statistics, DelimitedFiles

println("Hi, what's your name?")
name = readline()
n6me = [Int64(c) for c in name]
nnn = [n6me;n6me;n6me]

println("For how long do you want to sample (in seconds)?")
T = parse(Float64,readline())

println("And a what sample rate (in measurements per second)?")
ρ = parse(Float64,readline())

N = round(Int64,T*ρ)
k = vec(1:N)

types = ["sine","step","saw6"]

a = Int64(nnn[2])/10
ω = (Int64(nnn[3]) - 93)/20
x0 = Int64(nnn[4])/100*a - 1
ϕ = Int64(nnn[5])/100

ξ = a/10

x = [0.,]

if nnn[1]%3 == 0
	x = x0 .+ a*sin.(ω*k./ρ .+ ϕ) + ξ*randn(N)
elseif nnn[1]%3 == 1
	x = x0 .+ 2*a*((ω*k./ρ).%2 .> 1) .- a + ξ*randn(N)
else
	x = [x0,]
	p = 4*a*ω
	dx = p/ρ
	for i in 2:N
		global x,dx
		x = [x;x[end] + dx]
		if abs(x[end]) > a
			dx = -dx
		end
	end
	x .+= ξ*randn(N)
end

#PyPlot.plot(k,x)
writedlm("lab07-sample-0.csv",x,',')

