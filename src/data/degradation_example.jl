"""
    degradation_example.jl

Degradation of a single molecular species.
A toy example to show deep learning based emulation in a time-series/markovian process

Only the rate of degradation (k) is varied. 
The initial number of molecules (N), time between events (Δt), and maximum reaction time (tmax) are fixed.
"""

function examples_degradation(;path::String)
    #> Initialize parameter grid 
    p = grid_params(EmulatE.ParamsDegradation(
        [20, 20], # N
        [0.025, 0.25], # k
        [0.01, 0.01], # Δt
        [40.0, 40.0], # tmax
        sampling_scheme = "Grid",
        sampling_density = 12
    ))

    #> Generate synthetic data (12 unique rate constants)
    sims = []
    for j in p
        t, Nt = [], []
        for i in 1:100
            sim = Degradation(j)
            push!(t, sim[2])
            push!(Nt, sim[3])
        end
        push!(sims, [j, t, Nt])
    end

    #> Generate plots
    colors = ["#8de4d3", "#1c4c5e", "#88da6f", "#8438ba", "#2e9cbc", "#056e12", "#a6b6f9", "#514a8a", "#fe79ec", "#991c64"]
    plts = []
    for j in sims
        a = PlotDegradation(j..., theory=true, colors=[colors[2], colors[3]], shrinkfont=1)
        push!(plts, a)
    end

    #> Save plots
    savefig(plot(plts..., layout=grid(4,3), size=(1100, 1100), dpi=600), path * "degradation_example_plot.pdf")
end