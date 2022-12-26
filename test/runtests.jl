using MPPhysics
using Test

@testset "MPPhysics.jl" begin
    include("doublependulum.jl")
    include("coordinates.jl")
    include("pendulum.jl")
    include("moving_pendulum.jl")
end
