"""
    Degradation

Code to generate all training and testing data for the toy simulation example, and example plots.
Degradation of a single molecular species.
"""

# Description of datasets
# ------------------------
# A. Evaluating the sampling density across rate constant parameter range (k = 0.025, 0.25)
#    - 1. sampling density of 4
#    - 2. sampling density of 8
#    - 3. sampling density of 16
#    - 4. sampling density of 32
#    - 5. sampling density of 64
#    - 6. sampling density of 128
#    - 7. sampling density of 256
#    - 8. sampling density of 512
#    - 9. sampling density of 1024
# B. Generation of test sets by uniformly sampling rate constants
#    - 1. In-distribution test set I from k = [0.025, 0.25]
#    - 2. Above-distribution test set A from k = [0.005, 0.025]
#    - 3. Below-distribution test set B from k = [0.25, 0.5]

function generate_degradation(;path::String, testsetsize::Int64 = 1000)
    # Generate dataset A
    for sd in [4, 8, 16, 32, 64, 128]
        for ts in [2, 4, 8, 16, 32, 64, 128]
            print(sd)
            # Sample parameters on a grid based on sampling density
            p = grid_params(EmulatE.ParamsDegradation(
                [20, 20], # N
                [0.025, 0.25], # k
                [0.01, 0.01], # Δt
                [40.0, 40.0], # tmax
                sampling_scheme = "Grid",
                sampling_density = sd))
            
            # Generate training data     
            sims = []
            for j in p
                t, Nt = [], []
                for i in 1:ts
                    sim = Degradation(j)
                    a = sim
                    push!(t, Float64.(sim[2]))
                    push!(Nt, Float64.(sim[3]))
                end
                pψ = [collect(j) for k in 1:ts]
                push!(sims, [pψ, t, Nt])
            end
            
            # Save training data
            p = collect(transpose(collect(vcat([collect(transpose(collect(hcat(sims[i][1]...)))) for i in 1:sd]...))))
            t = collect(transpose(collect(vcat([collect(transpose(collect(hcat(sims[i][2]...)))) for i in 1:sd]...))))
            N = collect(transpose(collect(vcat([collect(transpose(collect(hcat(sims[i][3]...)))) for i in 1:sd]...))))
            filename = path *
                    "sampledensity_" * string(sd) * "_" *
                    "samplesize_" * string(ts) * ".h5"
            h5open(filename, "w") do file
                file["params"] = p
                file["t"] = t
                file["N"] = N
            end
        end
    end

    # Generate in-distribution test set I    
    for rateconstants in [[[0.025, 0.25], "indist"], [[0.005, 0.025], "belowdist"], [[0.25, 0.5], "abovedist"]]
        N, k, dt, tmax = [20, 20], rateconstants[1], [0.01, 0.01], [40.0, 40.0]
        sims = []
        for i in 1:testsetsize
            p = EmulatE.ParamsDegradation(N, k, dt, tmax)
            sim = Degradation(p)
            push!(sims, [sim[1], sim[2], sim[3]])
        end
        p = collect(transpose(collect(vcat([collect(collect(hcat(sims[i][1]...))) for i in 1:testsetsize]...))))
        t = collect(transpose(collect(vcat([collect(collect(hcat(sims[i][2]...))) for i in 1:testsetsize]...))))
        N = collect(transpose(collect(vcat([collect(collect(hcat(sims[i][3]...))) for i in 1:testsetsize]...))))
        filename = path * "uniform_" * rateconstants[2] * "_" * 
                   string(rateconstants[1][1]) * "_" * string(rateconstants[1][2]) * ".h5"
        h5open(filename, "w") do file
            file["params"] = p
            file["t"] = t
            file["N"] = N
        end
    end
end

"""
    examples_degradation

Degradation of a single molecular species.
A toy example to show deep learning based emulation in a time-series/markovian process

Only the rate of degradation (k) is varied. 
The initial number of molecules (N), time between events (Δt), and maximum reaction time (tmax) are fixed.

# Arguments
    - path (String): path to the folder containing the plots
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