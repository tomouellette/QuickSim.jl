"""
    Degradation

Plotting utilities for degradation of a single molecular species simulations
"""

"""
    PlotDegradation

Takes in N samples from a Degradation simulation run with identical parameter settings and returns a plot.

# Arguments:
    - p (Array{Any, 1}): Parameters (N, k, dt, t) for a Degradation simulation
    - t (Array{Float, 1}): Times across each step
    - Nt (Array{Float, 1}): Number of molecules in population at a given time step
    - width (Int): width of plot
    - height (Int): height of plot
    - theory (Bool): If true, draw the expected theoretical decay N*exp(-k*t)
    - figsave (Bool): If true, save a figure as an svg
    - figname (String): The name of the figure, add path to front of name if you do not want to save in current directory

> Return:
    - A JuliaPlots object
"""
function PlotDegradation(p, t, Nt, width=450, height=350; theory=false, figsave=false, figname="none", colors = ["#314ca3", "#47b42f"], shrinkfont=0)
    theme(:wong2, 
        framestyle=:box,
        legend=true, 
        thickness_scaling=1.1,
        widen=false, 
        grid=false,
        xtickfontsize = 11 - shrinkfont,
        ytickfontsize = 11 - shrinkfont,
        xlabelfontsize = 11 - shrinkfont,
        ylabelfontsize = 11 - shrinkfont,
        background_color_legend=:transparent,
        foreground_color_legend=:transparent,
        fontfamily="Helvetica")

    plot_title = "N " * string(round(p[1], sigdigits=2)) * ", k " * string(round(p[2], sigdigits=2)) * ", dt " * string(round(p[3], sigdigits=2)) *
                ", t " * string(round(p[4], sigdigits=2)) * ", ns " * string(length(Nt))
    plt = plot(t, 
             Nt, 
             xlabel="Time (sec)", 
             ylabel="Number of molecules", 
             c=colors[1],
             alpha=0.7,
             title=plot_title,
             titlefont=11 - shrinkfont,
             titlelocation=:left,
             labels="",
             size = (width, height))

    plot!(mean(t), 
          mean(Nt), 
          xlabel="Time (sec)", 
          ylabel="Number of molecules",
          c=colors[2],
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
          c=colors[2],
          linestyle=:dot,
          legend=true,
          lab="Sample quantiles (95%)",
          alpha=0.2)
    
    plot!(mean(t), 
          mapslices(x->quantile(x,0.055),hcat(Nt...),dims=2)[:,1],
          xlabel="Time (sec)", 
          ylabel="Number of molecules",
          c=colors[2],
          linewidth=3.5,
          linestyle=:dot,
          lab="",
          alpha=1)

    plot!(mean(t), 
          mapslices(x->quantile(x,0.945),hcat(Nt...),dims=2)[:,1],          
          xlabel="Time (sec)", 
          ylabel="Number of molecules",
          c=colors[2],
          linewidth=3.5,
          linestyle=:dot,
          lab="",
          alpha=1)
    
    if theory == true
        plot!([i-1 for i in 1:(Int(p[4])+1)], 
          [p[1]*exp(-p[2]*(i-1)) for i in 1:(Int(p[4])+1)],
          legend=true,
          lab="Theory",
          color="darkred",
          linewidth=2.5,
          alpha=1)
    end

    if figsave == true
        savefig(figname * ".svg")
    else
        return plt
    end
end

