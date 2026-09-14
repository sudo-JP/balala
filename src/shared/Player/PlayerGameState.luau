local Deck = require(game.ReplicatedStorage.Shared.Player:FindFirstChild("Deck"))

local PlayerGameState = {}
PlayerGameState.__index = PlayerGameState

type PlayerCardData = {
    hand: number,
    discard: number,
    handSize: number,
    deckType: any,
    pokerHandLevels: {[string]: {chips: number, mult: number}},
}

type PlayerInventoryData = {
    jokerSlotsSize: number,
    capital: number,
    consumableSlotsSize: number,
    vouchers: {any},
    jokers: {any},
    consumeable: {any},
}

function PlayerGameState:drawMoreCards(self: PlayerGameState)
    for i = 1, self.handSize - #self.currentHand do
        table.insert(self.currentHand, self.deck:drawCard())
    end
end

function PlayerGameState.new(builder)
    local self = setmetatable({}, PlayerGameState)
    self.deck = Deck.new()
    self.handSize = builder.playerCardData.handSize

    self.currentHand = {}
    self:drawMoreCards()

    self.hand = builder.playerCardData.hand
    self.discard = builder.playerCardData.discard
    self.capital = builder.playerInventoryData.capital
    self.jokerSlotsSize = builder.playerInventoryData.jokerSlotsSize
    self.consumableSlotsSize = builder.playerInventoryData.consumableSlotsSize
    self.deckType = builder.playerCardData.deckType
    self.pokerHandLevels = builder.playerCardData.pokerHandLevels
    self.vouchers = builder.playerInventoryData.vouchers
    self.jokers = builder.playerInventoryData.jokers
    self.consumeable = builder.playerInventoryData.consumeable
    return self
end

function PlayerGameState.getHand(self)
    return self.hand
end

function PlayerGameState.getCurrentScore(self, key: string)
    return self.pokerHandLevels[key]
end

function PlayerGameState.getJokers(self)
    return self.jokers
end

local PlayerStateBuilder = {}
PlayerStateBuilder.__index = PlayerStateBuilder

-- Default goes here
function PlayerStateBuilder.new(player)
    local self = setmetatable({}, PlayerStateBuilder)
    local playerCardData: PlayerCardData = {
        hand = 4,
        discard = 3,       
        handSize = 8,
        deckType = player:getDeckType(),
        pokerHandLevels = {
            HighCard = { chips = 5, mult = 1 },
            Pair = { chips = 10, mult = 2 },
            TwoPair = { chips = 20, mult = 2 },
            ThreeOfAKind = { chips = 30, mult = 3 },
            Straight = { chips = 30, mult = 4 },
            Flush = { chips = 35, mult = 4 },
            FullHouse = { chips = 40, mult = 4 },
            FourOfAKind = { chips = 60, mult = 7 },
            StraightFlush = { chips = 100, mult = 8 },
            RoyalFlush = { chips = 100, mult = 8 },
        }
    }
    self.playerCardData = playerCardData

    local playerInventoryData: PlayerInventoryData = {
        jokerSlotsSize = 5,
        capital = 4,
        consumableSlotsSize = 2,
        vouchers = {},
        jokers = {},
        consumeable = {},
    }
    self.playerInventoryData = playerInventoryData

    self.deckConfigured = false
    return self
end

function PlayerStateBuilder:useRedDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.playerCardData.discard += 1
    self.deckConfigured = true
end

function PlayerStateBuilder:useBlueDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.playerCardData.hand += 1
    self.deckConfigured = true
end

function PlayerStateBuilder:useYellowDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.playerInventoryData.capital += 10
    self.deckConfigured = true
end

function PlayerStateBuilder:useGreenDeck()
    assert(not self.deckConfigured, "deck already configured")
    -- todo
    self.deckConfigured = true
end

function PlayerStateBuilder:useBlackDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.playerInventoryData.jokerSlotsSize += 10
    self.playerCardData.hand -= 1
    self.deckConfigured = true
end

function PlayerStateBuilder:usePaintedDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.playerCardData.handSize += 2
    self.playerInventoryData.jokerSlotsSize -= 1
    self.deckConfigured = true
end


function PlayerStateBuilder:build()
    return PlayerGameState.new(self)
end

return PlayerGameState
