input = joinpath("Days", "02 Dive!", "input")

x = 0
y = 0
for move in eachline(input)
    if startswith(move, "f")
        x += parse(Int, move[end])
    elseif startswith(move, "b")
        x -= parse(Int, move[end])
    elseif startswith(move, "d")
        y += parse(Int, move[end])
    elseif startswith(move, "u")
        y -= parse(Int, move[end])
    end
end
x * y

x = 0
y = 0
aim = 0
for move in eachline(input)
    m = parse(Int, move[end])
    if startswith(move, "f")
        x += m
        y += aim * m
    elseif startswith(move, "d")
        aim += m
    elseif startswith(move, "u")
        aim -= m
    end
end
x * y
