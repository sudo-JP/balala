local Card = require(script.Parent.Parent.cards.Card)
type Suit = "Diamonds" | "Spades" | "Hearts" | "Clubs"

local Deck = {}
Deck.__index = Deck

function Deck.new()
    local self = setmetatable({}, Deck)

    local numbers_of_cards = 52
    self.cards = table.create(numbers_of_cards)


    local suit = {
        "Diamonds",
        "Spades", 
        "Hearts",
        "Clumbs"
    }

    local i = 1
    for _, value in ipairs(suit) do
        suit[i] = value
    end

end 
