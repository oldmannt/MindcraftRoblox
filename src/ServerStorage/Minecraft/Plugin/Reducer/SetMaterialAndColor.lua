-- Store
local initialStoreState = {
    materialCells = {} -- An empty table to store the material and color of each cell
    -- Other store state here...
}

-- Reducer
local function reducer(state, action)
    state = state or initialStoreState

    if action.type == "SetMaterialAndColor" then
        -- Create a new table for materialCells so Roact knows to re-render
        local newMaterialCells = {}
        for i, v in pairs(state.materialCells) do
            newMaterialCells[i] = v
        end

        -- Set the material and color for the specified cell
        newMaterialCells[action.cellIndex] = {
            material = action.material,
            color = action.color
        }

        return {
            materialCells = newMaterialCells,
            -- Other state here...
        }
    end

    return state
end

return reducer
