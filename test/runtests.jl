using MPPhysics
using Test

@testset "MPPhysics.jl" begin
    include("types.jl")
    include("doublependulum.jl")
    include("coordinates.jl")
    include("pendulum.jl")
    include("moving_pendulum.jl")
    include("kuramoto.jl")
end
