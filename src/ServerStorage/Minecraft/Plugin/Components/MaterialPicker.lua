-- Import libraries
local Modules = script.Parent.Parent.Parent
local Roact = require(Modules.Roact)
local RoactRodux = require(Modules.RoactRodux)

-- Component files
local MaterialCell = require(script.Parent.MaterialCell)

-- Define the MaterialPicker component
local MaterialPicker = Roact.Component:extend("MaterialPicker")

function MaterialPicker:render()
    local cells = {}

    for i = 1, 20 do
        cells[i] = Roact.createElement(MaterialCell, {
            LayoutOrder = i,
            OnSelect = function(newMaterial, newColor)
                -- Dispatch the SetMaterialAndColor action
                self.props.dispatch({
                    type = "SetMaterialAndColor",
                    cellIndex = i,
                    material = newMaterial,
                    color = newColor,
                })
            end,
            OnApply = function(material, color)
                -- Get the currently selected part in the workspace
                local selectedPart = nil-- code to get the selected part

                -- Apply the material and color to the part
                if selectedPart then
                    selectedPart.Material = material
                    selectedPart.BrickColor = BrickColor.new(color)
                end
            end,
        })
    end

    -- Rest of the render function here...
end

-- Connect to the Redux store
MaterialPicker = RoactRodux.connect(
    -- mapStateToProps
    function(state)
        return {
            materialCells = state.materialCells,
        }
    end,
    -- mapDispatchToProps
    function(dispatch)
        return {
            dispatch = dispatch,
        }
    end
)(MaterialPicker)

return MaterialPicker