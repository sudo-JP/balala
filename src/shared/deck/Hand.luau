--!strict
local CardModule = require(script.Parent.Parent.Card:FindFirstChild("Types"))

type CardValue = CardModule.CardValue
type DeckLike = {
    drawCard: (self: DeckLike) -> CardValue,
}

local Hand = {}
Hand.__index = Hand


local PokerHandRankings = table.freeze({
    HighCard = "HighCard",
    Pair = "Pair",
    TwoPair = "TwoPair",
    ThreeOfAKind = "ThreeOfAKind",
    Straight = "Straight",
    Flush = "Flush",
    FullHouse = "FullHouse",
    FourOfAKind = "FourOfAKind",
    StraightFlush = "StraightFlush",
    RoyalFlush = "RoyalFlush",
})

type PokerHandRanking = typeof(PokerHandRankings.HighCard)
    | typeof(PokerHandRankings.Pair)
    | typeof(PokerHandRankings.TwoPair)
    | typeof(PokerHandRankings.ThreeOfAKind)
    | typeof(PokerHandRankings.Straight)
    | typeof(PokerHandRankings.Flush)
    | typeof(PokerHandRankings.FullHouse)
    | typeof(PokerHandRankings.FourOfAKind)
    | typeof(PokerHandRankings.StraightFlush)
    | typeof(PokerHandRankings.RoyalFlush)

type HandResult = {
    cards: {CardValue},
    handType: PokerHandRanking,
    playedCardCount: number,
}

export type Hand = {
    currentHand: {CardValue},
    selectedHand: {CardValue},
    sortByRank: (self: Hand) -> (),
    sortBySuit: (self: Hand) -> (),
    DrawCardFromDeck: (self: Hand, deck: DeckLike) -> (),
    getSelectedHand: (self: Hand) -> {CardValue},
    SelectCard: (self: Hand, cardIndex: number) -> (),
    pokerRankings: (self: Hand) -> PokerHandRanking?,
    buildAndSortRankMap: (self: Hand) -> {map: {[number]: {CardValue}}, keys: {number}},
    sameRank: (self: Hand, count: number, handType: PokerHandRanking) -> HandResult?,

    getHandResult: (self: Hand) -> HandResult,

    -- Check cards
    -- https://balatrowiki.org/w/Poker_hands
    checkHighCard: (self: Hand) -> HandResult?,
    checkPair: (self: Hand) -> HandResult?,
    checkTwoPair: (self: Hand) -> HandResult?,
    checkThreeOfAKind: (self: Hand) -> HandResult?,
    checkStraight: (self: Hand) -> HandResult?,
    checkFlush: (self: Hand) -> HandResult?,
    checkFullHouse: (self: Hand) -> HandResult?,
    checkFourOfAKind: (self: Hand) -> HandResult?,
    checkStraightFlush: (self: Hand) -> HandResult?,
    checkRoyalFlush: (self: Hand) -> HandResult?,

    -- TODO: Implement secret hands 
}

function Hand.new(): Hand
    return setmetatable({
        currentHand = {},
        selectedHand = {},
    }, Hand) :: Hand
end

function Hand.sortByRank(self: Hand)
    table.sort(self.currentHand, function(a, b)
        return a.rank > b.rank
    end)
end

function Hand.sortBySuit(self: Hand)
    local cards = {}

    -- IDC about runtime, its only 5 cards
    local orders = {"Spade", "Heart", "Club", "Diamond"}
    for _, order in ipairs(orders) do
        for _, card in ipairs(self.selectedHand) do
            if card.suit == order then
                table.insert(cards, card)
            end
        end
    end
    self.selectedHand = cards
end

function Hand.DrawCardFromDeck(self: Hand, deck: DeckLike)
    table.insert(self.currentHand, deck:drawCard())
end

function Hand.getSelectedHand(self: Hand): {CardValue}
    return self.selectedHand
end

function Hand.SelectCard(self: Hand, cardIndex: number)
    local card = table.remove(self.currentHand, cardIndex)
    if card == nil then
        return
    end

    table.insert(self.selectedHand, card)
    self:pokerRankings()
end

function Hand.pokerRankings(self: Hand): PokerHandRanking?
    if self:checkRoyalFlush() then
        return PokerHandRankings.RoyalFlush
    elseif self:checkStraightFlush() then
        return PokerHandRankings.StraightFlush
    elseif self:checkFourOfAKind() then
        return PokerHandRankings.FourOfAKind
    elseif self:checkFullHouse() then
        return PokerHandRankings.FullHouse
    elseif self:checkFlush() then
        return PokerHandRankings.Flush
    elseif self:checkStraight() then
        return PokerHandRankings.Straight
    elseif self:checkThreeOfAKind() then
        return PokerHandRankings.ThreeOfAKind
    elseif self:checkTwoPair() then
        return PokerHandRankings.TwoPair
    elseif self:checkPair() then
        return PokerHandRankings.Pair
    elseif self:checkHighCard() then
        return PokerHandRankings.HighCard
    end

    return nil
end


function Hand.buildAndSortRankMap(self: Hand): {map: {[number]: {CardValue}}, keys: {number}}
    local map: {[number]: {CardValue}} = {}
    local keys: {number} = {}

    for _, value in ipairs(self.selectedHand) do
        if map[value.rank] == nil then
            map[value.rank] = {}
            table.insert(keys, value.rank)
        end
        table.insert(map[value.rank], value)
    end

    table.sort(keys, function(a, b)
        local countA = #map[a]
        local countB = #map[b]
        if countA == countB then
            return a > b
        end
        return countA > countB
    end)

    return { map = map, keys = keys }
