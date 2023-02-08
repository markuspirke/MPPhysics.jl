struct KuramotoOscillators
    ω
    θ
    K
end

function initialize_kuramoto(N, K, P::Uniform, Ω::Uniform)
    ω = rand(Ω, N)
    θ = rand(P, N)

    KuramotoOscillators(ω, θ, K)
end

# function kuramoto_model(dθs, θs, p, t)
#     K = p[end-1]
#     N = p[end]
#     ωs = p[1:length(θs)]
#     R = 0.0
#     for θ in θs
#         R += exp(θ*im)
#     end
#     R = R/N
#     r = abs(R)
#     ψ = angle(R)
#     for i in 1:N
#         dθs[i] = ωs[i] + K*r*sin(ψ - θs[i])
#     end
# end

function kuramoto_model!(dθ, θ, p, t)
    K = p[end-1]
    N = p[end]
    ωs = p[1:end-2]
    for i in 1:length(dθ)
        dθ[i] = ωs[i] + K/N * sum(θⱼ -> sin(θⱼ - θ[i]), θ)
    end
end

function simulate(model::KuramotoOscillators, tspan; kwargs...)
    prob = ODEProblem(kuramoto_model!, model.θ, tspan, [model.ω..., model.K, length(model.θ)])
    sol = solve(prob; kwargs...)

    sol.u
end
