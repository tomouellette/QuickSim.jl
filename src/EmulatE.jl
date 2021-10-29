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
    ParamsProductionDegradation,

    # Simulations
    Degradation,
    ProductionDegradation,

    # Plotting
    PlotDegradation,
    PlotProductionDegradation,

    # Simulation examples
    examples_degradation,
    examples_production_degradation,

    # Bulk data generation
    generate_degradation,
    generate_production_degradation

# Simulations
include("simulation/parameters.jl")
include("simulation/simutils.jl")
include("simulation/degradation.jl")
include("simulation/production-degradation.jl")

# Plotting
include("plotting/degradation.jl")
include("plotting/production-degradation.jl")

# Examples
include("data/degradation_example.jl")
include("data/production-degradation_example.jl")

# Data
include("data/degradation_generate.jl")
include("data/production-degradation_generate.jl")

end
