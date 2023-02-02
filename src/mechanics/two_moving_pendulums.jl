
function lagrangian(cmpen::CoupledMovingPendulum, q, v)
    L = (lagrangian(cmpen.mpen1, q[1:2], v[1:2])
         +
         lagrangian(cmpen.mpen2, q[3:4], v[3:4]))
    #-
    #cmpen.k * (q[3] - q[1] - cmpen.l)^2)
    L
end

function generalized_momenta(cmpen::CoupledMovingPendulum, q, v)

    p₁ = generalized_momenta(cmpen.mpen1, q[1:2], v[1:2])
    p₂ = generalized_momenta(cmpen.mpen1, q[3:4], v[3:4])

    return [p₁..., p₂...]
end

function inverse_generalized_momenta(cmpen::CoupledMovingPendulum, p, q)
    v₁ = inverse_generalized_momenta(cmpen.mpen1, p[1:2], q[1:2])
    v₂ = inverse_generalized_momenta(cmpen.mpen1, p[3:4], q[3:4])

    return [v₁..., v₂...]
end

function legendre(cmpen::CoupledMovingPendulum, p, q)
    v = inverse_generalized_momenta(cmpen, p, q)
    H = sum(p .* q) - lagrangian(cmpen, q, v)
    H
end

function (cmpen::CoupledMovingPendulum)(p, q, param)
    legendre(cmpen, p, q)
end

function startvalues(cmpen::CoupledMovingPendulum)
    p1, q1 = startvalues(cmpen.mpen1)
    p2, q2 = startvalues(cmpen.mpen2)

    [p1..., p2...], [q1..., q2...]
end

function cartesian(cmpen::CoupledMovingPendulum, q)
    x1 = cartesian(cmpen.mpen1, q[1:2])
    x2 = cartesian(cmpen.mpen2, q[3:4])

    [x1...], [x2...]
end
