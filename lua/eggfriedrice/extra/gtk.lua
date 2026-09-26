---@module "eggfriedrice.extra.gtk"
---@license MIT

local M = {}

---The roles a bar or tab strip takes from the palette. The file exposes
---the whole palette as named colors and lists these as suggested uses.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "bar_background", "bg" },
		{ "bar_foreground", "fg" },
		{ "bar_border", "fg_gutter" },
		{ "muted", "comment" },
		{ "active", "yellow" },
		{ "active_text", "bg_dark" },
		{ "urgent", "red" },
		{ "success", "green" },
		{ "info", "blue" },
		{ "tab_background", "bg_dark" },
		{ "tab_selected", "bg_light" },
		{ "tab_indicator", "yellow" },
	}
end

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
	lines[#lines + 1] = "/* suggested roles */"
	for _, e in ipairs(M.roles(c)) do
		lines[#lines + 1] = ("/* %s: @%s */"):format(e[1], e[2])
	end
	lines[#lines + 1] = ""
	return table.concat(lines, "\n")
end

return M
