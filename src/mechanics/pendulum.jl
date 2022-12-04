struct Pendulum
    m
    g
    l
    ϕ₀
    dϕ₀
end

function (pen::Pendulum)(p, q, param)
    p^2 / (2 * pen.m * (pen.l)^2) - pen.m * pen.g * pen.l * cos(q)
end

function startvalues(p::Pendulum)
    q₀ = p.ϕ₀
    p₀ = p.dϕ₀ * p.m * (p.l)^2
    p₀, q₀
end

function trajectory(p::Pendulum, tspan; kwargs...)
    p₀, q₀ = startvalues(p)
    prob = HamiltonianProblem(p, p₀, q₀, tspan)
    sol = solve(prob, Tsit5(); kwargs...)

    t = sol.t
    qs = [u[2] for u in sol.u]
    ps = [u[1] for u in sol.u]

    t, ps, qs
end

function integrate(p::Pendulum, tspan; kwargs...)
    p₀, q₀ = startvalues(p)
    prob = HamiltonianProblem(p, p₀, q₀, tspan)
    init(prob, Tsit5(); kwargs...)
end


function cartesian(q, p::Pendulum)
    y, x = polarcoordinates(p.l, q)
    y = -y # because of defintion of the angle
    x, y
end
