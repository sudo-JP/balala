local GluttonousJoker = {}
GluttonousJoker.__index = GluttonousJoker

function GluttonousJoker.new()
    return setmetatable({ price = 5, rarity = "Common" }, GluttonousJoker)
end

function GluttonousJoker:onHandEval(hand, score)
    local cards = hand:getSelectedHand()
    for _, val in ipairs(cards) do
        if val.suit == "Spade" then
            score += 3
        end
    end
    return score
end

return GluttonousJoker
