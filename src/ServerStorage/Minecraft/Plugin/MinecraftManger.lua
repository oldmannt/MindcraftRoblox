--!strict

local Collection = game:GetService("CollectionService")
local Selection = game:GetService("Selection")
local ChangeHistory = game:GetService("ChangeHistoryService")

local Actions = require(script.Parent.Actions)

--[=[
	Anything tagged with this value will be treated as a source for tag editor
	tags.
]=]
local TAG_FOLDER_TAG = "TagEditorTagContainer"

local MinecraftManger = {}
MinecraftManger.__index = MinecraftManger

MinecraftManger._global = nil


function MinecraftManger.new(store)
	local self = setmetatable({
		store = store,
		updateTriggered = false,
		
	}, MinecraftManger)

	MinecraftManger._global = self

	self:_updateStore()
	return self
end

function MinecraftManger:Destroy()
end

function MinecraftManger.Get(): MinecraftManger
	return MinecraftManger._global
end

function MinecraftManger:_doUpdateStore()

end

function MinecraftManger:_updateStore(updateUnknown: boolean?)
	if not self.updateTriggered then
		self.updateTriggered = true
		task.spawn(function()
			self:_doUpdateStore()
		end)
	end
end

type MinecraftManger = typeof(MinecraftManger.new())

return MinecraftManger
