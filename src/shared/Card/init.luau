--!strict
local CardModule = require("@self/Types")
local StandardCard = require("@self/StandardCard")

export type Suit = CardModule.Suit
export type Rarity = CardModule.Rarity
export type CardValue = CardModule.CardValue
export type Evaluable = CardModule.Evaluable
export type Buyable = CardModule.Buyable
export type Consumable = CardModule.Consumable
export type Passive = CardModule.Passive
export type Playable = CardModule.Playable

return {
    StandardCard = StandardCard,
}
