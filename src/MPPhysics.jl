module MPPhysics
using DifferentialEquations
using DiffEqPhysics
export
    simulate,
    Pendulum
# Write your package code here.
for inc ∈ readdir(joinpath(@__DIR__, "mechanics"), join=true)
    !endswith(inc, ".jl") && continue
    include(inc)
end
end