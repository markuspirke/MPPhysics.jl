"""
    struct Pendulum

This type stores all the parameters and start values of a simple ideal pendulum.
"""
struct Pendulum
    g
    m
    l
    ϕ₀
    dϕ₀
end
"""
    function (pen::Pendulum)(p, q, param)

Hamiltonian of a simple pendulum.
"""
function (pen::Pendulum)(p, q, param)
    H = p^2 / (2 * pen.m * (pen.l)^2) - pen.m * pen.g * pen.l * cos(q)
    H
end
"""
    function startvalues(pen::Pendulum)

Returns the starting values of a pendulum as p, q. 
"""
function startvalues(pen::Pendulum)
    q₀ = pen.ϕ₀
    p₀ = pen.dϕ₀ * pen.m * (pen.l)^2
    p₀, q₀
end
"""
    function trajectory(pen::Pendulum, tspan; kwargs...)

Calculates the trajectory of a simple pendulum.
Returns the times t, generalized momenta ps and generalized position qs.
"""
function trajectory(pen::Pendulum, tspan; kwargs...)
    p₀, q₀ = startvalues(pen)
    prob = HamiltonianProblem(pen, p₀, q₀, tspan)
    sol = solve(prob, Tsit5(); kwargs...)

    t = sol.t
    qs = [u[2] for u in sol.u]
    ps = [u[1] for u in sol.u]

    t, ps, qs
end
"""
    function integrate(pen::Pendulum, tspan; kwargs...)

Sets up time stepping for the pendulum.
"""
function integrate(pen::Pendulum, tspan; kwargs...)
    p₀, q₀ = startvalues(pen)
    prob = HamiltonianProblem(pen, p₀, q₀, tspan)
    init(prob, Tsit5(); kwargs...)
end

"""
    function cartesian(q, pen::Pendulum)

Returns cartesian coordinates of the generalized coordinates.
"""
function cartesian(q, pen::Pendulum)
    y, x = polarcoordinates(q, pen.l)
    y = -y # because of defintion of the angle
    x, y
end
