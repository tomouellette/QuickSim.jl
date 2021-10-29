"""
    ProductionDegradation

A stochastic simulation algorithm tracking production and degradation of a molecular species
The example was sourced from Erban & Chapman (2020).
"""

"""
    ProductionDegradation

# Arguments
    - Params (Array{Any, 1}): An array containing [N, k1, k2, tmax]

> Returns:
    - A nested array containing simulation parameters, times at each step, number of molecules at each step
"""
function ProductionDegradation(Params)
    
    # Initialize simulation settings
    N, k1, k2, tmax = Params
    Nt, t = [N], [0.0]

    # Iterate across state    
    while t[end] < tmax
        r1, r2 = rand(1)[1], rand(1)[1]

        # Compute overall rate 
        α0 = Nt[end]*k1 + k2
        
        # Compute the time of next reaction using tau-leaping
        τ = (1/α0) * log(1/r1)

        # Update number of molecules
        if r2 < (k2/α0)
            push!(Nt, Nt[end] + 1)
        else
            push!(Nt, Nt[end] - 1)
        end

        # Update time
        push!(t, t[end] + τ)
    end

    return [Params, t, Nt]
end