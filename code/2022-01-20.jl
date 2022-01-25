using Plots

f(r, x) = r*x*(1-x)

rs = [0.5, 1, 2, 3, 3.2, 3.6, 3.7, 4] 

trajs = map(rs) do r
    accumulate(1:100, init=0.213) do xₙ, _
        f(r, xₙ)
    end
end

ps = map(rs, trajs) do r, traj
    plot(traj, title="r=$(r)", ylims=(0,1), st=:scatter, markersize=2)
end


composeds = map(rs) do r
    ms = Array{ComposedFunction, 1}(undef, 5)
    accumulate!(∘, ms, fill(x->f(r, x), 5), init=identity)
    p = plot(0:0.01:1, 0:0.01:1, title="r=$(r)", legend=:outerright)
    map(enumerate(ms)) do (i, m)
        plot!(0:0.01:1, m.(0:0.01:1), label="f^$(i)")
    end
    p
end

allplots = map(ps, composeds) do p, composed
    plot(p, composed, size=(1000, 375))
end

allplots[6]

plot(ps..., size=(800, 500))
plot(composed..., size=(800, 500))
