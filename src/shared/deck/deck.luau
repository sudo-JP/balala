--!strict
local Card = require("../cards/Card")
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

    local rank_map = {
        [13] = 11,
        [12] = 10,
        [11] = 10,
        [10] = 10,
    }
    
    local display_map = {
        [13] = "A",
        [12] = "Q",
        [11] = "K",
        [10] = "J",
    }

    for i = 2, 9 do 
        display_map[i] = tostring(i)
        rank_map[i] = i
    end 


    local i = 1
    for _, value in ipairs(suit) do

        for j = 2, 13 do 
            local rank = rank_map[j]

            local display = display_map[j]

            local card = Card.CardValue {
                rank = rank,
                display = display, 
                suit = value, 
            }
            self.cards[i] = card 
                
        end

        i += 1
    end

end 
