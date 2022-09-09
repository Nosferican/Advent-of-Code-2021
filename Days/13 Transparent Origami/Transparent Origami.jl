input = readlines(joinpath("Days", "13 Transparent Origami", "input"))

coords = [ CartesianIndex(reverse(parse.(Int, split(ln, ",")) .+ 1)...) for ln in @view(input[1:findfirst(isempty, input) - 1]) ]

fold_instructions = [ ln[12] == 'x' ? 2 : 1 for ln in @view(input[findfirst(isempty, input) + 1:end]) ]

function fold(obj, dim)
    @assert dim ∈ 1:2
    if dim == 1
        @views reverse(obj[size(obj, 1) ÷ 2 + 2:end,:], dims = 1) .| obj[1:size(obj, 1) ÷ 2,:]
    else
        @views reverse(obj[:,size(obj, 2) ÷ 2 + 2:end], dims = 2) .| obj[:,1:size(obj, 2) ÷ 2]
    end
end

obj = falses(Tuple(maximum(reduce(hcat, collect.(Tuple.(coords))), dims = 2)))
obj[coords] .= true

sum(fold(obj, fold_instructions[1]))

for instruction in fold_instructions
    obj = fold(obj, instruction)
end

for row in eachrow(ifelse.(obj, "#", "."))
    println(join(row, ""))
end
