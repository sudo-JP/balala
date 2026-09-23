--!strict

local BlindTypes = require(script.Parent:FindFirstChild("Blind"))

local BlindState = {}
BlindState.__index = BlindState

export type BlindState = typeof(setmetatable(
	{} :: {
		blinds: { BlindTypes.Blind },
		currentBlindIndex: number,
	},
	BlindState
))

function BlindState.new(
	smallBlind: BlindTypes.Blind,
	bigBlind: BlindTypes.Blind,
	bossBlind: BlindTypes.Blind
): BlindState
	return setmetatable({
		blinds = { smallBlind, bigBlind, bossBlind },
		currentBlindIndex = 1,
	}, BlindState) :: BlindState
end

function BlindState.getCurrentBlind(self: BlindState): BlindTypes.Blind
	return self.blinds[self.currentBlindIndex]
end

function BlindState.advance(self: BlindState): BlindTypes.Blind
	if self.currentBlindIndex < #self.blinds then
		self.currentBlindIndex += 1
	end

	return self:getCurrentBlind()
end

local BlindStateBuilder = {}
BlindStateBuilder.__index = BlindStateBuilder

export type BlindStateBuilder = typeof(setmetatable(
	{} :: {
		smallBlind: BlindTypes.Blind?,
		bigBlind: BlindTypes.Blind?,
		bossBlind: BlindTypes.Blind?,
	},
	BlindStateBuilder
))

function BlindStateBuilder.new(): BlindStateBuilder
	return setmetatable({}, BlindStateBuilder) :: BlindStateBuilder
end

function BlindStateBuilder:setSmallBlind(blind: BlindTypes.Blind): BlindStateBuilder
	self.smallBlind = blind
	return self
end

function BlindStateBuilder:setBigBlind(blind: BlindTypes.Blind): BlindStateBuilder
	self.bigBlind = blind
	return self
end

function BlindStateBuilder:setBossBlind(blind: BlindTypes.Blind): BlindStateBuilder
	self.bossBlind = blind
	return self
end

function BlindStateBuilder:build(): BlindState
	assert(self.smallBlind, "small blind is required")
	assert(self.bigBlind, "big blind is required")
	assert(self.bossBlind, "boss blind is required")

	return BlindState.new(self.smallBlind, self.bigBlind, self.bossBlind)
end

BlindState.Builder = BlindStateBuilder

return BlindState
