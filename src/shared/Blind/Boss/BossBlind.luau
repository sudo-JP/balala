--!strict

local BlindTypes = require(script.Parent.Parent:FindFirstChild("Blind"))

local BossBlind = {}
BossBlind.__index = BossBlind

export type BossBlind = typeof(setmetatable(
	{} :: {
		chipTarget: number,
		reward: number,
	},
	BossBlind
)) & BlindTypes.Blind

function BossBlind.new(chipTarget: number, reward: number): BossBlind
	return setmetatable({
		chipTarget = chipTarget,
		reward = reward,
	}, BossBlind) :: BossBlind
end

function BossBlind.getChipTarget(self: BossBlind): number
	return self.chipTarget
end

function BossBlind.onHandPlayed(self: BossBlind, gameState: any): ()
	self:applyEffect(gameState)
end

function BossBlind.onRoundEnd(_self: BossBlind, _gameState: any): ()
end

function BossBlind.getReward(self: BossBlind): number
	return self.reward
end

function BossBlind.applyEffect(_self: BossBlind, _gameState: any): ()
	error("BossBlind.applyEffect must be overridden by a boss blind")
end

return BossBlind
