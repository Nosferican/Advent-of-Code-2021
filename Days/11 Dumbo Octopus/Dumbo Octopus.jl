input = readlines(joinpath("Days", "11 Dumbo Octopus", "input"))
input = split.(input, "")
input = [ parse.(Int, ln) for ln in input ]
input = reduce(hcat, input)'

ln10x10 = LinearIndices(input)

function find_neighbors(xy::CartesianIndex)
    x, y = Tuple(xy)
    neighborhood = [xy]
    can_left = x > 1
    can_right = x < 10
    can_up = y > 1
    can_down = y < 10
    if can_left
        push!(neighborhood, CartesianIndex(x - 1, y))
    end
    if can_up
        push!(neighborhood, CartesianIndex(x, y - 1))
    end
    if can_right
        push!(neighborhood, CartesianIndex(x + 1, y))
    end
    if can_down
        push!(neighborhood, CartesianIndex(x, y + 1))
    end
    if can_left && can_up
        push!(neighborhood, CartesianIndex(x - 1, y - 1))
    end
    if can_left && can_down
        push!(neighborhood, CartesianIndex(x - 1, y + 1))
    end
    if can_right && can_up
        push!(neighborhood, CartesianIndex(x + 1, y - 1))
    end
    if can_right && can_down
        push!(neighborhood, CartesianIndex(x + 1, y + 1))
    end
    ln10x10[neighborhood]
end

neighborhood = find_neighbors.(eachindex(input))

function take_step(obj)
    obj = copy(obj)
    obj .+= 1
    flash = zeros(Bool, size(obj))
    isdone = false
    while !isdone
        isdone = true
        for idx in eachindex(obj)
            if obj[idx] > 9 && !flash[idx]
                for neighbors in neighborhood[idx]
                    obj[neighbors] += 1
                end
                flash[idx] = true
                isdone = false
            end
        end
    end
    obj[flash] .= 0
    obj, sum(flash)
end

tot = 0
obj = input
for step in 1:100
    obj, tot
    obj, flashes = take_step(obj)
    tot += flashes
end
tot

obj = input
idx = 0
while true
    obj, idx
    obj, flashes = take_step(obj)
    idx += 1
    flashes == 100 && break
end
idx
