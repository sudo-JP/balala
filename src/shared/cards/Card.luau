local HandModule = require(script.Parent.Parent.deck.Hand)
type Hand = HandModule.Hand

type Suit = "Diamonds" | "Spades" | "Hearts" | "Clubs"


type CardValue = {
    suit: Suit,
    rank: number?,
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
    consume: (self: Consumable, current_point: number) -> number,
}

-- Playable on deck
export type Playable = {
    play: (self: Playable, hand: Hand) -> (),
}
