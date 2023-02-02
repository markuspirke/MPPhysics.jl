using MPPhysics
using Test

@testset "two_moving_pendulum" begin
    pen = Pendulum(9.81, 1.0, 1.0, pi / 2, 0.0)
    mpen1 = MovingPendulum(1.0, 0.0, 0.0, pen)
    mpen2 = MovingPendulum(1.0, 1.0, 0.0, pen)
    cmpen = CoupledMovingPendulum(mpen1, mpen2, 1.0, 1.0)
    @test 1.0 ≈ lagrangian(cmpen, [0.0, π / 2, 1.0, π / 2], [0.0, 0.0, 0.0, 0.0]) + 1.0
    @test -1.0 ≈ lagrangian(cmpen, [0.0, π / 2, 2.0, π / 2], [0.0, 0.0, 0.0, 0.0])

end