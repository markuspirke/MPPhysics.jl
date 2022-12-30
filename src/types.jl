struct SO2
    ϕ
end

function (R::SO2)(x)
    M = [cos(R.ϕ) -sin(R.ϕ); sin(R.ϕ) cos(R.ϕ)]
    y = M * x

    y
end