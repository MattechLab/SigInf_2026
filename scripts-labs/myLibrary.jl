using DelimitedFiles, Statistics

# Entropy
function myEntropy(p::Vector{Float64})
	return -sum(p.*log.(2,p))
end

function myEntropy(n::Vector{Int64})
	N = sum(n)
	return myEntropy(n./N)
end

# Joint entropy
function myJointEntropy(p::Matrix{Float64})
	return -sum(p.*log.(2,p))
end

function myJointEntropy(n::Matrix{Int64})
	N = sum(n)
	return myJointEntropy(n./N)
end

# Conditional entropy
function myCondProba(p::Matrix{Float64}) # Along the vertical dimension...
	return p./repeat(sum(p,dims=1),size(p)[1],1)
end

function myCondProba(n::Matrix{Int64})
	N = sum(n)
	return myCondProba(n./N)
end

function myCondEntropy(p::Matrix{Float64}) # Entropy conditionned to the column variables
	return -sum(myCondProba(p).*log.(2,myCondProba(p)))
end

function myCondEntropy(n::Matrix{Int64})
	N = sum(n)
	return myCondEntropy(n./N)
end

function myCondEntropy(p::Matrix{Float64}, i::Int64) # Entropy, knowing that the column variable is the i-th.
	cp = myCondProba(p)
	return myEntropy(cp[:,i])
end

function myCondEntropy(n::Matrix{Int64}, i::Int64)
	N = sum(n)
	return myCondEntropy(n./N,i)
end


# Mutual information
function myMutualInfo(p::Matrix{Float64})
	p1 = vec(sum(p,dims=2))
	p2 = vec(sum(p,dims=1))

	return myEntropy(p1) + myEntropy(p2) - myJointEntropy(p)
end

function myMutualInfo(n::Matrix{Int64})
	N = sum(n)
	return myMutualInfo(n./N)
end






