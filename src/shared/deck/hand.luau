--!strict
local Hand = {}
Hand.__index = Hand
export type Hand = typeof(Hand) 


function Hand.new() 
    local self = setmetatable({}, Hand)
    self.currentHand = {}
    self.selectedHand = {}
end 

function Hand:DrawCardFromDeck(deck: Deck)
    table.insert(self.currentHand, deck:DrawCard())
end 


return Hand
