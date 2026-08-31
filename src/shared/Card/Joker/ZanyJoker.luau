local ZanyJoker = {}
ZanyJoker.__index = ZanyJoker

function ZanyJoker.new()
    return setmetatable({ price = 4, rarity = "Common" }, ZanyJoker)
end

function ZanyJoker:onHandEval(hand, score)
    if hand:checkThreeOfAKind() then
        return score + 12
    end
    return score
end

return ZanyJoker
