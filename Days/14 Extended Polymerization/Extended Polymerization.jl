input = readlines(joinpath("Days", "14 Extended Polymerization", "input"))

template = input[1]
# rules = [ rule[1:2] => string(rule[1], rule[end], rule[2]) for rule in input[3:end] ]

rules = [ Regex("(?<=$(rule[1]))\\w{0}(?=$(rule[2]))") => SubstitutionString("$(rule[1])$(rule[end])$(rule[2])") for rule in input[3:end] ]
rules = Dict(rule[1:2] => string(rule[1], rule[end], rule[2]) for rule in input[3:end])

chain = template
chain = "VOKKVOV"

elements = split(chain, "")
pats = [ chain[idx:nextind(elements, idx)] for idx in eachindex(elements) if idx ≠ lastindex(elements) ]

ls = first(first(pats))
rs = last(last(pats))
g₀ = Dict{String,Int}()
for pat in pats
    g₀[pat] = get(g₀, pat, 0) + 1
end
g₁ = Dict{String,Int}()
for (k, v) in g₀
    new_edges = get(rules, k, k)
    if length(new_edges) == 2
        g₁[new_edges] = get(g₁, new_edges, 0) + v
    else
        x = new_edges[1:2]
        g₁[x] = get(g₁, x, 0) + v
        y = new_edges[2:3]
        g₁[y] = get(g₁, y, 0) + v
    end
end

function polymerization(g₀::AbstractDict, rules)
    g₁ = Dict{String,Int}()
    for (k, v) in g₀
        new_edges = get(rules, k, k)
        if length(new_edges) == 2
            g₁[new_edges] = get(g₁, new_edges, 0) + v
        else
            x = new_edges[1:2]
            g₁[x] = get(g₁, x, 0) + v
            y = new_edges[2:3]
            g₁[y] = get(g₁, y, 0) + v
        end
    end
    g₁
end
function polymerization(chain::AbstractString, rules)
    elements = split(chain, "")
    pats = [ chain[idx:nextind(elements, idx)] for idx in eachindex(elements) if idx ≠ lastindex(elements) ]
    ls = first(first(pats))
    rs = last(last(pats))
    g₀ = Dict{String,Int}()
    for pat in pats
        g₀[pat] = get(g₀, pat, 0) + 1
    end
    g₁ = Dict{String,Int}()
    for (k, v) in g₀
        new_edges = get(rules, k, k)
        if length(new_edges) == 2
            g₁[new_edges] = get(g₁, new_edges, 0) + v
        else
            x = new_edges[1:2]
            g₁[x] = get(g₁, x, 0) + v
            y = new_edges[2:3]
            g₁[y] = get(g₁, y, 0) + v
        end
    end
    g₁, ls, rs
end

g₁, ls, rs = polymerization(chain, rules)

for idx in 2:10
    g₁ = polymerization(g₁, rules)
end

vs = Dict{Char,Int}()
for (k, v) in g₁
    for c in k
        vs[c] = get(vs, c, 0) + v
    end
end
for k in keys(vs)
    vs[k] ÷= 2
end
vs[ls] += 1
vs[rs] += 1
reduce(-, reverse(extrema(values(vs))))

function step_in_chain(chain, rules)
    input_chain = chain
    elements = split(input_chain, "")
    pats = [ input_chain[idx:nextind(elements, idx)] for idx in eachindex(elements) if idx ≠ lastindex(elements) ]
    pats .= get.(Ref(rules), pats, pats)
    pats[2:end] .= @views SubString.(pats[2:end], 2, length.(pats[2:end]))
    join(pats, "")
end
chain = step_in_chain(chain, rules)

for step in 1:10
    println(step)
    chain = step_in_chain(chain, rules)
end

for step in 1:10
    chain = join(
        (
            begin
                x = get(
                    rules,
                    chain[i:nextind(chain, i)],
                    chain[i:nextind(chain, i)]
                    )
                if i > 1
                    x[2:end]
                else
                    x
                end 
            end
        for i in firstindex(chain):prevind(chain, lastindex(chain))),
        "")
end
# NCNBCHB
counter = Dict{Char, Int}()
for element in chain
    x = get(counter, element, 0) 
    counter[element] = x + 1
end

reduce(-, reverse(extrema(values(counter))))
counter
#=
B 4
K 7
F 3
P 2
C 5
V 6
S 3
N 3
O 6
=#
