local CardButton = {}
CardButton.__index = CardButton

local SELECTED_COLOR = Color3.fromRGB(100, 200, 100)
local DEFAULT_COLOR = Color3.fromRGB(255, 255, 255)

function CardButton.new(display: string, cardIndex: number, parent: Instance, onClick: (selected: boolean) -> ())): TextButton
    local button = Instance.new("TextButton")
    button.Name = "CardButton_" .. cardIndex
    button.Parent = parent
    button.Size = UDim2.new(0, 100, 0, 140)
    button.Position = UDim2.new(0, 20 + (cardIndex - 1) * 120, 0.5, -70)
    button.Text = display
    button.BackgroundColor3 = DEFAULT_COLOR
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold

    local selected = false
    button.MouseButton1Click:Connect(function()
        selected = not selected
        button.BackgroundColor3 = selected and SELECTED_COLOR or DEFAULT_COLOR
        onClick(selected)
    end)

    return button
end

return CardButton
