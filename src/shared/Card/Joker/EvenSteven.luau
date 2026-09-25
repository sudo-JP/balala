--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local EvenSteven = {}
EvenSteven.__index = EvenSteven

export type EvenSteven = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    EvenSteven
))

function EvenSteven.new(): EvenSteven
    return setmetatable({ price = 4, rarity = "Common" }, EvenSteven)
end

function EvenSteven.onCardScored(
    _self: EvenSteven,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.rank % 2 == 0 then
        return { kind = "AddMult", amount = 4 }
    end
    return nil
end

return EvenSteven
