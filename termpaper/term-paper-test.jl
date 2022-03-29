using Plots

plotlyjs()

Rz(θ) = [cos(θ) -sin(θ) 0; sin(θ) cos(θ) 0; 0 0 1]

f(x, g, θ, xᵣ) = (1-g)*Rz(θ)*x + g*xᵣ

trajectory(nstep, x₀, g, θ, xᵣ) = [[x₀]; accumulate(1:nstep, init=x₀) do i, _ 
    f(i, g, θ, xᵣ)
end]

polar(θ, ϕ, r=1) = [r*cos(ϕ)*sin(θ), r*sin(ϕ)*sin(θ), r*cos(θ)]

traj = trajectory(20000, polar(π/4, π/3), 0.6, 2π/6, polar(4π/3, -π/8))
print(length(traj))
plot(Tuple.(traj), st=:path, lims=(-1, 1))
plot!(Tuple(polar(4π/3, -π/8)), st=:scatter)
plot!(Tuple(polar(π/4, π/3)), st=:scatter)

