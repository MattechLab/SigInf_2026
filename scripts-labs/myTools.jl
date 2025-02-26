
# Decoder that translates a string of symbols `s` into a string of characters based on the encoding `code`.
# The `code` is assumed prefix.
function decode(s::String,code::Dict{Char,String})
	dcode = Dict{String,Char}(code[k] => k for k in keys(code))
	k = keys(dcode)

	m = ""
	c = ""

	for x in s
		c *= x
		if c in k
			m *= dcode[c]
			c = ""
		end
	end

	return m
end

# Gives the indices of the nonzero base 2 digits of a number `x`  in base 10, in `p`. 
function ten2two(x::Float64, tol::Int64=-16)
	res = 1000.
	p = Int64[]

	if x == 0.
		d = 0.
		p = Int64[]
	else
		push!(p,floor(Int64,log(2,x)))

		while res > tol
			res = log(2,x - sum((2.).^p))
			push!(p,floor(Int64,res))
		end
		
		d = sum((10.).^p)
	end

	return d,p
end

function ten2two(X::Vector{Float64}, tol::Int64=-16)
	xxx = [ten2two(x,tol)[1] for x in X]
end

 #=
# Rounds the binary number `x` to `d` digits. Returns a String
function roundBin(x::Float64, d::Int64)
	X = round.(Int64,x*(10.).^(d+1) + 10^(d+3))
	S = "$X"
	k = d+3
	y = S[k]
	while y == '1'
#		S[k] == '0'
		S = S[1:k-1]*'0'*S[k+1:end]
		k -= 1
		y = S[k]
	end
#	S[k] = '1'
	S = S[1:k-1]*'1'*S[k+1:end]

	return S[3:d+2]
end

function roundBin(X::Vector{Float64}, D::Vector{Int64})
	return [roundBin(X[i],D[i]) for i in 1:length(X)]
end

# =#





