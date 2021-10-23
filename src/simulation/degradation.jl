"""
    Degradation

A stochastic simulation algorithm tracking degradation of a single molecular species.
The example was sourced from Erban & Chapman (2020).
"""

"""
    Degradation

# Arguments
    - Params (Array{Any, 1}): An array containing [N, k, dt, tmax]

>return:
    - A nested array containing simulation parameters, times at each step, number of molecules at each step
"""
function Degradation(Params)
    
    # Initialize simulation settings
    N, k, dt, tmax = Params
    nevents = Int64(tmax / dt) + 1
    t = zeros(Float64, nevents)
    Nt = zeros(Int64, nevents)
    Nt[1] = N

    # Iterate across state
    for i in 2:nevents
        r = rand(1)[1]

        # A single molecule is degraded
        if r < Nt[i-1] * k * dt
            Nt[i] = Nt[i-1] - 1

        # No reaction occurs
        else
            Nt[i] = Nt[i-1]
        end

        # Update time
        t[i] = t[i-1] + dt
    end

    return [Params, t, Nt]
end
