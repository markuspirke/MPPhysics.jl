struct Position2D{T} <: FieldVector{2,T}
    x::T
    y::T
end

struct Position{T} <: FieldVector{3,T}
    x::T
    y::T
    z::T
end

struct SO2
    ϕ
end

function (R::SO2)(x)
    M = [cos(R.ϕ) -sin(R.ϕ); sin(R.ϕ) cos(R.ϕ)]
    y = M * x

    y
end