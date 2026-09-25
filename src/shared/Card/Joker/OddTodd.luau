--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local OddTodd = {}
OddTodd.__index = OddTodd

export type OddTodd = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    OddTodd
))

function OddTodd.new(): OddTodd
    return setmetatable({ price = 4, rarity = "Common" }, OddTodd)
end

function OddTodd.onCardScored(
    _self: OddTodd,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.rank % 2 == 1 then
        return { kind = "AddChips", amount = 31 }
    end
    return nil
end

return OddTodd
