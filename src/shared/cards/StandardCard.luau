local CardModule = require(script.Parent.Card)


type Suit = typeof(CardModule.Suit)
type CardValue = typeof(CardModule.CardValue)

local StandardCard = {}
StandardCard.__index = StandardCard

function StandardCard.new(suit: Suit, rank: number): CardValue
    return setmetatable({
        suit = suit,
        rank = rank,
    }, StandardCard)
end

function StandardCard:eval(): CardValue
    return self
end

return StandardCard
