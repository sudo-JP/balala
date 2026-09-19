local ActionButton = {}
ActionButton.__index = ActionButton

function ActionButton.new(builder): TextButton
    local button = Instance.new("TextButton")
    button.Name = builder.text
    button.Parent = builder.parent
    button.Size = builder.size
    button.Position = builder.position
    button.Text = builder.text
    button.BackgroundColor3 = builder.backgroundColor3
    button.TextColor3 = builder.textColor3
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = true

    if builder.onClick then
        button.MouseButton1Click:Connect(builder.onClick)
    end

    return button
end

local ActionButtonBuilder = {}
ActionButtonBuilder.__index = ActionButtonBuilder

function ActionButtonBuilder.new(parent: Instance)
    local self = setmetatable({}, ActionButtonBuilder)
    self.parent = parent
    self.text = "Button"
    self.size = UDim2.new(0, 200, 0, 50)
    self.position = UDim2.new(0.5, -100, 0.9, -50)
    self.backgroundColor3 = Color3.fromRGB(80, 150, 255)
    self.textColor3 = Color3.fromRGB(255, 255, 255)
    self.onClick = nil
    return self
end

function ActionButtonBuilder:withText(text: string)
    self.text = text
    return self
end

function ActionButtonBuilder:withSize(size: UDim2)
    self.size = size
    return self
end

function ActionButtonBuilder:withPosition(position: UDim2)
    self.position = position
    return self
end

function ActionButtonBuilder:withBackgroundColor(color: Color3)
    self.backgroundColor3 = color
    return self
end

function ActionButtonBuilder:withTextColor(color: Color3)
    self.textColor3 = color
    return self
end

function ActionButtonBuilder:onClick(callback: () -> ())
    self.onClick = callback
    return self
end

function ActionButtonBuilder:build()
    return ActionButton.new(self)
end

ActionButton.ActionButtonBuilder = ActionButtonBuilder

return ActionButton
