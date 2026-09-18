local ActionButton = {}
ActionButton.__index = ActionButton

export type ActionButtonConfig = {
    text: string?,
    size: UDim2?,
    position: UDim2?,
    backgroundColor3: Color3?,
    textColor3: Color3?,
}

local DEFAULT_CONFIG: ActionButtonConfig = {
    text = "Button",
    size = UDim2.new(0, 200, 0, 50),
    position = UDim2.new(0.5, -100, 0.9, -50),
    backgroundColor3 = Color3.fromRGB(80, 150, 255),
    textColor3 = Color3.fromRGB(255, 255, 255),
}

function ActionButton.new(parent: Instance, onClick: () -> (), config: ActionButtonConfig?): TextButton
    local cfg = config or {}
    local text = cfg.text or DEFAULT_CONFIG.text
    local size = cfg.size or DEFAULT_CONFIG.size
    local position = cfg.position or DEFAULT_CONFIG.position
    local bgColor = cfg.backgroundColor3 or DEFAULT_CONFIG.backgroundColor3
    local textColor = cfg.textColor3 or DEFAULT_CONFIG.textColor3

    local button = Instance.new("TextButton")
    button.Name = text
    button.Parent = parent
    button.Size = size
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = bgColor
    button.TextColor3 = textColor
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = true

    button.MouseButton1Click:Connect(onClick)

    return button
end

return ActionButton
