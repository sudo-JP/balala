local DrollJoker = {}
DrollJoker.__index = DrollJoker

function DrollJoker.new()
    return setmetatable({ price = 4, rarity = "Common" }, DrollJoker)
end

function DrollJoker:onHandEval(hand, score)
    if hand:checkFlush() then
        return score + 10
    end
    return score
end

return DrollJoker
