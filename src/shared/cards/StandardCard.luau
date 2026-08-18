local Card = require(script.Parent.Card)

type Suit = Card.Suit
type CardValue = Card.CardValue

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
