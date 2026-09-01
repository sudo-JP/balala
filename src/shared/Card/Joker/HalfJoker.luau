local HalfJoker = {}
HalfJoker.__index = HalfJoker

function HalfJoker.new()
    return setmetatable({ price = 5, rarity = "Common" }, HalfJoker)
end

function HalfJoker:onHandEval(hand, score)
    if #hand:getSelectedHand() <= 3 then
        return score + 20
    end
    return score
end

return HalfJoker
