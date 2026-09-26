---@module "eggfriedrice.extra.hyprland"
---@license MIT

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- hyprlang variables: `$name = rgb(hex)` for direct use and
	-- `$nameAlpha = hex` to compose `rgba($nameAlphaee)`, as the
	-- catppuccin hyprland theme does.
	local extra = require("eggfriedrice.extra")
	local lines = {}
	for _, color in ipairs(extra.colors(c)) do
		lines[#lines + 1] = ("$%s = rgb(%s)"):format(color[1], color[2]:sub(2))
	end
	lines[#lines + 1] = ""
	for _, color in ipairs(extra.colors(c)) do
		lines[#lines + 1] = ("$%sAlpha = %s"):format(color[1], color[2]:sub(2))
	end
	lines[#lines + 1] = ""
	return extra.header("hyprland") .. table.concat(lines, "\n")
end

return M
