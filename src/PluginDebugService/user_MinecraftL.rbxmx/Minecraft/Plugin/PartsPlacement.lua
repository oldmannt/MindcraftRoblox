local PartsPlacement = {}
local Raycast = require(script.Parent.RayCast).Raycast
local Brick = script.Parent.Parent.Parts.Brick

local function getMinecraftFolder()
	if workspace:FindFirstChild('minecraft') == nil then
		local minecraft = Instance.new("Folder", workspace)
		minecraft.Name = 'minecraft'
		return minecraft
	end

	return workspace.minecraft
end

local clickToAddMouse1Conn = nil
local clickToAddMouse2Conn = nil
local function onClickToAdd(partsPlacement)
	if clickToAddMouse1Conn then
		clickToAddMouse1Conn:Disconnect()
	end
	if clickToAddMouse2Conn then
		clickToAddMouse2Conn:Disconnect()
	end
	-- stop adding brick
	if PartsPlacement.Plugin:IsActivated() then
		PartsPlacement.Plugin:Deactivate()
		return
	end
	
	PartsPlacement.Plugin:Activate(true) -- gain non exclusive access to the mouse
	print("ClickToAdd Actived.")

	local function button1Down()
		local part = Brick:Clone()
		partsPlacement.attemptPlaceNode(part, getMinecraftFolder())
	end
	
	local function button2Down()
		partsPlacement.attemptRemovePart()
	end

	clickToAddMouse1Conn = partsPlacement.PluginMouse.Button1Down:Connect(button1Down)
	clickToAddMouse2Conn = partsPlacement.PluginMouse.Button2Down:Connect(button2Down)
	print('connect button1Down')
end

function PartsPlacement.init(plugin)
	PartsPlacement.Plugin = plugin
	PartsPlacement.PluginMouse = plugin:GetMouse()
	PartsPlacement.BrickSize = Brick.Size.X
	onClickToAdd(PartsPlacement)
end

-- align the edge of brick to brick size * n
local function getBrickCenterFromPosNormal(distance, pos, normal)
	print(string.format("getBrickCenterFromPosNormal dis:%.02f pos[%.02f,%.02f,%.02f] normal:[%s]", 
		distance, pos.x, pos.y, pos.z, tostring(normal))
	)
	--local normalAxis = normal;
	--if normal.x > normal.y and normal.x > normal.z then
	--	normalAxis = Vector3.new(1, 0, 0)
	--elseif  normal.y > normal.x and normal.y > normal.z then
	--	normalAxis = Vector3.new(0, 1, 0)

	--else -- if normal.z > normal.y and normal.z > normal.x then
	--	normalAxis = Vector3.new(0, 0, 1)
	--end


	return pos + normal * distance
end

function alginXToN(x:number, n:number)
	return math.floor((x + n/2) / n) * n
end

function StickPartsTogether(part1:Part, part2:Part)
	local weldConstraint = Instance.new("WeldConstraint")
	weldConstraint.Part0 = part1
	weldConstraint.Part1 = part2
	weldConstraint.Parent = part1
end

function PartsPlacement.attemptPlaceNode(part:Part, parent:Instance)
	local hit,pos,normal = Raycast(PartsPlacement.PluginMouse.UnitRay.Origin,PartsPlacement.PluginMouse.UnitRay.Direction * 15000)
	print(string.format("Raycast hit:%s pos:[%.02f,%.02f,%.02f] normal:[%.02f,%.02f,%.02f]",
		hit.Name,
		pos.x, pos.y, pos.z, normal.x, normal.z, normal.y))
	if hit then
		local posCenter:Vector3 = pos
		local distance = part.Size.X / 2
		if hit:GetAttribute("isMinecraft") then
			posCenter = hit.Position
			distance = part.Size.X
			StickPartsTogether(hit, part)
		else
			-- align posCenter.X and posCenter.Z to N * PartsPlacement.BrickSize
			posCenter = Vector3.new(
				alginXToN(posCenter.X, PartsPlacement.BrickSize),
				posCenter.Y,
				alginXToN(posCenter.Z, PartsPlacement.BrickSize))
		end
		part.Position = getBrickCenterFromPosNormal(distance, posCenter, normal)
		part.Parent = parent
	end
end

function PartsPlacement.attemptRemovePart()
	local hit,pos,normal = Raycast(PartsPlacement.PluginMouse.UnitRay.Origin,PartsPlacement.PluginMouse.UnitRay.Direction * 15000)
	print(string.format("Raycast hit:%s pos:[%.02f,%.02f,%.02f] normal:[%.02f,%.02f,%.02f]",
		hit.Name,
		pos.x, pos.y, pos.z, normal.x, normal.z, normal.y))

	if hit then
		if hit:GetAttribute("isMinecraft") then
			hit.Parent = nil
		end
	end
end

return PartsPlacement
