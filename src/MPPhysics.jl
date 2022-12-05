module MPPhysics
using DifferentialEquations
using DiffEqPhysics
export
    polarcoordinates,
    simulate, cartesian,
    Pendulum, startvalues,
    DoublePendulum
# Write your package code here.
for inc ∈ readdir(joinpath(@__DIR__, "mechanics"), join=true)
    !endswith(inc, ".jl") && continue
    startswith(split(inc, "/")[end], "foo") && continue
    include(inc)
end
end