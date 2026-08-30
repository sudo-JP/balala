local GreedyJoker = {}
GreedyJoker.__index = GreedyJoker

function GreedyJoker.new()
    return setmetatable({ price = 5 }, GreedyJoker)
end

function GreedyJoker:onHandEval(hand, score)
    local cards = hand:getSelectedHand()
    for _, val in ipairs(cards) do
        if val.suit == "Diamond" then
            score += 3
        end
    end
    return score
end

return GreedyJoker
