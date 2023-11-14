local Modules = script.Parent.Parent.Parent
local Roact = require(Modules.Roact)

--local ColorPicker = require(script.Parent.ColorPicker)
local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)
local TextLabel = require(script.Parent.TextLabel)

local App = Roact.PureComponent:extend("App")

function App:init()
	self._rootRef = Roact.createRef()
end

function App:render()
	return Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		[Roact.Ref] = self._rootRef,
	}, {
		Background = StudioThemeAccessor.withTheme(function(theme)
			return Roact.createElement("Frame", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundColor3 = theme:GetColor("MainBackground"),
				ZIndex = -100,
			})
		end),
		Container = Roact.createElement("Frame", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1.0,
		}, {
			UIListLayout = Roact.createElement("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,

				-- hack :(
				[Roact.Ref] = function(rbx)
					if rbx then
						spawn(function()
							wait()
							wait()
							rbx:ApplyLayout()
						end)
					end
				end,
			}),

			UIPadding = Roact.createElement("UIPadding", {
				PaddingLeft = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4),
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 4),
			}),

			TagList = Roact.createElement(TextLabel, {
				Size = UDim2.new(1, 0, 1, -40),
			}),
			TagSearch = Roact.createElement(TextLabel, {
				Size = UDim2.new(1, 0, 0, 40),
			}),
		})
	})
end

return App
