--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))

export type JokerEffectKind = "AddChips" | "AddMult" | "MultiplyMult"

export type JokerEffect = {
    kind: JokerEffectKind,
    amount: number,
}

export type AppliedJokerEffect = {
    kind: JokerEffectKind,
    amount: number,
    jokerIndex: number,
    cardIndex: number?,
}

export type OnCardScored = {
    onCardScored: (
        self: OnCardScored,
        handResult: PokerHands.HandResult,
        card: CardTypes.CardValue,
        cardIndex: number
    ) -> JokerEffect?,
}

export type OnHandScored = {
    onHandScored: (
        self: OnHandScored,
        handResult: PokerHands.HandResult
    ) -> JokerEffect?,
}

export type Joker = {
    price: number,
    rarity: CardTypes.Rarity,
    onCardScored: ((
        self: any,
        handResult: PokerHands.HandResult,
        card: CardTypes.CardValue,
        cardIndex: number
    ) -> JokerEffect?)?,
    onHandScored: ((
        self: any,
        handResult: PokerHands.HandResult
    ) -> JokerEffect?)?,
}

return {}
