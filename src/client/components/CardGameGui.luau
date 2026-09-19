local CardGameGui = {}
CardGameGui.__index = CardGameGui

local Players = game:GetService("Players")

function CardGameGui.new(builder): ScreenGui
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    local existing = playerGui:FindFirstChild(builder.name)
    if existing then
        existing:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = builder.name
    screenGui.ResetOnSpawn = builder.resetOnSpawn
    screenGui.Parent = playerGui

    return screenGui
end

local CardGameGuiBuilder = {}
CardGameGuiBuilder.__index = CardGameGuiBuilder

function CardGameGuiBuilder.new()
    local self = setmetatable({}, CardGameGuiBuilder)
    self.name = "CardGameGui"
    self.resetOnSpawn = false
    return self
end

function CardGameGuiBuilder:withName(name: string)
    self.name = name
    return self
end

function CardGameGuiBuilder:withResetOnSpawn(reset: boolean)
    self.resetOnSpawn = reset
    return self
end

function CardGameGuiBuilder:build()
    return CardGameGui.new(self)
end

CardGameGui.CardGameGuiBuilder = CardGameGuiBuilder

return CardGameGui
