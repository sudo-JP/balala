local CraftyJoker = {}
CraftyJoker.__index = CraftyJoker

function CraftyJoker.new()
    return setmetatable({ price = 4, rarity = "Common" }, CraftyJoker)
end

function CraftyJoker:onHandEval(hand, score)
    if hand:checkFlush() then
        return score + 80
    end
    return score
end

return CraftyJoker
