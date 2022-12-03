module MPPhysics
using DifferentialEquations
using DiffEqPhysics
export
    polarcoordinates,
    simulate, cartesian,
    Pendulum
# Write your package code here.
for inc ∈ readdir(joinpath(@__DIR__, "mechanics"), join=true)
    !endswith(inc, ".jl") && continue
    include(inc)
end
end