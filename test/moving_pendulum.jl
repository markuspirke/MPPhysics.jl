using MPPhysics
using Test

@testset "moving_pendulum" begin
    pen = Pendulum(9.81, 1.0, 1.0, pi / 2, 0.0)
    mpen = MovingPendulum(1.0, 0.0, 0.0, pen)
    @test 9.81 ≈ lagrangian(mpen, [0.0, 0.0], [0.0, 0.0])
    @test 1.0 ≈ lagrangian(mpen, [0.0, pi/2], [0.0, 0.0]) + 1.0
    @test 1.0 ≈ lagrangian(mpen, [1.0, pi/2], [0.0, 0.0]) + 1.0
    @test 1.0 ≈ lagrangian(mpen, [1.0, pi/2], [1.0, 0.0])
    @test -9.81 ≈ mpen([0.0, 0.0], [0.0, 0.0], nothing)

    x1, y1, x2, y2 = cartesian(mpen, [1.0, π/4])
    @test 1.0 ≈ x1  
    @test 0.0 ≈ y1  
    @test 1.0 + 1/sqrt(2) ≈ x2
    @test - 1/sqrt(2) ≈ y2 
end