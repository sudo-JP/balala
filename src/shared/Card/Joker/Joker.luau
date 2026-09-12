--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local Joker = {}
Joker.__index = Joker

export type Joker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    Joker
))

function Joker.new(): Joker
    return setmetatable({ price = 2, rarity = "Common" }, Joker)
end

function Joker.onHandScored(
    _self: Joker,
    _handResult: PokerHands.HandResult
): JokerTypes.JokerEffect
    return { kind = "AddMult", amount = 4 }
end

return Joker
