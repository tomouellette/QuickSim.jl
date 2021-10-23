"""
    Parameters

Parameters defines the parameter settings for each simulation.
For each simulation, the corresponding parameters are placed into
function that can enables sampling given a specified range.
"""

"""
    Degradation

:param N (Array{Int64,1}): Lower and upper bounds on initial population size
:param k (Array{Int64,1}): Lower and upper bounds on degradation rate
:param dt (Array{Int64,1}): Lower and upper bounds on change in time per event
:param tmax (Array{Int64,1}): Lower and upper bounds on total simulation time
:param sampling_scheme (String): Uniform or Grid sampling where Uniform returns single values and Grid returns an array from [Lower, Upper]
:param sampling_density (Int64): If Grid sampling, the number of splits of [Lower, Upper] for each parameter e.g. 10 returns 10 values evenly spaced between [Lower, Upper]

>return:
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
