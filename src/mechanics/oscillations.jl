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

function simulate(p::Pendulum, tspan; kwargs...)
    p₀, q₀ = startvalues(p)
    prob = HamiltonianProblem(p, p₀, q₀, tspan)
    sol = solve(prob, Tsit5(); kwargs...)

    t = sol.t
    qs = [u[2] for u in sol.u]
    ps = [u[1] for u in sol.u]

    t, ps, qs
end

function cartesian(qs, p::Pendulum)
    xs = Float64[]
    ys = Float64[]
    for q in qs
        x, y = polarcoordinates(p.l, q)
        push!(xs, y)
        push!(ys, -x)
    end
    xs, ys
end
