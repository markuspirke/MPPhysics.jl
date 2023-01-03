[![Build Status](https://github.com/mpirke/MPPhysics.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/mpirke/MPPhysics.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/mpirke/MPPhysics.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/mpirke/MPPhysics.jl)   

# MPPhysics

This will be a package for physics education. At the moment this is not an official julia package therefore you would need the clone the repository to your local machine for usage.

## Classical Mechanics

The first theoretical physics couse is usually classical mechanics. The main topis are the Lagrangian and Hamiltonian formulation of the theory. Beautiful theories. However, when it comes to solves such systems one usually linearizes the equations, because then one can show that there exists an analytical solution. But at the same time one loses the interesting non linear dynamic in the process. 

With this package it is easy to simulate such non linear system and look at the fascinating dynamics. All you need to code is the Lagrangian or Hamiltonian of the system and the respective generalized coordinates. Lets look at an example of simple pendulum. 
As a generalized coordinate we use the angle $\phi$.
The first step is to implement a new data type which will resemble the pendulum.
```julia
    using MPPhysics
    
    struct SimplePendulum <: HamiltonianSystem
        g
        m
        l
        ϕ₀
        dϕ₀
    end
    
```
Next write down the hamiltonian: $H(p,q) = \frac{p^2}{2ml} - mglcos(\phi)$

```julia
    function (pen::SimplePendulum)(p, q, param)
        H = p^2 / (2 * pen.m * (pen.l)^2) - pen.m * pen.g * pen.l * cos(q)
        H
    end
```
Then as a last step write a function for the initial conditions in terms of momenta and positions.

```julia
    function startvalues(pen::SimplePendulum)
        q₀ = pen.ϕ₀
        p₀ = pen.dϕ₀ * pen.m * (pen.l)^2
        p₀, q₀
    end
```
Now to get the trajectory just type:
```julia
    spen = SimplePendulum(1.0, 9.81, 1.0, pi / 2, 0.0)
    tspan = (0.0, 10.0)
    t, ps, qs = trajectory(spen, tspan) 
```
Thats it. You can also use integrate and step in order to do time stepping, which might be easier if you want to animate such a system.
With that you can just simulate every Hamiltonian system in your classical mechanics couse!