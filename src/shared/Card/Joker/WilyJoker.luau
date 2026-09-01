local WilyJoker = {}
WilyJoker.__index = WilyJoker

function WilyJoker.new()
    return setmetatable({ price = 4, rarity = "Common" }, WilyJoker)
end

function WilyJoker:onHandEval(hand, score)
    if hand:checkThreeOfAKind() then
        return score + 100
    end
    return score
end

return WilyJoker
