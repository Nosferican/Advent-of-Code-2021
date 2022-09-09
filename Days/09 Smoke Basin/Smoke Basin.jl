using Graphs

input = readlines(joinpath("Days", "09 Smoke Basin", "input"))
input = split.(input, "")
input = reduce(hcat, input)
input = parse.(Int, input)'

ln100x100 = LinearIndices(input)

function find_neighbors(xy::CartesianIndex)
    x, y = Tuple(xy)
    neighborhood = [xy]
    if x > 1
        push!(neighborhood, CartesianIndex(x - 1, y))
    end
    if y > 1
        push!(neighborhood, CartesianIndex(x, y - 1))
    end
    if x < 100
        push!(neighborhood, CartesianIndex(x + 1, y))
    end
    if y < 100
        push!(neighborhood, CartesianIndex(x, y + 1))
    end
    ln100x100[neighborhood]
end

neighborhoods = vec(find_neighbors.(eachindex(input)))
vals = getindex.(Ref(input), neighborhoods)
dest_val = minimum.(vals)
pos = [ v < 9 ? h[findall(isequal(v), vs)] : Int[] for (v, vs, h) in zip(dest_val, vals, neighborhoods) ]
g = SimpleDiGraph(length(input))
for (v, (node, edges)) in zip(input, enumerate(pos))
    if v < 9
        for edge in edges
            add_edge!(g, node, edge)
        end
    end
end

sum(input[v] + 1 for v in vertices(g) if outneighbors(g, v) == [v])

prod(sort!(length.(connected_components(g)), rev = true)[1:3])
