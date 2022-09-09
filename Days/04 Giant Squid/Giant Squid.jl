lns = readlines(joinpath("Days", "04 Giant Squid", "input"))
bingo_numbers = parse.(Int, split(lns[1], ","))
lns_boards = filter(!isempty, @view(lns[3:end]))
boards = reduce(vcat, parse.(Int, split(ln))' for ln in lns_boards)
boards = [ @view(boards[idx:idx + 4,:]) for idx in 1:5:size(boards, 1) ]


function play_bingo(bingo_numbers, boards)
    tracker = [ zeros(Bool, 5, 5) for i in eachindex(boards) ]
    for draw in bingo_numbers
        for (idx, board) in enumerate(boards)
            tracker[idx][findall(isequal(draw), board)] .= true
        end
        for (idx, board) in enumerate(tracker)
            dim_1 = all(board, dims = 1)
            if any(dim_1)
                return (idx, findfirst(dim_1), draw * sum(boards[idx][.!board]))
            end
            dim_2 = all(board, dims = 2)
            if any(dim_2)
                return (idx, findfirst(dim_2), draw * sum(boards[idx][.!board]))
            end
        end
    end
end

function lose_bingo(bingo_numbers, boards)
    tracker = [ zeros(Bool, 5, 5) for i in eachindex(boards) ]
    won = zeros(Int, length(tracker))
    for draw in bingo_numbers
        for (idx, board) in enumerate(boards)
            tracker[idx][findall(isequal(draw), board)] .= true
        end
        for (idx, board) in enumerate(tracker)
            won[idx] > 0 && continue
            dim_1 = all(board, dims = 1)
            if any(dim_1)
                won[idx] = maximum(won) + 1
            else
                dim_2 = all(board, dims = 2)
                if any(dim_2)
                    won[idx] = maximum(won) + 1
                end
            end
        end
        if all(!iszero, won)
            val, idx = findmax(won)
            # println(draw)
            board = tracker[idx]
            dim_1 = all(board, dims = 1)
            # return won
            if any(dim_1)
                return (idx, findfirst(dim_1), draw * sum(boards[idx][.!board]))
            else
                dim_2 = all(board, dims = 2)
                if any(dim_2)
                    return (idx, findfirst(dim_2), draw * sum(boards[idx][.!board]))
                end
            end
        end
    end
end

play_bingo(bingo_numbers, boards)
lose_bingo(bingo_numbers, boards)
