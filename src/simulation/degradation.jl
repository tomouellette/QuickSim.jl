"""
    Degradation

A stochastic simulation algorithm tracking degradation of a single molecular species.
The example was sourced from Erban & Chapman (2020).
"""

using Distributions

function Degradation(Params)

    # Initialize simulation settings
    N, k, dt, tmax = Params
    nevents = Int64(tmax / dt) + 1
    t = zeros(Float64, nevents)
    Nt = zeros(Int64, nevents)
    Nt[1] = Params.Nt

    # Iterate across state
    for i in 2:nevents
        r = rand(1)[1]

        # A single molecule is degraded
        if r < Nt[i] * k * dt
            Nt[i] = Nt[i-1] - 1

        # No reaction occurs
        else
            Nt[i] = Nt[i-1]
        end

        # Update time
        t[i] = t[i-1] + dt
    end

    return [params, t, Nt]
end
