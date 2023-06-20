local module = {}

local function FindCharacterAncestor(part)
	if part then
		local humanoid = part:FindFirstChildOfClass("Humanoid")
		if humanoid then
			return part, humanoid
		else
			return FindCharacterAncestor(part.Parent)
		end
	end
end

function module.Raycast(origin, dir, ignore)
	local ignore = ignore and { unpack(ignore) } or {}
	local result
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist
	rayParams.FilterDescendantsInstances = ignore

	result = workspace:Raycast(origin, dir, rayParams)

	if result then
		return result.Instance, result.Position, result.Normal, result.Material
	end
end

return module
