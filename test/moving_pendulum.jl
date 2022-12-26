using MPPhysics
using Test

@testset "moving_pendulum" begin
    pen = Pendulum(9.81, 1.0, 1.0, pi / 2, 0.0)
    mpen = MovingPendulum(1.0, 0.0, 0.0, pen)

end