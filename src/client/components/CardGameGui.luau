local CardGameGui = {}
CardGameGui.__index = CardGameGui

local Players = game:GetService("Players")

function CardGameGui.new(): ScreenGui
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    local existing = playerGui:FindFirstChild("CardGameGui")
    if existing then
        existing:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CardGameGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    return screenGui
end

return CardGameGui
