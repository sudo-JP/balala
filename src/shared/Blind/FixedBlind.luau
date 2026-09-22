local FixedBlind = {}
FixedBlind.__index = FixedBlind


export type FixedBlind = {
}
export type BlindType = "SmallBlind" | "BigBlind"

function FixedBlind.new(blindType, score): FixedBlind
    return setmetatable({
        blindType = blindType,
        roundScore = score 
    }, FixedBlind) :: FixedBlind
end

return FixedBlind
