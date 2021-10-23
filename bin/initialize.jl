"""initialize.jl

Initialization of parameter ranges
"""

# Degradation of a single molecular species, Radek & Chapman (2020)
# > Returns 3 arrays including parameters, times, and population size at given time
params = EmulatE.ParamsDegradation()
t, Nt = [], []
for i in 1:200
    sim = Degradation(params)
    push!(t, sim[2])
    push!(Nt, sim[3])
end
