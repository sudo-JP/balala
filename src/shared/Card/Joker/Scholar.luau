--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local Scholar = {}
Scholar.__index = Scholar

export type Scholar = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    Scholar
))

function Scholar.new(): Scholar
    return setmetatable({ price = 4, rarity = "Common" }, Scholar)
end

function Scholar.onCardScored(
    _self: Scholar,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.rank == 14 then
        return { kind = "AddMult", amount = 4 }
    end
    return nil
end

return Scholar
