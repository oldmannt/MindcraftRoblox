local Modules = script.Parent.Parent
local Roact = require(Modules.Roact)
local Rodux = require(Modules.Rodux)
local RoactRodux = require(Modules.RoactRodux)

local App = require(script.Parent.Components.App)
local Reducer = require(script.Parent.Reducer)
local MinecraftManager = require(script.Parent.MinecraftManger)
--local Actions = require(script.Parent.Actions)
local Config = require(script.Parent.Config)
--local PluginGlobals = require(script.Parent.PluginGlobals)
local PartsPlacement = require(script.Parent.PartsPlacement)

local function getSuffix(plugin)
	if plugin.isDev then
		return " [DEV]", "Dev"
	elseif Config.betaRelease then
		return " [BETA]", "Beta"
	end

	return "", ""
end

return function(plugin, savedState)
	local displaySuffix, nameSuffix = getSuffix(plugin)

	local toolbar = plugin:toolbar("Minecraft" .. displaySuffix)

	local function pluginButton(key: string, icon: string): PluginToolbarButton
		return plugin:button(
			toolbar,
			key,
			"Minecraft",
			icon,
			"Minecraft"
		)
	end

	local toggleButton = pluginButton("Minicraft", "rbxassetid://4458901886")
	--local worldViewButton = pluginButton("WorldView", "http://www.roblox.com/asset/?id=1367285594")

	local store = Rodux.Store.new(Reducer, savedState)

	local manager = MinecraftManager.new(store)

	local info = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 0, 0)
	local gui = plugin:createDockWidgetPluginGui("MaterialPicker" .. nameSuffix, info)
	gui.Name = "MaterialPicker" .. nameSuffix
	gui.Title = "MaterialPicker" .. displaySuffix
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	--gui.RootLocalizationTable = script.Parent.Localization
	toggleButton:SetActive(gui.Enabled)

	local connection = toggleButton.Click:Connect(function()
		gui.Enabled = not gui.Enabled
		toggleButton:SetActive(gui.Enabled)
		PartsPlacement.init(plugin:getPlugin()) 
	end)

	local prefix = "MaterialPicker" .. nameSuffix .. "_"
	local function createAction(id: string, icon: string?, allowBinding: boolean?): PluginAction
		local label = "PluginAction_" .. id .. "_Label"
		local description = "PluginAction_" .. id .. "_Description"
		return plugin:createAction(prefix .. id, label, description, icon, allowBinding)
	end

	local element = Roact.createElement(RoactRodux.StoreProvider, {
		store = store,
	}, {
		App = Roact.createElement(App, {
			root = gui,
		}),
	})

	local instance = Roact.mount(element, gui, "MaterialPicker")

	plugin:beforeUnload(function()
		Roact.unmount(instance)
		connection:Disconnect()
		manager:Destroy()
		return store:getState()
	end)
end
