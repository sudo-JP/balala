local JollyJoker = {}
JollyJoker.__index = JollyJoker

function JollyJoker.new()
    return setmetatable({ price = 3, rarity = "Common" }, JollyJoker)
end

function JollyJoker:onHandEval(hand, score)
    if hand:checkPair() then
        return score + 8
    end
    return score
end

return JollyJoker
