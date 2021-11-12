"""
    WrightFisher

A stochastic simulation of change in allele frequency over time
(In genetic terms, this is specifically a two-allele Wright-Fisher model reminiscent of two competing alleles at a haploid locus)
"""

"""
    WrightFisher

# Arguments
    - Params (Array{Any, 1}): An array containing [N, k, dt, tmax]

> Returns:
    - A nested array containing simulation parameters, times at each step, number of molecules at each step
"""
function WrightFisher(Params)
    N, g, f, s = Params  
    N, g, f, s = Int64(N), Int64(g), Float64(f), Float64(s)

    # Initialize
    Nq, t, q = Int64.(zeros(g)), zeros(g), zeros(g)
    Nq[1], t[1], q[1] = Int64(N*f), 0, f
    
    for i in 2:g
        # Fitness benefit for the selected allele is relative to other allele i.e. 1+s : 1
        qs = (q[i-1]*(1+s)) / (q[i-1]*(1+s) + 1 * (1-q[i-1]))
        Nq[i] = rand(Binomial(N, qs))
        q[i] = Nq[i]/N
        t[i] = i
    end

    return Params, Nq, q, t
end