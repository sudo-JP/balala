local CleverJoker = {}
CleverJoker.__index = CleverJoker

function CleverJoker.new()
    return setmetatable({ price = 4, rarity = "Common" }, CleverJoker)
end

function CleverJoker:onHandEval(hand, score)
    if hand:checkTwoPair() then
        return score + 80
    end
    return score
end

return CleverJoker
