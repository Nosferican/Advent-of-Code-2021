input = readline(joinpath("Days", "06 Lanternfish", "input"))
input = [ parse(Int, x) for x in split(input, ",") ]
gen₀ = Dict{Int, Int}()
for fish in input
    gen₀[fish] = get(gen₀, fish, 0) + 1
end
gen₁ = Dict{Int, Int}()

for day in 1:80
    x = get(gen₀, 0, 0)
    for stage in 1:8
        gen₁[stage - 1] = get(gen₀, stage, 0)
    end
    gen₁[8] = x
    gen₁[6] += x
    gen₀ = copy(gen₁)
end
sum(values(gen₁))

empty!(gen₀)
empty!(gen₁)
for fish in input
    gen₀[fish] = get(gen₀, fish, 0) + 1
end

for day in 1:256
    x = get(gen₀, 0, 0)
    for stage in 1:8
        gen₁[stage - 1] = get(gen₀, stage, 0)
    end
    gen₁[8] = x
    gen₁[6] += x
    gen₀ = copy(gen₁)
end
sum(values(gen₁))
