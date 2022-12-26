module MPPhysics
using DifferentialEquations
using DiffEqPhysics
using StaticArrays
using LinearAlgebra
using AngleBetweenVectors
export
    Position2D, Position, SO2,
    HamiltonianSystem, integrate, trajectory,
    polarcoordinates,
    simulate, cartesian,
    Pendulum, startvalues,
    DoublePendulum,
    Spring, SpringMass,
    MovingPendulum, lagrangian

# Write your package code here.
include("types.jl")

for inc ∈ readdir(joinpath(@__DIR__, "mechanics"), join=true)
    !endswith(inc, ".jl") && continue
    startswith(split(inc, "/")[end], "foo") && continue
    include(inc)
end

end