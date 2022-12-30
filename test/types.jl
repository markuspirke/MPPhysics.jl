using MPPhysics
using Test

@testset "types" begin
    R = SO2(0.0)
    x = [1.0, 1.0]
    @test [1.0, 1.0] ≈ R(x)
    R = SO2(π / 2)
    @test [-1.0, 1.0] ≈ R(x)
    R = SO2(π)
    @test [-1.0, -1.0] ≈ R(x)
    T = SO2(π)
    @test x ≈ R(T(x))
end