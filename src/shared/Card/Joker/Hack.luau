--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local Hack = {}
Hack.__index = Hack

export type Hack = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    Hack
))

function Hack.new(): Hack
    return setmetatable({ price = 6, rarity = "Uncommon" }, Hack)
end

function Hack.onCardScored(
    _self: Hack,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.rank >= 2 and card.rank <= 5 then
        return { kind = "AddChips", amount = 30 }
    end
    return nil
end

return Hack
