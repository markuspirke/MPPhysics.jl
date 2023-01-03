abstract type HamiltonianSystem end

"""
    function integrate(pen::Pendulum, tspan; kwargs...)

Sets up time stepping for a system described by a Hamiltonian.
"""
function integrate(hs::HamiltonianSystem, tspan; kwargs...)
    p₀, q₀ = startvalues(hs)
    prob = HamiltonianProblem(hs, p₀, q₀, tspan)
    init(prob, Tsit5(); kwargs...)
end

"""
    function trajectory(pen::Pendulum, tspan; kwargs...)

Calculates the trajectory of a system described by a Hamiltonian.
Returns the times t, generalized momenta ps and generalized position qs.
"""
function trajectory(hs::HamiltonianSystem, tspan; kwargs...)
    p₀s, q₀s = startvalues(hs)
    prob = HamiltonianProblem(hs, p₀s, q₀s, tspan)
    sol = solve(prob, Tsit5(); kwargs...)
    t = sol.t
    dgf = length(p₀s)
    us = [[u...] for u in sol.u]
    ps = [u[1:dgf] for u in us]
    qs = [u[dgf+1:end] for u in us]

    t, ps, qs
end