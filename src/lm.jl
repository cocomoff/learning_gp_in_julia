using DelimitedFiles
using LinearAlgebra
using Plots
gr()

const N = 200
const xmin = 4
const ymin = 2

phi(x) = [1, x, x * x, sin(x), cos(x)]

function regplot(data)
    n = size(data, 1)
    X = zeros(n, 5)
    for j in 1:n
        X[j, :] = phi(data[j, 1])
    end
    y = data[:, 2]
    w = inv(transpose(X) * X) * transpose(X) * y
    println(w)
    # w = multiple_regression(data)
    # xx = range(xmin, xmax, length = M)
    # yy = range(ymin, ymax, length = M)
    # zfunc = (x, y) -> w[1] + w[2] * x + w[3] * y

    xx = range(-xmin, xmin, length = N)
    yy = zeros(N)
    for j in 1:N
        yy[j] = sum(w .* phi(xx[j]))
    end

    # plot
    f = plot(size = (500, 300), xlim = (-xmin, xmin), ylim = (-ymin, ymin))
    scatter!(data[:, 1], data[:, 2], color = :blue, marker = :xcross, label = nothing)
    plot!(f, xx, yy, color = :tomato, label = "reg")
    savefig(f, "output/lm.png")
    f
end


function main()
    data = readdlm("./data_web/nonlinear.dat")
    regplot(data)
end


main()