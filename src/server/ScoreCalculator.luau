local ScoreCalculator = {}

function ScoreCalculator.calculateHand(hand, jokers)
    local chip = 0
    local handResult = hand.getHandResult()

    for _, card in ipairs(handResult.cards) do
        for _, joker in ipairs(jokers) do

        end
    end
end

return ScoreCalculator
