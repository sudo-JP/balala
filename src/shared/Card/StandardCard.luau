--!strict
local CardModule = require("./Types")

type Suit = CardModule.Suit
type CardValue = CardModule.CardValue

local StandardCard = {}
StandardCard.__index = StandardCard

function StandardCard.new(suit: Suit, rank: number, points: number, display: string): CardValue
    return setmetatable({
        suit = suit,
        rank = rank,
        points = points,
        display = display,
    }, StandardCard)
end

function StandardCard:eval(): CardValue
    return self
end

return StandardCard
