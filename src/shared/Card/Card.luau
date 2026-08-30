--!strict
local HandModule = require("../deck/Hand")
type Hand = HandModule.Hand

type Suit = "Diamond" | "Spade" | "Heart" | "Club"


type CardValue = {
    suit: Suit,
    rank: number,    -- For hand detection  (J: 11, K: 12, etc)
    points: number,  -- Balatro point style (J: 10, K: 10, etc)
    display: string, 
}

export type Evaluable = {
    evaluable: (self: Evaluable) -> CardValue,
}

-- Buyable from shop
export type Buyable = {
    price: number,
}

-- Multiplier 
export type Consumable = {
    consume: (self: Consumable, currentPoint: number) -> number,
}

export type Passive = {
    onHandEval: (self: Passive, hand: Hand, score: number) -> number,
}


-- Playable on deck
export type Playable = {
    play: (self: Playable, hand: Hand) -> (),
}
