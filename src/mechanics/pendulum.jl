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
    function cartesian(q, pen::Pendulum)

Returns cartesian coordinates of the generalized coordinates.
"""
function cartesian(pen::Pendulum, q)
    y, x = polarcoordinates(pen.l, q)
    y = -y # because of defintion of the angle
    x, y
end
