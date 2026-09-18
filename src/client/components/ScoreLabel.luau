local ScoreLabel = {}
ScoreLabel.__index = ScoreLabel

function ScoreLabel.new(parent: Instance, chips: number, mult: number, handType: string): TextLabel
    local label = Instance.new("TextLabel")
    label.Name = "ScoreLabel"
    label.Parent = parent
    label.Size = UDim2.new(0, 300, 0, 40)
    label.Position = UDim2.new(0.5, -150, 0.1, 0)
    label.Text = `Score: {chips} x {mult} ({handType})`
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold

    return label
end

return ScoreLabel
