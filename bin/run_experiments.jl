# Scripts to generate datasets and example plots for each simulation/stochastic generative process

using Pkg
Pkg.activate(".")
using EmulatE

MAIN = "/Users/touellette/Research/"

# Degradation of a single molecular species
examples_degradation(path = MAIN * "plots/")
generate_degradation(path = MAIN * "data/degradation/")

# Degradation of a single molecular species
examples_production_degradation(path = MAIN * "plots/")
generate_production_degradation(path = MAIN * "data/production-degradation/")

# Haploid wright fisher with selection tracking change in allele frequency
examples_wright_fisher(path = MAIN * "plots/")
generate_wright_fisher(path = MAIN * "data/wright-fisher/")
