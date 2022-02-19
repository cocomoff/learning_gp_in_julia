using DelimitedFiles
using LinearAlgebra
using Plots
gr()

const M = 20
const xmin, xmax = -2.5, 3.5
const ymin, ymax = -1, 3.5
const datapath = "./data_web/linear.dat"

function simple_plot(x, y)
    f = plot(size = (500, 300), xlim = (xmin, xmax), ylim = (ymin, ymax))
    N = length(x)
    X = [ones(N) x]
    w = inv(transpose(X) * X) * transpose(X) * y
    xx = range(xmin, xmax, length = M)
    yy = w[1] .+ w[2] .* xx
    plot!(f, xx, yy, color = :tomato, lw = 2, label = "regression")
    scatter!(f, x, y, markersize = 12, marker = :xcross, color = :black, label = nothing)
    savefig(f, "output/simple.png")
    f
end


function main()
    data = readdlm(datapath)
    simple_plot(data[:, 1], data[:, 2])
end


main()