--!strict

export type Suit = "Diamond" | "Spade" | "Heart" | "Club"
export type Rarity = "Common" | "Uncommon" | "Rare" | "Legendary"

export type CardValue = {
    suit: Suit,
    rank: number,
    points: number,
    display: string,
}

export type Hand = {
    getSelectedHand: (self: Hand) -> {CardValue},
    checkOnePair: (self: Hand) -> boolean,
    checkTwoPair: (self: Hand) -> boolean,
    checkThreeOfAKind: (self: Hand) -> boolean,
    checkStraight: (self: Hand) -> boolean,
    checkFlush: (self: Hand) -> boolean,
}

export type Evaluable = {
    eval: (self: Evaluable) -> CardValue,
}

export type Buyable = {
    price: number,
    rarity: Rarity,
}

export type Consumable = {
    consume: (self: Consumable, currentPoint: number) -> number,
}

export type Passive = {
    onHandEval: (self: Passive, hand: Hand, score: number) -> number,
}

export type Playable = {
    play: (self: Playable, hand: Hand) -> (),
}

return {}
