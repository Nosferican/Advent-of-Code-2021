input = joinpath("Days", "01 Sonar Sweep", "input")
input = [ parse(Int, x) for x in eachline(input) ]
count(input[x] < input[x + 1] for x in 1:length(input) - 1)
count(input[x] < input[x + 3] for x in 1:length(input) - 3)
