--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local CraftyJoker = {}
CraftyJoker.__index = CraftyJoker

export type CraftyJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    CraftyJoker
))

function CraftyJoker.new(): CraftyJoker
    return setmetatable({ price = 4, rarity = "Common" }, CraftyJoker)
end

function CraftyJoker.onHandScored(
    _self: CraftyJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.Flush) then
        return { kind = "AddChips", amount = 80 }
    end
    return nil
end

return CraftyJoker
