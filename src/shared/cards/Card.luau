--!strict
local HandModule = require("../deck/Hand")
type Hand = HandModule.Hand

type Suit = "Diamonds" | "Spades" | "Hearts" | "Clubs"


type CardValue = {
    suit: Suit,
    rank: number?,
    display: string, 
}

export type Evaluable = {
    evaluable: (self: Evaluable) -> CardValue,
}

-- Buyable from shop
export type Buyable = {
    price: number,
    buy: (self: Buyable) -> (),
}

-- Multiplier 
export type Consumable = {
    consume: (self: Consumable, currentPoint: number) -> number,
}

-- Playable on deck
export type Playable = {
    play: (self: Playable, hand: Hand) -> (),
}
