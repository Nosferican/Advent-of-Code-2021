input = readlines(joinpath("Days", "10 Syntax Scoring", "input"))

const OPENERS = ['(', '[', '{', '<']
const CLOSERS = [')', ']', '}', '>']

const O2C = Dict(OPENERS .=> CLOSERS)

const SCORES = Dict(CLOSERS .=> [3, 57, 1_197, 25_137])
const FIXSCORES = Dict(CLOSERS .=> 1:4)

function score_illegal(ln)
    openers = Char[]
    for c in ln
        if c ∈ OPENERS
            push!(openers, c)
        elseif OPENERS[findfirst(isequal(c), CLOSERS)] == last(openers)
            deleteat!(openers, lastindex(openers))
        else
            return SCORES[c]
        end
    end
    0
end
scores = sum(score_illegal, input)

legal = filter(iszero ∘ score_illegal, input)

function score_incomplete(ln)
    openers = Char[]
    for c in ln
        if c ∈ OPENERS
            push!(openers, c)
        else
            deleteat!(openers, lastindex(openers))
        end
    end
    tot = 0
    for c in [ O2C[k] for k in reverse(openers) ]
        tot *= 5
        tot += FIXSCORES[c]
    end
    tot
end

scores_complete = sort!(score_incomplete.(legal))
scores_complete[length(scores_complete) ÷ 2 + 1]

findfirst(isequal('}'), CLOSERS)
