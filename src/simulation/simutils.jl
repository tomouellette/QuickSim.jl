using Distributions
"""
    SimUtils

General utilities for simulation initialization, execution, and processing
"""


"""
Sample a uniformly distributed value from an array X that defines [Lower, Upper] bounds
"""
function SampleUniform(X::Array)
    if X[1] == X[2]
        return X[1]
    else
        return rand(Uniform(X[1], X[2]))
    end
end

"""
Sample a discrete uniformly distributed value from an array X that defines [Lower, Upper] bounds
"""
function SampleUniformD(X::Array)
        return rand(DiscreteUniform(X[1], X[2]))
end

"""
Generate a grid of values by partitioning [Lower, Upper] bounds into n equally spaced values
"""
function grid_sample(X::Array, n::Int64)
    if typeof(X[1]) != Int64
        X = [X[1] + (X[2]-X[1])*((i-1)/(n-1)) for i in 1:n]
    else
        X = collect(X[1]:X[2])
    end
    return X
end

"""
Produces all parameter combinations given arbitrary number of input arrays where each array is a set of parameter values
"""
function grid_params(args...)
    return collect(Base.Iterators.product(args...))
end