end

function Hand.sameRank(self: Hand, count: number, handType: PokerHandRanking): HandResult?
    if count <= 0 or #self.selectedHand < count then
        return nil
    end

    local mapAndKeys = self:buildAndSortRankMap()
    local keys = mapAndKeys.keys
    local cards = mapAndKeys.map[keys[1]]

    if not (keys[1] ~= nil and #cards >= count) then
        return nil
    end

    local validCards = {}
    for i = 1, count do
        table.insert(validCards, cards[i])
    end

    return {
        cards = validCards,
        handType = handType,
        playedCardCount = #self.selectedHand,
    }
end

function Hand.getHandResult(self: Hand): HandResult
    local checks = {
        self.checkRoyalFlush,
        self.checkStraightFlush,
        self.checkFourOfAKind,
        self.checkFullHouse,
        self.checkFlush,
        self.checkStraight,
        self.checkThreeOfAKind,
        self.checkTwoPair,
        self.checkPair,
        self.checkHighCard,
    }
    for _, check in ipairs(checks) do
        local result = check(self)
        if result ~= nil then return result end
    end
    error("no hand match, this should never happen")
end

-- Start hand checking

function Hand.checkHighCard(self: Hand): HandResult?
    if #self.selectedHand == 0 then 
        return nil 
    end
    local maxRankCard = self.selectedHand[1]
    for _, card in ipairs(self.selectedHand) do
        if card.rank > maxRankCard.rank then
            maxRankCard = card
        end
    end
    return {cards = {maxRankCard}, handType = PokerHandRankings.HighCard, playedCardCount = #self.selectedHand}
end

function Hand.checkPair(self: Hand): HandResult?
    return self:sameRank(2, PokerHandRankings.Pair)
end

function Hand.checkTwoPair(self: Hand): HandResult?
    if #self.selectedHand < 4 then
        return nil
    end

    local mapAndKeys = self:buildAndSortRankMap()
    local map = mapAndKeys.map
    local keys = mapAndKeys.keys

    if not (#keys >= 2 and #map[keys[1]] >= 2 and #map[keys[2]] >= 2) then
        return nil
    end
    local validCards = {}
    for i = 1, 2 do
        for j = 1, 2 do
            table.insert(validCards, map[keys[i]][j])
        end
    end

    return {
        cards = validCards,
        handType = PokerHandRankings.TwoPair,
        playedCardCount = #self.selectedHand,
    }
end

function Hand.checkThreeOfAKind(self: Hand): HandResult?
    return self:sameRank(3, PokerHandRankings.ThreeOfAKind)
end

function Hand.checkStraight(self: Hand): HandResult?
    if #self.selectedHand ~= 5 then
        return nil
    end

    local ranks: {number} = {}
    for _, card in ipairs(self.selectedHand) do
        table.insert(ranks, card.rank)
    end
    table.sort(ranks)

    if ranks[1] == 2 and ranks[5] == 14 then
        ranks[5] = 1
        table.sort(ranks)
    end

    for index = 2, #ranks do
        if ranks[index] ~= ranks[index - 1] + 1 then
            return nil
        end
    end

    return {cards = self.selectedHand, handType = PokerHandRankings.Straight, playedCardCount = #self.selectedHand}
end

function Hand.checkFlush(self: Hand): HandResult?
    if #self.selectedHand ~= 5 then
        return nil
    end

    local suit = self.selectedHand[1].suit
    for _, value in ipairs(self.selectedHand) do
        if value.suit ~= suit then
            return nil
        end
    end
    return {cards = self.selectedHand, handType = PokerHandRankings.Flush, playedCardCount = #self.selectedHand}
end

function Hand.checkFullHouse(self: Hand): HandResult?
    if #self.selectedHand ~= 5 then
        return nil
    end

    local validCards = {}

    local mapAndKeys = self:buildAndSortRankMap()
    local keys = mapAndKeys.keys
    local map3 = mapAndKeys.map[keys[1]]
    local map2 = mapAndKeys.map[keys[2]]

    if not (#keys == 2 and #map3 == 3 and #map2 == 2) then
        return nil
    end

    for _, card in ipairs(map3) do
        table.insert(validCards, card)
    end

    for _, card in ipairs(map2) do
        table.insert(validCards, card)
    end

    return {
        cards = validCards,
        handType = PokerHandRankings.FullHouse,
        playedCardCount = #self.selectedHand,
    }
end

function Hand.checkFourOfAKind(self: Hand): HandResult?
    return self:sameRank(4, PokerHandRankings.FourOfAKind)
end

function Hand.checkStraightFlush(self: Hand): HandResult?
    if #self.selectedHand ~= 5 then
        return nil
    end
    local isStraight = self:checkStraight()
    local isFlush = self:checkFlush()
    if isStraight == nil or isFlush == nil then
        return nil
    end
    return {
        cards = self.selectedHand,
        handType = PokerHandRankings.StraightFlush,
        playedCardCount = #self.selectedHand,
    }
end

function Hand.checkRoyalFlush(self: Hand): HandResult?
    local sf = self:checkStraightFlush()
    if sf == nil then
        return nil
    end

    local minRank = sf.cards[1].rank
    for _, card in ipairs(sf.cards) do
        if card.rank < minRank then
            minRank = card.rank
        end
    end

    if minRank ~= 10 then
        return nil
    end

    return {
        cards = sf.cards,
        handType = PokerHandRankings.RoyalFlush,
        playedCardCount = #self.selectedHand,
    }
end

return Hand
