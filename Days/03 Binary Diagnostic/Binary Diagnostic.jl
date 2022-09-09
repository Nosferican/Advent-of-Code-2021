
inputs = reduce(hcat, split(x, "") for x in eachline(joinpath(joinpath("Days", "03 Binary Diagnostic", "inputs"))))
inputs = permutedims(inputs .== "1", 1:2)
most_common = vec(count(inputs, dims = 2) .> 500)

parse(Int, join(convert(Vector{Int}, most_common)), base = 2) *
parse(Int, join(convert(Vector{Int}, .!most_common)), base = 2)

x = copy(inputs)
for c in axes(x, 1)
    majority_bit = count(@view(x[c,:])) ≥ size(x, 2) / 2
    x = x[:,x[c,:] .== majority_bit]
    size(x, 2) == 1 && break
end
oxygen_generator_rating = parse(Int, join(convert(Vector{Int}, vec(x))), base = 2)

x = copy(inputs)
for c in axes(x, 1)
    majority_bit = count(@view(x[c,:])) < size(x, 2) / 2
    x = x[:,x[c,:] .== majority_bit]
    size(x, 2) == 1 && break
end
co2_scrubber_rating = parse(Int, join(convert(Vector{Int}, vec(x))), base = 2)

oxygen_generator_rating * co2_scrubber_rating
