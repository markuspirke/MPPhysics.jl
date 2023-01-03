struct MovingPendulum <: HamiltonianSystem
    m₁
    x
    dx
    pen::Pendulum
end

function lagrangian(mpen::MovingPendulum, q, v)
    x, ϕ = q
    dx, dϕ = v
    L = (1 / 2 * (mpen.m₁ + mpen.pen.m) * dx^2 + mpen.pen.m * mpen.pen.l * dx * dϕ * cos(ϕ)
         + 1 / 2 * mpen.pen.m * (mpen.pen.l)^2 * dϕ^2 + mpen.pen.m * mpen.pen.g * mpen.pen.l * cos(ϕ))
    L
end

function generalized_momenta(mpen::MovingPendulum, q, v)
    x, ϕ = q
    dx, dϕ = v

    pₓ = (mpen.m₁ + mpen.pen.m) * dx + mpen.pen.m * mpen.pen.l * dϕ * cos(ϕ)
    pϕ = mpen.pen.m * mpen.pen.l * dx * cos(ϕ) + mpen.pen.m * (mpen.pen.l)^2 * dϕ^2

    return [pₓ, pϕ]
end

function inverse_generalized_momenta(mpen::MovingPendulum, p, q)
    pₓ, pϕ = p
    x, ϕ = q
    dx = (pₓ - pϕ * cos(ϕ) / mpen.pen.l) / (mpen.m₁ + mpen.pen.m * sin(ϕ)^2)
    dϕ = (-mpen.pen.l * cos(ϕ) * pₓ + (mpen.m₁ + mpen.pen.m) / mpen.pen.m * pϕ) / ((mpen.pen.l)^2 * (mpen.m₁ + mpen.pen.m * sin(ϕ)^2))

    return [dx, dϕ]
end

function legendre(mpen::MovingPendulum, p, q)
    pₓ, pϕ = p
    dx, dϕ = inverse_generalized_momenta(mpen, p, q)
    H = pₓ * dx + pϕ * dϕ - lagrangian(mpen, q, [dx, dϕ])
    H
end

function (mpen::MovingPendulum)(p, q, param)
    legendre(mpen, p, q)
end

function startvalues(mpen::MovingPendulum)
    q = [mpen.x, mpen.pen.ϕ₀]
    p = generalized_momenta(mpen, q, [mpen.dx, mpen.pen.dϕ₀])
    p, q
end

function cartesian(mpen::MovingPendulum, q)
    y₁ = 0.0
    x₁, ϕ = q
    y₂, x₂ = polarcoordinates(mpen.pen.l, ϕ)
    x₂ += x₁
    y₂ = -y₂

    x₁, y₁, x₂, y₂
end



