local CrazyJoker = {}
CrazyJoker.__index = CrazyJoker

function CrazyJoker.new()
    return setmetatable({ price = 4, rarity = "Common" }, CrazyJoker)
end

function CrazyJoker:onHandEval(hand, score)
    if hand:checkStraight() then
        return score + 12
    end
    return score
end

return CrazyJoker
