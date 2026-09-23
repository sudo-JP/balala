

--!strict

local BlindTypes = require(script.Parent:FindFirstChild("Blind"))

local FixedBlind = {}
FixedBlind.__index = FixedBlind

export type FixedBlind = typeof(setmetatable(
	{} :: {
		chipTarget: number,
		reward: number,
	},
	FixedBlind
)) & BlindTypes.Blind

function FixedBlind.new(chipTarget: number, reward: number): FixedBlind
	return setmetatable({
		chipTarget = chipTarget,
		reward = reward,
	}, FixedBlind) :: FixedBlind
end

function FixedBlind.getChipTarget(self: FixedBlind): number
	return self.chipTarget
end

function FixedBlind.onHandPlayed(_self: FixedBlind, _gameState: any): ()
end

function FixedBlind.onRoundEnd(_self: FixedBlind, _gameState: any): ()
end

function FixedBlind.getReward(self: FixedBlind): number
	return self.reward
end

return FixedBlind
