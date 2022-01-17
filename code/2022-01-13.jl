using Plots

shift(x, k=2) = k*x % 1
tent(x, k=2) = 1 - k*abs(x-1/2)

iterated_map(f, n)= reduce(∘, fill(f, n))

plot(
    map(1:4) do i
        plot(
            0:0.0001:1,
            iterated_map(tent, i), 
            xaxis="f^$(i), Tent"
        )
    end...,
)

plot(
    map(1:4) do i
        plot(
            0:0.0001:1,
            iterated_map(shift, i), 
            xaxis="f^$(i), Shift"
        )
    end...,
)

function time_series(f, n, xinit)
    accumulate(1:n, init=xinit) do k, n
        f(k)
    end
end

plot([plot(time_series(i->tent(i), 100, 0.3), title="Tent"),
plot(time_series(i->tent(i, 1.99999), 100, 0.3), title="Tent 1.99"),
plot(time_series(i->shift(i), 100, 0.3), title="Shift"),
plot(time_series(i->shift(i, 1.99999), 100, 0.3), title="Shift 1.99999")
]...)