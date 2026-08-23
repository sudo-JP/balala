--!strict
local Card = require("../cards/Card")
type Suit = "Diamonds" | "Spades" | "Hearts" | "Clubs"

local Deck = {}
Deck.__index = Deck

function fisherYates<T>(array: {T})
    local rng = Random.new()
    for i = #array, 2, -1 do
        local j = rng:NextInteger(1, i)
        array[i], array[j] = array[j], array[i]
    end
end 

function Deck.new()
    local self = setmetatable({}, Deck)

    self.numberOfCards = 52
    self.currentCard = self.numberOfCards
    self.cards = table.create(self.numberOfCards)


    local suit = {
        "Diamonds",
        "Spades", 
        "Hearts",
        "Clumbs"
    }

    local pointsMap = {
        [13] = 11,
        [12] = 10,
        [11] = 10,
        [10] = 10,
    }
    
    local displayMap = {
        [13] = "A",
        [12] = "K",
        [11] = "Q",
        [10] = "J",
    }

    for i = 2, 9 do 
        displayMap[i] = tostring(i)
        pointsMap[i] = i
    end 


    -- Generate deck 
    for _, value in ipairs(suit) do

        for j = 2, 13 do 
            local points = pointsMap[j]
            local display = displayMap[j]

            local card = Card.StandardCard.new(
                value, points, j, display
            )
            
            table.insert(self.cards, card)
                
        end
    end

    fisherYates(self.cards)
end


function Deck:drawCard()
    if self.currentCard == 0 then
        fisherYates(self.cards)
        self.currentCard = self.numberOfCards
    end 
    local card = self.cards[self.currentCard]
    self.currentCard -= 1 
    return card 
end 

