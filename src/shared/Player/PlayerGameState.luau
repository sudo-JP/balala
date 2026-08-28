local PlayerGameState = {}
PlayerGameState.__index = PlayerGameState

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
    self.hand = 4
    self.discard = 3
    self.handSize = 8
    self.capital = 4
    self.jokerSlotsSize = 5
    self.consumableSlotsSize = 2
    self.deckType = player:getDeckType()
    self.deckConfigured = false
    return self
end

function PlayerStateBuilder:useRedDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.discard += 1
    self.deckConfigured = true
end

function PlayerStateBuilder:useBlueDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.hand += 1
    self.deckConfigured = true
end

function PlayerStateBuilder:useYellowDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.capital += 10
    self.deckConfigured = true
end

function PlayerStateBuilder:useGreenDeck()
    assert(not self.deckConfigured, "deck already configured")
    -- todo
    self.deckConfigured = true
end

function PlayerStateBuilder:useBlackDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.jokerSlotsSize += 1
    self.hand -= 1
    self.deckConfigured = true
end

function PlayerStateBuilder:usePaintedDeck()
    assert(not self.deckConfigured, "deck already configured")
    self.handSize += 2;
    self.jokerSlotsSize -= 1
    self.deckConfigured = true
end

function PlayerStateBuilder:build()
    return PlayerStateBuilder.new(self)
end
