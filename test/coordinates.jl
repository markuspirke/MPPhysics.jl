using MPPhysics
using Test

@testset "coordinates" begin
    x, y = polarcoordinates(1.0, 0.0)
    @test 1.0 ≈ x
    @test 0.0 ≈ y
    x, y = polarcoordinates(1.0, pi / 2)
    @test isapprox(x, 0.0; atol=eps())
    @test 1.0 ≈ y
    x, y = polarcoordinates(1.0, pi / 4)
    @test 1 / sqrt(2) ≈ x
    @test 1 / sqrt(2) ≈ y

end