using MPPhysics
using Test

@testset "pendulum" begin
    pen = Pendulum(9.81, 1.0, 1.0, 0.0, 0.0)
    p, q = startvalues(pen)
    @test -9.81 ≈ pen(p, q, nothing)
    x, y = cartesian(q, pen)
    @test 0.0 == x
    @test -1.0 == y
    pen = Pendulum(9.81, 1.0, 1.0, pi / 4, 0.0)
    x, y = cartesian(pen.ϕ₀, pen)
    @test 1 / sqrt(2) ≈ x
    @test -1 / sqrt(2) ≈ y

end