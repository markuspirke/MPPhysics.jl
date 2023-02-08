module MPPhysics
using DifferentialEquations
using DiffEqPhysics
using LinearAlgebra
using AngleBetweenVectors
using Statistics
using Distributions
export
    Position2D, Position, SO2,
    HamiltonianSystem, integrate, trajectory,
    polarcoordinates,
    simulate, cartesian,
    Pendulum, startvalues,
    DoublePendulum,
    Spring, SpringMass,
    MovingPendulum, lagrangian,
    CoupledMovingPendulum,
    initialize_kuramoto
# Room2D

# Write your package code here.
include("types.jl")

for inc ∈ readdir(joinpath(@__DIR__, "mechanics"), join=true)
    !endswith(inc, ".jl") && continue
    startswith(split(inc, "/")[end], "foo") && continue
    include(inc)
end

for inc ∈ readdir(joinpath(@__DIR__, "ComplexSystems"), join=true)
    !endswith(inc, ".jl") && continue
    startswith(split(inc, "/")[end], "foo") && continue
    include(inc)
end
# for inc ∈ readdir(joinpath(@__DIR__, "Thermodynamics"), join=true)
#     !endswith(inc, ".jl") && continue
#     startswith(split(inc, "/")[end], "foo") && continue
#     include(inc)
# end
end
