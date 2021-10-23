module EmulatE

using StatsBase
using Distributions
using LinearAlgebra
using Random
using Plots
using PlotThemes
using StatsPlots
using Statistics

export

    # Simulation utilities
    SampleUniform,
    SampleUniformD,
    grid_sample,
    grid_params,

    # Simulation parameters
    ParamsDegradation,

    # Simulations
    Degradation,

    # Plotting
    PlotDegradation

include("simulation/degradation.jl")
include("simulation/parameters.jl")
include("simulation/simutils.jl")

PLOTS_DEFAULTS = Dict(:dpi => 600)

end
