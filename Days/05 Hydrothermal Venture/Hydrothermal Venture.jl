lns = readlines(joinpath("Days", "05 Hydrothermal Venture", "input"))

points = NTuple{2, Int}[]

for ln in lns
    x₀, y₀, x₁, y₁ = [ parse(Int, x.match) for x in eachmatch(r"\d+", ln) ]
    if x₀ == x₁
        append!(points, (x₀, y) for y in min(y₀, y₁):max(y₀, y₁))
    elseif y₀ == y₁
        append!(points, (x, y₀) for x in min(x₀, x₁):max(x₀, x₁))
    end
end

counter = Dict{NTuple{2, Int}, Int}()
for point in points
    counter[point] = get(counter, point, 0) + 1
end

count(>(1), values(counter))

empty!(points)
for ln in lns
    x₀, y₀, x₁, y₁ = [ parse(Int, x.match) for x in eachmatch(r"\d+", ln) ]
    if x₀ == x₁
        append!(points, (x₀, y) for y in min(y₀, y₁):max(y₀, y₁))
    elseif y₀ == y₁
        append!(points, (x, y₀) for x in min(x₀, x₁):max(x₀, x₁))
    else
        if x₀ < x₁ && y₀ < y₁
            x = x₀:x₁
            y = y₀:y₁
        elseif x₀ < x₁ && y₀ > y₁
            x = x₀:x₁
            y = y₀:-1:y₁
        elseif x₀ > x₁ && y₀ < y₁
            x = x₀:-1:x₁
            y = y₀:y₁
        elseif x₀ > x₁ && y₀ > y₁
            x = x₀:-1:x₁
            y = y₀:-1:y₁
        end
        append!(points, (x, y) for (x, y) in zip(x, y))
    end
end
empty!(counter)
for point in points
    counter[point] = get(counter, point, 0) + 1
end

count(>(1), values(counter))
