--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local MadJoker = {}
MadJoker.__index = MadJoker

export type MadJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    MadJoker
))

function MadJoker.new(): MadJoker
    return setmetatable({ price = 4, rarity = "Common" }, MadJoker)
end

function MadJoker.onHandScored(
    _self: MadJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.TwoPair) then
        return { kind = "AddMult", amount = 10 }
    end
    return nil
end

return MadJoker
