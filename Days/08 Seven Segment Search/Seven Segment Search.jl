input = readlines(joinpath("Days", "08 Seven Segment Search", "input"))
input = split.(input, " | ")
vals = split.(last.(input), " ")
input_code = split.(first.(input), " ")

n = reduce(vcat, [ length.(x) for x in vals ])
count(∈((2, 3, 4, 7)), n)

function crack_the_code(input, )
    
end

abstract type SevenSegmentDigit end

obj = input_code[1]

function decode_pattern(obj, vals)
    lens = length.(obj)
    l_lens = [ count(contains(x, l) for x in obj) for l in 'a':'g' ]

    bl = ('a':'g')[findfirst(isequal(4), l_lens)]
    tl = ('a':'g')[findfirst(isequal(6), l_lens)]
    br = ('a':'g')[findfirst(isequal(9), l_lens)]
    num_one = obj[findfirst(isequal(2), lens)]
    four = obj[findfirst(isequal(4), lens)]
    seven = obj[findfirst(isequal(3), lens)]
    eight = obj[findfirst(isequal(7), lens)]
    t = setdiff(seven, num_one)
    tr = only(setdiff(@view(('a':'g')[findall(isequal(8), l_lens)]), t))
    m = only(setdiff(setdiff(four, num_one), tl))
    b = only(setdiff(@view(('a':'g')[findall(isequal(7), l_lens)]), m))
    allbutone = filter(x -> length(x) == 6, obj)
    six = only(filter(!contains(tr), allbutone))
    five = only(filter(x -> length(x) == 5 && all(contains(six, y) for y in x), obj))
    nine = only(filter(x -> all(contains(x, y) for y in vcat(split(five, ""), string(tr))), allbutone))
    num_zero = only(filter(x -> length(x) == 6 && !contains(x, m), obj))
    two_three = filter(∉([num_zero, num_one, four, five, six, seven, eight, nine]), obj)
    two = only(filter(contains(bl), two_three))
    three = only(filter(contains(br), two_three))
    decoder = Dict(
        join.(sort.(split.([num_zero, num_one, two, three, four, five, six, seven, eight, nine], ""))) .=> 0:9)
    parse(Int, join(decoder[join(sort(split(x, "")))] for x in vals))
end

sum(decode_pattern(x, y) for (x, y) in zip(input_code, vals))
