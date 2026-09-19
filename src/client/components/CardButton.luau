local CardButton = {}
CardButton.__index = CardButton

function CardButton.new(builder): TextButton
    local button = Instance.new("TextButton")
    button.Name = "CardButton_" .. builder.cardIndex
    button.Parent = builder.parent
    button.Size = builder.size
    button.Position = builder.position
    button.Text = builder.display
    button.BackgroundColor3 = builder.defaultColor
    button.TextColor3 = builder.textColor3
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold

    local selected = false
    button.MouseButton1Click:Connect(function()
        selected = not selected
        button.BackgroundColor3 = selected and builder.selectedColor or builder.defaultColor
        if builder.onClick then
            builder.onClick(selected)
        end
    end)

    return button
end

local CardButtonBuilder = {}
CardButtonBuilder.__index = CardButtonBuilder

function CardButtonBuilder.new(parent: Instance)
    local self = setmetatable({}, CardButtonBuilder)
    self.parent = parent
    self.display = ""
    self.cardIndex = 1
    self.size = UDim2.new(0, 100, 0, 140)
    self.position = UDim2.new(0, 20, 0.5, -70)
    self.selectedColor = Color3.fromRGB(100, 200, 100)
    self.defaultColor = Color3.fromRGB(255, 255, 255)
    self.textColor3 = Color3.fromRGB(0, 0, 0)
    self.onClick = nil
    return self
end

function CardButtonBuilder:withDisplay(display: string)
    self.display = display
    return self
end

function CardButtonBuilder:withCardIndex(index: number)
    self.cardIndex = index
    self.position = UDim2.new(0, 20 + (index - 1) * 120, 0.5, -70)
    return self
end

function CardButtonBuilder:withPosition(position: UDim2)
    self.position = position
    return self
end

function CardButtonBuilder:withSize(size: UDim2)
    self.size = size
    return self
end

function CardButtonBuilder:withSelectedColor(color: Color3)
    self.selectedColor = color
    return self
end

function CardButtonBuilder:withDefaultColor(color: Color3)
    self.defaultColor = color
    return self
end

function CardButtonBuilder:withTextColor(color: Color3)
    self.textColor3 = color
    return self
end

function CardButtonBuilder:onClick(callback: (selected: boolean) -> ())
    self.onClick = callback
    return self
end

function CardButtonBuilder:build()
    return CardButton.new(self)
end

CardButton.CardButtonBuilder = CardButtonBuilder

return CardButton
