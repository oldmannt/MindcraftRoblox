local Modules = script.Parent.Parent.Parent
local Roact = require(Modules.Roact)

local MaterialCell = Roact.Component:extend("MaterialCell")

function MaterialCell:render()
    local material = self.props.material
    local color = self.props.color

    return Roact.createElement("TextButton", {
        Text = material and tostring(material) or "Select Material",
        TextColor3 = color or Color3.new(1, 1, 1), -- default to white text if no color is selected
        LayoutOrder = self.props.LayoutOrder,
        [Roact.Event.Activated] = function()
            if material then
                -- If a material is already selected, call the OnApply callback
                self.props.OnApply(material, color)
            else
                -- If no material is selected, call the OnSelect callback
                self.props.OnSelect()
            end
        end,
    })
end

return MaterialCell