local SlyJoker = {}
SlyJoker.__index = SlyJoker

function SlyJoker.new()
    return setmetatable({ price = 3, rarity = "Common" }, SlyJoker)
end

function SlyJoker:onHandEval(hand, score)
    if hand:checkOnePair() then
        return score + 50
    end
    return score
end

return SlyJoker
