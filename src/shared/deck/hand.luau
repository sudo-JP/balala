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
function Hand:checkHighCard()
    if #self.selectedHand > 0 then 
        return true
    end 
    return false
end

-- Helper that creates a map contains the count 
-- of rank appearance, and its adjacent sorted keys array
function Hand:buildAndSortRankMap()
    local map = {}
    local keys = {}

    -- Populate map 
    for _, value in ipairs(self.selectedHand) do 
        -- value.rank 
        map[value.rank] = (map[value.rank] or 0) + 1
        table.insert(keys, value.rank)
    end

    -- Sort 
    table.sort(keys, function(a, b)
        return map[a] > map[b]
    end)
    return {map = map, keys = keys}
end 

-- Helper for same rank
function Hand:sameRank(n)
    if n <= 0 or #self.selectedHand < n then 
        return false
    end

    local mapAndKeys: {map: {[number]: number}, keys: {number}} = self:buildAndSortRankMap()
    local map = mapAndKeys.map
    local keys = mapAndKeys.keys

    return map[keys[1]] >= n
end 

-- One pair
function Hand:checkOnePair()
    return self:sameRank(2)
end 

-- A pair with same rank and 
-- another pair of same rank. 
-- They should diff in rank
function Hand:checkTwoPair()
    if #self.selectedHand < 4 then 
        return false
    end

    local mapAndKeys: {map: {[number]: number}, keys: {number}} = self:buildAndSortRankMap()
    local map = mapAndKeys.map
    local keys = mapAndKeys.keys

    if #keys < 2 then return false end

    return map[keys[1]] == 2 and map[keys[2]] == 2
end

function Hand:checkThreeOfAKind()
    return self:sameRank(3)
end 

function Hand:checkStraight()
    if #self.selectedHand ~= 5 then
        return false
    end 
    -- Sort
    table.sort(self.selectedHand, function(a, b)
        return a.rank > b.rank
    end)

    -- If difference from prev rank is not 1, not straight
    local prevRank = self.selectedHand[1].rank - 1
    for _, value in ipairs(self.selectedHand) do
        if value.rank - prevRank ~= 1 then
            return false
        end
        prevRank = value.rank
    end

    return true
end

function Hand:checkFlush()
    if #self.selectedHand ~= 5 then
        return false
    end

    local suit = self.selectedHand[1].suit
    for _, value in ipairs(self.selectedHand) do
        if value.suit ~= suit then
            return false
        end
    end
    return true
end

function Hand:checkFullHouse()
    if #self.selectedHand ~= 5 then
        return false
    end

    local mapAndKeys: {map: {[number]: number}, keys: {number}} = self:buildAndSortRankMap()
    local map = mapAndKeys.map
    local keys = mapAndKeys.keys

    if #keys < 2 then return false end

    return map[keys[1]] == 3 and map[keys[2]] == 2
end

function Hand:checkFourOfAKind()
    return self:sameRank(4)
end

function Hand:checkStraightFlush()
    return self:checkStraight() and self:checkFlush()
end

function Hand:checkRoyalFlush()
    return self:checkStraight() and self.selectedHand[1].rank == 13 and self:checkFlush()
end


return Hand
