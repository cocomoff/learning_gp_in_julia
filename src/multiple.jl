using DelimitedFiles
using LinearAlgebra
using Plots
gr()

const M = 20
const xmin, xmax = -2.5, 3.5
const ymin, ymax = -1, 3.5
const datapath = "./data_web/multiple.dat"

function multiple_regression(data)
    N = size(data, 1)
    X = [ones(N) data[:, 1:end-1]]
    y = data[:, end]
    return inv(transpose(X) * X) * transpose(X) * y
end


function multiple_plot(data)
    w = multiple_regression(data)
    xx = range(xmin, xmax, length = M)
    yy = range(ymin, ymax, length = M)
    zfunc = (x, y) -> w[1] + w[2] * x + w[3] * y

    # plot
    f = plot(size = (500, 300))
    surface!(f, xx, yy, zfunc, alpha = 0.3)
    scatter!(data[:, 1], data[:, 2], data[:, 3], color = :blue, marker = :xcross, label = nothing)
    savefig(f, "output/multiple.png")
    f
end


function main()
    data = readdlm(datapath)
    multiple_plot(data)
end


main()