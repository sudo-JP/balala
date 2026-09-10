--!strict
local PokerHands = require("@game/ReplicatedStorage/Shared/deck/PokerHands")
local JokerTypes = require("@game/ReplicatedStorage/Shared/Card/Joker/Types")
local PlayerGameState = require("../shared/Player/PlayerGameState")

local ScoreCalculator = {}


type HandLike = {
    read getHandResult: (self: any) -> PokerHands.HandResult,
}

type ScoreState = {
    chips: number,
    mult: number,
}

export type ScoreResult = {
    handResult: PokerHands.HandResult,
    chips: number,
    mult: number,
    score: number,
    effects: {JokerTypes.AppliedJokerEffect},
}

local function applyEffect(state: ScoreState, effect: JokerTypes.JokerEffect)
    if effect.kind == "AddChips" then
        state.chips += effect.amount
    elseif effect.kind == "AddMult" then
        state.mult += effect.amount
    elseif effect.kind == "MultiplyMult" then
        state.mult *= effect.amount
    else
        error(`unsupported Joker effect kind: {effect.kind}`)
    end
end

function ScoreCalculator.calculateHand(playerGameState: PlayerGameState): ScoreResult
    local hand = playerGameState:getHand() 
    local handResult = hand:getHandResult()

    local baseScore = playerGameState.getCurrentScore(handResult.cards)
    local state: ScoreState = {
        chips = baseScore.chips,
        mult = baseScore.mult,
    }
    local effects: {JokerTypes.AppliedJokerEffect} = {}
    local jokers = playerGameState:getJokers()

    for cardIndex, card in ipairs(handResult.cards) do
        state.chips += card.points

        for jokerIndex, joker in ipairs(jokers) do
            -- TODO: emit effect UI here
            -- For jokers that apply to specific card
            -- i.e more mult if has spade
            local onCardScored = joker.onCardScored
            if onCardScored ~= nil then
                local effect = onCardScored(joker, handResult, card, cardIndex)
                if effect ~= nil then
                    applyEffect(state, effect)
                    table.insert(effects, {
                        kind = effect.kind,
                        amount = effect.amount,
                        jokerIndex = jokerIndex,
                        cardIndex = cardIndex,
                    })
                end
            end
        end
    end

    -- For jokers that apply globally,
    -- i.e hand has two pair
    for jokerIndex, joker in ipairs(jokers) do
        local onHandScored = joker.onHandScored
        if onHandScored ~= nil then
            local effect = onHandScored(joker, handResult)
            if effect ~= nil then
                applyEffect(state, effect)
                table.insert(effects, {
                    kind = effect.kind,
                    amount = effect.amount,
                    jokerIndex = jokerIndex,
                    cardIndex = nil,
                })
            end
        end
    end

    return {
        handResult = handResult,
        chips = state.chips,
        mult = state.mult,
        score = state.chips * state.mult,
        effects = effects,
    }
end

return ScoreCalculator
