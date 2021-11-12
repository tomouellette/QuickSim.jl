"""
    Parameters

Parameters defines the parameter settings for each simulation.
For each simulation, the corresponding parameters are placed into
function that can enables sampling given a specified range.
"""

"""
    ParamsDegradation

# Arguments:
    - N (Array{Int64,1}): Lower and upper bounds on initial population size
    - k (Array{Int64,1}): Lower and upper bounds on degradation rate
    - dt (Array{Int64,1}): Lower and upper bounds on change in time per event
    - tmax (Array{Int64,1}): Lower and upper bounds on total simulation time
    - sampling_scheme (String): Uniform or Grid sampling where Uniform returns single values and Grid returns an array from [Lower, Upper]
    - sampling_density (Int64): If Grid sampling, the number of splits of [Lower, Upper] for each parameter e.g. 10 returns 10 values evenly spaced between [Lower, Upper]

> Returns:
    - If sampling_scheme Uniform, an array containing single values for each parameter
    - If sampling_scheme Grid, a multi-dimensional array containing N = sampling_density observations for each parameter
"""
function ParamsDegradation(
    N::Array{Int64,1} = [20,20],
    k::Array{Float64,1} = [0.1, 0.1],
    dt::Array{Float64,1} = [0.005, 0.005],
    tmax::Array{Float64,1} = [30.0, 30.0];
    sampling_scheme::String = "Uniform",
    sampling_density::Int64 = 0
)

    # Generate uniformly sample parameters from [Lower, Upper]
    if sampling_scheme == "Uniform"
        N = SampleUniformD(N)
        k = SampleUniform(k)
        dt = SampleUniform(dt)
        tmax = SampleUniformD(tmax)

    # Generate bulk parameters sampled across a [Lower, Upper] grid with N = sampling_density observations
    elseif sampling_scheme == "Grid"
        N = grid_sample(N, sampling_density)
        k = grid_sample(k, sampling_density)
        dt = grid_sample(dt, sampling_density)
        tmax = grid_sample(tmax, sampling_density)
    else
        println("Warning: sampling_scheme must be either Uniform or Grid")
    end

    return [N, k, dt, tmax]
end

"""
    ParamsProductionDegradation

# Arguments:
    - N (Array{Int64,1}): Lower and upper bounds on initial population size
    - k1 (Array{Int64,1}): Lower and upper bounds on degradation rate (/sec)
    - k2 (Array{Int64,1}): Lower and upper bounds on production rate (/sec⋅volume)
    - tmax (Array{Int64,1}): Lower and upper bounds on total simulation time
    - sampling_scheme (String): Uniform or Grid sampling where Uniform returns single values and Grid returns an array from [Lower, Upper]
    - sampling_density (Int64): If Grid sampling, the number of splits of [Lower, Upper] for each parameter e.g. 10 returns 10 values evenly spaced between [Lower, Upper]

> Returns:
    - If sampling_scheme Uniform, an array containing single values for each parameter
    - If sampling_scheme Grid, a multi-dimensional array containing N = sampling_density observations for each parameter
"""
function ParamsProductionDegradation(
    N::Array{Int64,1} = [20,20],
    k1::Array{Float64,1} = [0.1, 0.1],
    k2::Array{Float64,1} = [1, 1],
    tmax::Array{Float64,1} = [100.0, 100.0];
    sampling_scheme::String = "Uniform",
    sampling_density::Int64 = 0
)

    # Generate uniformly sample parameters from [Lower, Upper]
    if sampling_scheme == "Uniform"
        N = SampleUniformD(N)
        k1 = SampleUniform(k1)
        k2 = SampleUniform(k2)
        tmax = SampleUniformD(tmax)

    # Generate bulk parameters sampled across a [Lower, Upper] grid with N = sampling_density observations
    elseif sampling_scheme == "Grid"
        N = grid_sample(N, sampling_density)
        k1 = grid_sample(k1, sampling_density)
        k2 = grid_sample(k2, sampling_density)
        tmax = grid_sample(tmax, sampling_density)
    else
        println("Warning: sampling_scheme must be either Uniform or Grid")
    end

    return [N, k1, k2, tmax]
end

"""
    WrightFisher

# Arguments: 
    - N (Array{Int64,1}): Lower and upper bounds on initial population size
    - g (Array{Int64,1}): Lower and upper bounds on number of generations
    - f (Array{Int64,1}): Lower and upper bounds of initial frequency of allele being tracked
    - s (Array{Int64,1}): Lower and upper bounds on the selection coefficient of the allele being tracked
    - sampling_scheme (String): Uniform or Grid sampling where Uniform returns single values and Grid returns an array from [Lower, Upper]
    - sampling_density (Int64): If Grid sampling, the number of splits of [Lower, Upper] for each parameter e.g. 10 returns 10 values evenly spaced between [Lower, Upper]

> Returns:
    - If sampling_scheme Uniform, an array containing single values for each parameter
    - If sampling_scheme Grid, a multi-dimensional array containing N = sampling_density observations for each parameter
"""
function ParamsWrightFisher(
    N::Array{Int64,1} = [10000,10000],
    g::Array{Int64,1} = [1000, 1000],
    f::Array{Float64,1} = [0.01, 0.01],
    s::Array{Float64,1} = [0.005, 0.005];
    sampling_scheme::String = "Uniform",
    sampling_density::Int64 = 0
)

    # Generate uniformly sample parameters from [Lower, Upper]
    if sampling_scheme == "Uniform"
        N = SampleUniformD(N)
        g = SampleUniformD(g)
        f = SampleUniform(f)
        s = SampleUniform(s)

    # Generate bulk parameters sampled across a [Lower, Upper] grid with N = sampling_density observations
    elseif sampling_scheme == "Grid"
        N = grid_sample(N, sampling_density)
        g = grid_sample(g, sampling_density)
        f = grid_sample(f, sampling_density)
        s = grid_sample(s, sampling_density)
    else
        println("Warning: sampling_scheme must be either Uniform or Grid")
    end

    return [N, g, f, s]
end