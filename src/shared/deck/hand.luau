--!strict
local Hand = {}
Hand.__index = Hand
export type Hand = typeof(Hand) 

local PokerHandRankings = table.freeze({
    HighCard = "HighCard",
    OnePair = "OnePair",
    TwoPair = "TwoPair",
    ThreeOfAKind = "ThreeOfAKind",
    Straight = "Straight",
    Flush = "Flush",
    FullHouse = "FullHouse",
    FourOfAKind = "FourOfAKind",
    StraightFlush = "StraightFlush",
    RoyalFlush = "RoyalFlush",
})

type PokerHandRankings = typeof(PokerHandRankings.HighCard) 
    | typeof(PokerHandRankings.OnePair)
    | typeof(PokerHandRankings.TwoPair)
    | typeof(PokerHandRankings.ThreeOfAKind)
    | typeof(PokerHandRankings.Straight)
    | typeof(PokerHandRankings.Flush)
    | typeof(PokerHandRankings.FullHouse)
    | typeof(PokerHandRankings.FourOfAKind)
    | typeof(PokerHandRankings.StraightFlush)
    | typeof(PokerHandRankings.RoyalFlush)

function Hand.new() 
    local self = setmetatable({}, Hand)
    self.currentHand = {}
    self.selectedHand = {}
end 

function Hand:DrawCardFromDeck(deck: Deck)
    table.insert(self.currentHand, deck:DrawCard())
end 

function Hand:SelectCard(cardIndex: number) 
    local card = table.remove(self.currentHand, cardIndex)
    if card == nil then 
        return 
    end 

    table.insert(self.selectedHand, card)
    self:pokerRankings()
end

-- Helper for nicer index
local function addCheck(func, rank)
    return { func = func, rank = rank }
end

function Hand:pokerRankings()
    local checks = {
        addCheck(self.CheckHighCard, PokerHandRankings.HighCard)

    }

    for _, entry in ipairs(checks) do
        if entry[1](self) then return entry[2] end
    end 
    return ""
end 

-- High card
function Hand:CheckHighCard()
    if #self.selectedHand == 1 then 
        return true
    end 
    return false
end

-- One pair
function Hand:CheckOnePair()
    if #self.selectedHand == 2 
        and self.selectedHand[1].rank == self.selectedHand[2].rank
    then return true
    end
    return false
end 

-- Helper for pairing
function Hand:sameRank(n)
    if #self.selectedHand <= n then 
        return false
    end

    local flag = false
    local count = 0 
    for _, value in ipairs(self.selectedHand) do 

    end
end 

-- Two pair
function Hand:CheckTwoPair()
    if #self.selectedHand == 2 then 
        local card1 = self.selectedHand[1].rank 
        local card2 = self.selectedHand[2].rank
        if card1.rank == card2.rank 
            and card1.suit == card2.suit 
        then return true end
    end
    return false
end

function Hand:ThreeOfAKind()
end 

return Hand
