local MadJoker = {}
MadJoker.__index = MadJoker

function MadJoker.new()
    return setmetatable({ price = 4, rarity = "Common" }, MadJoker)
end

function MadJoker:onHandEval(hand, score)
    if hand:checkTwoPair() then
        return score + 10
    end
    return score
end

return MadJoker
