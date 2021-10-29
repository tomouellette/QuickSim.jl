# Scripts to generate datasets and example plots for each simulation/stochastic generative process

using Pkg
Pkg.activate(".")
using EmulatE

MAIN = "/Users/touellette/Research/Submissions/EmulatE/"

# Degradation of a single molecular species
examples_degradation(path = MAIN * "plots/")
generate_degradation(path = MAIN * "data/degradation/")

# Degradation of a single molecular species
examples_production_degradation(path = MAIN * "plots/")
generate_production_degradation(path = MAIN * "data/production-degradation/")