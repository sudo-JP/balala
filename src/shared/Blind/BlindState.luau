local BlindState = {}
BlindState.__index = BlindState

type BlindState = {}

function BlindState.new(): BlindState
    return setmetatable({
        blind = {} 
    }, BlindState) :: BlindState
end


return BlindState
