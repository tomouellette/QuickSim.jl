"""run_simulation.jl

Scripts to generate synthetic datasets for each example simulation algorithm/example
"""
using Plots
using PlotThemes
using StatsPlots
using Statistics
using StatsBase
using Pkg
Pkg.activate(".")
using EmulatE

# Degradation of a single molecular species, Radek & Chapman (2020)
# > Returns 3 arrays including parameters, times, and population size at given time
params = EmulatE.ParamsDegradation()
t, Nt = [], []
for i in 1:200
    sim = Degradation(params)
    push!(t, sim[2])
    push!(Nt, sim[3])
end

function PlotDegradation(p, t, Nt, width=450, height=350; theory=false, figsave=false, figname="degradation")    
    theme(:wong2, 
        framestyle=:box,
        legend=true, 
        thickness_scaling=1.1,
        widen=false, 
        grid=false,
        xtickfontsize = 10,
        ytickfontsize = 10,
        foreground_color_legend=:white,
        fontfamily="Helvetica")

    plot_title = "Degradation of a single molecular species\n" *  
                "N " * string(p[1]) * ", k " * string(p[2]) * ", Δt " * string(p[3]) *
                ", t " * string(p[4]) * ", samples " * string(length(Nt))
    plot(t, 
         Nt, 
         xlabel="Time (sec)", 
         ylabel="Number of molecules", 
         c=:thermal,
         alpha=0.7,
         title=plot_title,
         titlefont=11,
         titlelocation=:left,
         labels="",
         size = (width, height))

    plot!(mean(t), 
          mean(Nt), 
          xlabel="Time (sec)", 
          ylabel="Number of molecules",
          c="#b7db23",
          linewidth=3.5,
          legend=true,
          lab="Sample mean",
          alpha=1,
          legendmarkersize = 2)        

    plot!(mean(t), 
          mapslices(x->quantile(x,0.055),hcat(Nt...),dims=2)[:,1],
          fillrange=mapslices(x->quantile(x,0.945),hcat(Nt...),dims=2)[:,1], 
          xlabel="Time (sec)", 
          ylabel="Number of molecules",
          c="#a0bf21",
          linestyle=:dot,
          legend=true,
          lab="Sample quantiles (95%)",
          alpha=0.2)
    
    plot!(mean(t), 
          mapslices(x->quantile(x,0.055),hcat(Nt...),dims=2)[:,1],
          xlabel="Time (sec)", 
          ylabel="Number of molecules",
          c="#b7db23",
          linewidth=3.5,
          linestyle=:dot,
          lab="",
          alpha=1)

    plot!(mean(t), 
          mapslices(x->quantile(x,0.945),hcat(Nt...),dims=2)[:,1],          
          xlabel="Time (sec)", 
          ylabel="Number of molecules",
          c="#b7db23",
          linewidth=3.5,
          linestyle=:dot,
          lab="",
          alpha=1)
    
    if theory == true
        plot!([i-1 for i in 1:(Int(params[4])+1)], 
          [params[1]*exp(-params[2]*(i-1)) for i in 1:(Int(params[4])+1)],
          legend=true,
          lab="Theory",
          color="darkred",
          linewidth=2.5,
          alpha=1)
    end

    if figsave == true
        savefig(figname)
    end
end

