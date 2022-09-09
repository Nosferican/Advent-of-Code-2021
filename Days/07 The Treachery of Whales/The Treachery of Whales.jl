input = readline(joinpath("Days", "07 The Treachery of Whales", "input"))
input = [ parse(Int, x) for x in split(input, ",") ]

costs = [ sum(abs(x - i) for x in input) for i in eachindex(input) ]
findmin(costs)

costs = [ sum(abs(x - i) * (abs(x - i) + 1) ÷ 2 for x in input) for i in eachindex(input) ]
findmin(costs)
