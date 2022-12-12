using MPPhysics
using Documenter

DocMeta.setdocmeta!(MPPhysics, :DocTestSetup, :(using MPPhysics); recursive=true)

makedocs(;
    modules=[MPPhysics],
    authors="Markus Pirke <markus.pirke@web.de> and contributors",
    repo="https://github.com/mpirke/MPPhysics.jl/blob/{commit}{path}#{line}",
    sitename="MPPhysics.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="main",
        assets=String[]
    ),
    pages=[
        "Home" => "index.md",
    ]
)
deploydocs(;
    repo="github.com/mpirke/MPPhysics.jl"
)
