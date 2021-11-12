module EmulatE

using StatsBase
using Distributions
using LinearAlgebra
using Random
using Plots
using PlotThemes
using StatsPlots
using Statistics
using HDF5

export

    # Simulation utilities
    SampleUniform,
    SampleUniformD,
    grid_sample,
    grid_params,
    pad_ragged,

    # Simulation parameters
    ParamsDegradation,
    ParamsProductionDegradation,
    ParamsWrightFisher,

    # Simulations
    Degradation,
    ProductionDegradation,
    WrightFisher,

    # Plotting
    PlotDegradation,
    PlotProductionDegradation,
    PlotWrightFisher,

    # Simulation examples
    examples_degradation,
    examples_production_degradation,
    examples_wright_fisher,

    # Bulk data generation
    generate_degradation,
    generate_production_degradation,
    generate_wright_fisher

# Simulations
include("simulation/parameters.jl")
include("simulation/simutils.jl")
include("simulation/degradation.jl")
include("simulation/production-degradation.jl")
include("simulation/wright-fisher.jl")

# Plotting
include("plotting/degradation.jl")
include("plotting/production-degradation.jl")
include("plotting/wright-fisher.jl")

# Data
include("data/degradation.jl")
include("data/production-degradation.jl")
include("data/wright-fisher.jl")

end
