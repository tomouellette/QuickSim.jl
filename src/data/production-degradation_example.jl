"""
    production-degradation_example.jl

Production and degradation of a single molecular species.
A toy example to show deep learning based emulation in a time-series/markovian process

Only the rate of degradation (k) is varied. 
The initial number of molecules (N), time between events (Δt), and maximum reaction time (tmax) are fixed.
"""

function examples_production_degradation(;path::String)
    #> Initialize parameter grid 
    p = grid_params(EmulatE.ParamsProductionDegradation(
        [0, 0], # N
        [0.005, 0.1], # k1
        [1.0, 1.0], # k2
        [100.0, 100.0], # tmax
        sampling_scheme = "Grid",
        sampling_density = 12
    ))

    #> Generate synthetic data (12 unique rate constants)
    sims = []
    for j in p
        t, Nt = [], []
        for i in 1:50
            sim = ProductionDegradation(j)
            push!(t, sim[2])
            push!(Nt, sim[3])
        end
        push!(sims, [j, t, Nt])
    end

    #> Generate plots
    colors = ["#8de4d3", "#1c4c5e", "#88da6f", "#8438ba", "#2e9cbc", "#056e12", "#a6b6f9", "#514a8a", "#fe79ec", "#991c64"]
    plts = []
    for j in sims
        a = PlotProductionDegradation(j..., theory=true, colors=[colors[2], colors[3]], shrinkfont=1)
        push!(plts, a)
    end

    #> Save plots
    savefig(plot(plts..., layout=grid(4,3), size=(1150, 1150), dpi=600), path * "production-degradation_example_plot.pdf")
end