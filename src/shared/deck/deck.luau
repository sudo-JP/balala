--!strict
local Card = require("../Card")
local CardTypes = require("../Card/Types")
local inplaceRandomizeArray = require("../Utils")

type Suit = CardTypes.Suit
type CardValue = CardTypes.CardValue

local Deck = {}
Deck.__index = Deck

export type Deck = {
    numberOfCards: number,
    currentCard: number,
    cards: {CardValue},
    drawCard: (self: Deck) -> CardValue,
}

function Deck.new(): Deck
    local self: Deck = setmetatable({
        numberOfCards = 52,
        currentCard = 52,
        cards = table.create(52) :: {CardValue},
    }, Deck) :: Deck

    local suits: {Suit} = {
        "Diamond",
        "Spade",
        "Heart",
        "Club",
    }

    local pointsMap: {[number]: number} = {
        [13] = 11,
        [12] = 10,
        [11] = 10,
        [10] = 10,
    }

    local displayMap: {[number]: string} = {
        [13] = "A",
        [12] = "K",
        [11] = "Q",
        [10] = "J",
    }

    for i = 2, 9 do
        displayMap[i] = tostring(i)
        pointsMap[i] = i
    end

    for _, suit in ipairs(suits) do
        for rank = 2, 13 do
            local points = pointsMap[rank]
            local display = displayMap[rank]

            local card = Card.StandardCard.new(
                suit,
                rank,
                points,
                display
            )

            table.insert(self.cards, card)
        end
    end

    inplaceRandomizeArray(self.cards)
    return self
end

function Deck.drawCard(self: Deck): CardValue
    if self.currentCard == 0 then
        fisherYates(self.cards)
        self.currentCard = self.numberOfCards
    end

    local card = self.cards[self.currentCard]
    self.currentCard -= 1
    return card
end

return Deck
