--!strict
local Deck = require("@self/deck")
local Hand = require("@self/hand")

export type Deck = Deck.Deck
export type Hand = Hand.Hand

return {
    Deck = Deck,
    Hand = Hand,
}
