--!strict
local Hand = {}
Hand.__index = Hand
export type Hand = typeof(Hand) 

type PokerHandRankings = "HighCard" 
    | "OnePair"
    | "TwoPair"
    | "ThreeOfAKind"
    | "Straight"
    | "Flush"
    | "FullHouse"
    | "FourOfAKind"
    | "StraightFlush"
    | "RoyalFlush"

function Hand.new() 
    local self = setmetatable({}, Hand)
    self.currentHand = {}
    self.selectedHand = {}
end 

function Hand:DrawCardFromDeck(deck: Deck)
    table.insert(self.currentHand, deck:DrawCard())
end 

function Hand:pokerRankings()
    local checks = {
        {self.CheckHighCard, PokerHandRankings.HighCard}
    }

    for _, entry in ipairs(checks) do
        if entry[1](self) then return entry[2] end
    end 
end 

function Hand:CheckHighCard()
    if #self.selectedHand == 1 then 
        return true
    end 
    return false
end

function Hand:CheckOnePair()
    if #self.selectedHand == 2 
        and self.selectedHand[1].rank == self.selectedHand[2].rank
    then return true
    end
    return false
end 

function Hand:CheckTwoPair()
    if #self.selectedHand == 2 then 
        local card1 = self.selectedHand[1].rank 
        local card2 = self.selectedHand[2].rank
        if card1.rank == card2.rank 
            and card1.suit == card2.suit 
        then return true 
    end
    return false
end

function Hand:SelectCard(cardIndex: number) 
    local card = table.remove(self.currentHand, cardIndex)
    if card == nil then 
        return 
    end 

    table.insert(self.selectedHand, card)
    self:pokerRankings()
end

return Hand
