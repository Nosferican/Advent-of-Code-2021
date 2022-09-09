using Graphs
input = readlines(joinpath("Days", "12 Passage Pathing", "input"))
input = split.(input, "-")
vertices_mp = push!(pushfirst!(setdiff!(sort!(unique!(reduce(vcat, input))), ["start", "end"]), "start"), "end")
vertices_mp = Dict(vertices_mp .=> eachindex(vertices_mp))
g = SimpleGraph(length(vertices_mp))
for edge in input
    add_edge!(g, vertices_mp[edge[1]], vertices_mp[edge[2]])
end
small_caves = sort!([ v for (k, v) in vertices_mp if contains(k, r"^\p{Ll}+$") ])

function path_to_exit(path)
    location = last(path)
    location == 11 && return
    destinations = outneighbors(g, location)
    destinations = setdiff(destinations, intersect(path, small_caves))
    for destination in destinations
        push!(paths, vcat(path, destination))
    end
    deleteat!(paths, findfirst(isequal(path), paths))
end

paths = [[1]]
while any(x -> last(x) ≠ 11, paths)
    for path in paths
        if last(path) ≠ 11
            path_to_exit(path)
        end
    end
end
paths

function path_to_exit_w_leisure(path)
    location = last(path)
    location == 11 && return
    destinations = outneighbors(g, location)
    visitations = Dict(small => length(findall(isequal(small), path)) for small in small_caves)
    already_visited = [ k for (k, v) in visitations if v > 0 ]
    if any(>(1), values(visitations))
        destinations = setdiff(destinations, already_visited)
    else
        destinations = setdiff(destinations, 1)
    end
    for destination in destinations
        push!(paths, vcat(path, destination))
    end
    deleteat!(paths, findfirst(isequal(path), paths))
end

paths = [[1]]
while any(x -> last(x) ≠ 11, paths)
    for path in paths
        if last(path) ≠ 11
            path_to_exit_w_leisure(path)
        end
    end
end
paths
