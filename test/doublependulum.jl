using MPPhysics
using Test

@testset "doublependulum" begin
    dpen = DoublePendulum(9.81, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0)
    p, q = startvalues(dpen)
    @test -3 * 9.81 ≈ dpen(p, q, nothing)
end