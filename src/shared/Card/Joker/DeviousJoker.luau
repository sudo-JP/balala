local DeviousJoker = {}
DeviousJoker.__index = DeviousJoker

function DeviousJoker.new()
    return setmetatable({ price = 4, rarity = "Common" }, DeviousJoker)
end

function DeviousJoker:onHandEval(hand, score)
    if hand:checkStraight() then
        return score + 100
    end
    return score
end

return DeviousJoker
