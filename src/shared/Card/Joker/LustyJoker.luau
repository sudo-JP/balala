local LustyJoker = {}
LustyJoker.__index = LustyJoker

function LustyJoker.new()
    return setmetatable({ price = 5, rarity = "Common" }, LustyJoker)
end

function LustyJoker:onHandEval(hand, score)
    local cards = hand:getSelectedHand()
    for _, val in ipairs(cards) do
        if val.suit == "Heart" then
            score += 3
        end
    end
    return score
end

return LustyJoker
