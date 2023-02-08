using MPPhysics
using Test

@testset "kuramoto" begin
    ωs = [1.0, 1.0]
    N = 2
    K = 1.0
    dθ = [0.0, 0.0]
    θ = [1.0, 1.0]
    p = [ωs..., K, N]
    MPPhysics.kuramoto_model!(dθ, θ, p, nothing)
    @test dθ ≈ ωs
    θ = [π/2, 0.0]
    MPPhysics.kuramoto_model!(dθ, θ, p, nothing)
    @test [0.5, 1.5] ≈ dθ
    θ = [0.0, π/2]
    MPPhysics.kuramoto_model!(dθ, θ, p, nothing)
    @test [1.5, 0.5] ≈ dθ


end
