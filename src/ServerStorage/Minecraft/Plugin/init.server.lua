-- if not plugin then
-- 	error('Must be executed as a plugin.')
-- end
-- print("Plugin loading")

-- local UserInputService = game.UserInputService

-- -- Create a new toolbar section titled "Custom Script Tools"
-- local toolbar = plugin:CreateToolbar("minecraft")

-- -- Add a toolbar button named "Create Empty Script"
-- local btnClickToAdd = toolbar:CreateButton("minecraft", "ClickToAdd", "rbxassetid://4458901886")

-- -- Make button clickable even if 3D viewport is hidden
-- btnClickToAdd.ClickableWhenViewportHidden = true
-- PluginMouse = plugin:GetMouse()
-- local PartsPlacement = require(script.PartsPlacement)
-- local brick = script.Parent.Parts.Brick

-- local function getMinecraftFolder()
-- 	if workspace:FindFirstChild('minecraft') == nil then
-- 		local minecraft = Instance.new("Folder", workspace)
-- 		minecraft.Name = 'minecraft'
-- 		return minecraft
-- 	end

-- 	return workspace.minecraft
-- end

-- PartsPlacement.init(PluginMouse, brick.Size.X)

-- local clickToAddMouse1Conn = nil
-- local clickToAddMouse2Conn = nil
-- local function onClickToAdd()
-- 	if clickToAddMouse1Conn then
-- 		clickToAddMouse1Conn:Disconnect()
-- 	end
-- 	if clickToAddMouse2Conn then
-- 		clickToAddMouse2Conn:Disconnect()
-- 	end
-- 	-- stop adding brick
-- 	if plugin:IsActivated() then
-- 		plugin:Deactivate()
-- 		return
-- 	end
	
-- 	plugin:Activate(true) -- gain non exclusive access to the mouse
-- 	print("ClickToAdd Actived.")

-- 	local function button1Down()
-- 		local part = brick:Clone()
-- 		PartsPlacement.attemptPlaceNode(part, getMinecraftFolder())
-- 	end
	
-- 	local function button2Down()
-- 		PartsPlacement.attemptRemovePart()
-- 	end

-- 	clickToAddMouse1Conn = PluginMouse.Button1Down:Connect(button1Down)
-- 	clickToAddMouse2Conn = PluginMouse.Button2Down:Connect(button2Down)
-- 	print('connect button1Down')
-- end

-- btnClickToAdd.Click:Connect(onClickToAdd)

-- -- create Plugin UI
-- local interface = plugin:CreateDockWidgetPluginGui(
-- 	"MaterialChangeUI",
-- 	DockWidgetPluginGuiInfo.new(
-- 		Enum.InitialDockState.Float,
-- 		false,
-- 		false,
-- 		560,
-- 		297,
-- 		560,
-- 		297
-- 	)
-- )
-- interface.Enabled = false
-- print("Plugin loaded.")