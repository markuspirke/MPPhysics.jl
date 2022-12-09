"""
    struct DoublePendulum

This type stores all the parameters and start values of a double pendulum.
"""
struct DoublePendulum <: HamiltonianSystem
    g
    m₁
    m₂
    l₁
    l₂
    ϕ₁
    ϕ₂
    dϕ₁
    dϕ₂
end
"""
    function (dpen::DoublePendulum)(p, q, param)

Hamiltonian of a double pendulum.
"""
function (dpen::DoublePendulum)(p, q, param)
    p₁, p₂ = p
    q₁, q₂ = q

    H = ((dpen.l₂^2 * dpen.m₂ * p₁^2 + dpen.l₁^2 * (dpen.m₁ + dpen.m₂) * p₂^2
          -
          2 * dpen.m₂ * dpen.l₁ * dpen.l₂ * p₁ * p₂ * cos(q₁ - q₂)) / (2 * dpen.l₁^2 * dpen.l₂^2 * dpen.m₂ * (dpen.m₁ + dpen.m₂ * sin(q₁ - q₂)^2))
         -
         (dpen.m₁ + dpen.m₂) * dpen.g * dpen.l₁ * cos(q₁) - dpen.m₂ * dpen.g * dpen.l₂ * cos(q₂))

    H
end
"""
    function startvalues(dpen::DoublePendulum)

Returns the starting values of a double pendulum as p⃗, q⃗.
"""
function startvalues(dpen::DoublePendulum)
    q₁ = dpen.ϕ₁
    q₂ = dpen.ϕ₂
    p₁ = (dpen.m₁ + dpen.m₂) * dpen.l₁^2 * dpen.dϕ₁ + dpen.m₂ * dpen.l₁ * dpen.l₂ * dpen.dϕ₂ * cos(dpen.ϕ₁ - dpen.ϕ₂)
    p₂ = dpen.m₂ * dpen.l₂^2 * dpen.dϕ₂ + dpen.m₂ * dpen.l₁ * dpen.l₂ * dpen.dϕ₁ * cos(dpen.ϕ₁ - dpen.ϕ₂)

    [p₁, p₂], [q₁, q₂]
end
"""
    function cartesian(q, dpen::DoublePendulum)
        
Return cartesian coordinates of the generalized coordinates of the double pendulum.
"""
function cartesian(q, dpen::DoublePendulum)
    y₁, x₁ = polarcoordinates(dpen.l₁, q[1])
    y₁ = -y₁
    y₂, x₂ = polarcoordinates(dpen.l₂, q[2])
    y₂ = -y₂ + y₁
    x₂ += x₁

    x₁, y₁, x₂, y₂
end