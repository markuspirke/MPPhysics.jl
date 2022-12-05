mutable struct DoublePendulum
    g
    m₁
    l₁
    m₂
    l₂
    ϕ₁
    dϕ₁
    ϕ₂
    dϕ₂
end

function (dpen::DoublePendulum)(p, q, param)
    p₁, p₂ = p
    q₁, q₂ = q

    H = ((dpen.l₂^2 * dpen.m₂ * p₂^2 + dpen.l₁^2(dpen.m₁ + dpen.m₂) * p₂
          -
          2 * dpen.m₂ * dpen.l₁ * dpen.l₂ * p₁ * p₂ * cos(q₁ - q₂)) / (2 * dpen.l₁^2 * dpen.l₂ * dpen.m₂ * (dpen.m₁ + dpen.m₂ * sin(q₁ - q₂)^2))
         -
         (dpen.m₁ + dpen.m₂) * dpen.g * dpen.l₁ * cos(q₁) - dpen.m₂ * dpen.g * dpen.l₂ * cos(q₂))

    # H = -(dpen.m₁ + dpen.m₂) * dpen.g * dpen.l₁ * cos(q₁) - dpen.m₂ * dpen.g * dpen.l₂ * cos(q₂)

    H
end

function startvalues(dpen::DoublePendulum)
    q₁ = dpen.ϕ₁
    q₂ = dpen.ϕ₂
    p₁ = (dpen.m₁ + dpen.m₂) * dpen.l₁^2 * dpen.dϕ₁ + dpen.m₂ * dpen.l₁ * dpen.l₂ * dpen.dϕ₂ * cos(dpen.ϕ₁ - dpen.ϕ₂)
    p₂ = dpen.m₂ * dpen.l₂^2 * dpen.dϕ₂ + dpen.m₂ * dpen.l₁ * dpen.l₂ * dpen.dϕ₁ * cos(dpen.ϕ₁ - dpen.ϕ₂)

    [p₁, p₂], [q₁, q₂]
end

function integrate(p::DoublePendulum, tspan; kwargs...)
    p₀, q₀ = startvalues(p)
    prob = HamiltonianProblem(p, p₀, q₀, tspan)
    init(prob, Tsit5(); kwargs...)
end