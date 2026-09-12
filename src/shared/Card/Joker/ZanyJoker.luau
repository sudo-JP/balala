--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local ZanyJoker = {}
ZanyJoker.__index = ZanyJoker

export type ZanyJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    ZanyJoker
))

function ZanyJoker.new(): ZanyJoker
    return setmetatable({ price = 4, rarity = "Common" }, ZanyJoker)
end

function ZanyJoker.onHandScored(
    _self: ZanyJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.ThreeOfAKind) then
        return { kind = "AddMult", amount = 12 }
    end
    return nil
end

return ZanyJoker
