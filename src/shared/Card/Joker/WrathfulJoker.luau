local WrathfulJoker = {}
WrathfulJoker.__index = WrathfulJoker

function WrathfulJoker.new()
    return setmetatable({ price = 5, rarity = "Common" }, WrathfulJoker)
end

function WrathfulJoker:onHandEval(hand, score)
    local cards = hand:getSelectedHand()
    for _, val in ipairs(cards) do
        if val.suit == "Spade" then
            score += 3
        end
    end
    return score
end

return WrathfulJoker
