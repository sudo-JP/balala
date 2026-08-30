local PlayerGameState = {}
PlayerGameState.__index = PlayerGameState

type PlayerCardData = {
    hand: number,
    discard: number, 
    handSize: number,
    deckType: any,
}

type PlayerInventoryData = {
    jokerSlotsSize: number,
    capital: number,
    consumableSlotsSize: number,
    vouchers: {any},
    jokers: {any},
    consumeable: {any},
}


function PlayerGameState.new(builder)
    local self = setmetatable({}, PlayerGameState)
    self.hand = builder.hand 
    self.discard = builder.discard 
    self.handSize = builder.handSize 
    self.capital = builder.capital 
    self.jokerSlotsSize = builder.jokerSlotsSize 
    self.consumableSlotsSize = builder.consumableSlotsSize
    self.deckType = builder.deckType
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
    return PlayerStateBuilder.new(self)
end
