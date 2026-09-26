---@module "eggfriedrice.extra.gtk"
---@license MIT

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- `@define-color` works in GTK3 (waybar) and GTK4 (ghostty's
	-- gtk-custom-css) alike; stylesheets `@import` this file and then
	-- use `@yellow` or `alpha(@bg, 0.7)`.
	local extra = require("eggfriedrice.extra")
	local lines = {
		"/*",
		" * eggfriedrice for " .. extra.extras.gtk.label,
		" * generated from lua/eggfriedrice/colors.lua by `make extras`; do not edit by hand",
		" * install: " .. extra.extras.gtk.install,
		" */",
		"",
	}
	for _, color in ipairs(extra.colors(c)) do
		lines[#lines + 1] = ("@define-color %s %s;"):format(color[1], color[2])
	end
	lines[#lines + 1] = ""
	return table.concat(lines, "\n")
end

return M
