---@module "eggfriedrice.extra.lua"
---@license MIT

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- A plain module in three views: `rgb(hex)` strings for hyprlang
	-- values, bare hex for composing rgba(...), and `#hex` for everything
	-- else. Mirrors the shape of catppuccin's mocha.lua drop-in.
	local extra = require("eggfriedrice.extra")
	local colors = extra.colors(c)
	local lines = { extra.header("lua") .. "local M = {}", "" }
	local views = {
		{
			"rgb",
			'M.rgb.%s = "rgb(%s)"',
			function(hex)
				return hex:sub(2)
			end,
		},
		{
			"alpha",
			'M.alpha.%s = "%s"',
			function(hex)
				return hex:sub(2)
			end,
		},
		{
			"hex",
			'M.hex.%s = "%s"',
			function(hex)
				return hex
			end,
		},
	}
	for _, view in ipairs(views) do
		lines[#lines + 1] = ("M.%s = {}"):format(view[1])
		for _, color in ipairs(colors) do
			lines[#lines + 1] = view[2]:format(color[1], view[3](color[2]))
		end
		lines[#lines + 1] = ""
	end
	lines[#lines + 1] = '-- top-level names are the rgb() view, so `require("eggfriedrice").yellow` works'
	lines[#lines + 1] = "setmetatable(M, { __index = M.rgb })"
	lines[#lines + 1] = ""
	lines[#lines + 1] = "return M"
	lines[#lines + 1] = ""
	return table.concat(lines, "\n")
end

return M
