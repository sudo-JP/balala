local ScoreLabel = {}
ScoreLabel.__index = ScoreLabel

function ScoreLabel.new(builder): TextLabel
    local label = Instance.new("TextLabel")
    label.Name = "ScoreLabel"
    label.Parent = builder.parent
    label.Size = builder.size
    label.Position = builder.position
    label.Text = `Score: {builder.chips} x {builder.mult} ({builder.handType})`
    label.TextColor3 = builder.textColor3
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold

    return label
end

local ScoreLabelBuilder = {}
ScoreLabelBuilder.__index = ScoreLabelBuilder

function ScoreLabelBuilder.new(parent: Instance)
    local self = setmetatable({}, ScoreLabelBuilder)
    self.parent = parent
    self.chips = 0
    self.mult = 0
    self.handType = ""
    self.size = UDim2.new(0, 300, 0, 40)
    self.position = UDim2.new(0.5, -150, 0.1, 0)
    self.textColor3 = Color3.fromRGB(255, 255, 255)
    return self
end

function ScoreLabelBuilder:withChips(chips: number)
    self.chips = chips
    return self
end

function ScoreLabelBuilder:withMult(mult: number)
    self.mult = mult
    return self
end

function ScoreLabelBuilder:withHandType(handType: string)
    self.handType = handType
    return self
end

function ScoreLabelBuilder:withPosition(position: UDim2)
    self.position = position
    return self
end

function ScoreLabelBuilder:withSize(size: UDim2)
    self.size = size
    return self
end

function ScoreLabelBuilder:withTextColor(color: Color3)
    self.textColor3 = color
    return self
end

function ScoreLabelBuilder:build()
    return ScoreLabel.new(self)
end

ScoreLabel.ScoreLabelBuilder = ScoreLabelBuilder

return ScoreLabel
