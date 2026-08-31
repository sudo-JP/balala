local Joker = {}
Joker.__index = Joker

function Joker.new()
    return setmetatable({ price = 2, rarity = "Common" }, Joker)
end

function Joker:onHandEval(hand, score)
    return score + 4
end

return Joker
