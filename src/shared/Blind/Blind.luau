--!strict

export type Blind = {
	getChipTarget: (self: Blind) -> number,
	onHandPlayed: (self: Blind, gameState: any) -> (),
	onRoundEnd: (self: Blind, gameState: any) -> (),
	getReward: (self: Blind) -> number,
}
