local PlayerGameState = {}
PlayerGameState.__index = PlayerGameState

function PlayerGameState.new(builder)
    local self = setmetatable({}, PlayerGameState)
    self.currentCredit = 0
    self.hand = builder.Hand
    self.handSize = builder.handSize
    self.discardCounter = builder.discardCounter
end

local PlayerStateBuilder = {}
PlayerStateBuilder.__index = PlayerStateBuilder

function PlayerStateBuilder.new(player)
    local self = setmetatable({}, PlayerStateBuilder)
    self.currentCredit = 0
    self.handSize = 5
    self.deckType = player:getDeckType()
    return self
end

function PlayerStateBuilder:setDiscardCount(n)
    self.cardCounter = n
end

function PlayerStateBuilder:setHandSize(n)
    self.handSize = n
end

function PlayerStateBuilder:build()
    return PlayerStateBuilder.new(self)
end
