---@module "eggfriedrice.extra.rofi"
---@license MIT

local M = {}

---The roles a launcher takes from the palette. The file exposes the
---whole palette as global properties and lists these as suggested uses.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "window_background", "bg" },
		{ "text", "fg" },
		{ "muted", "comment" },
		{ "accent", "yellow" },
		{ "selected_background", "selection" },
		{ "selected_text", "fg" },
		{ "urgent", "red" },
		{ "active", "green" },
		{ "border", "fg_gutter_ui" },
		{ "input_background", "bg_light" },
	}
end

---rasi property name: hyphenated, and `border` renamed so it never
---shadows rofi's own border-width property in the `*` block.
---@param name string
---@return string
local function prop(name)
	return name == "border" and "border-accent" or (name:gsub("_", "-"))
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local lines = { extra.header("rofi") .. "* {" }
	for _, color in ipairs(extra.colors(c)) do
		lines[#lines + 1] = ("    %s: %s;"):format(prop(color[1]), color[2])
	end
	lines[#lines + 1] = "}"
	lines[#lines + 1] = ""
	lines[#lines + 1] = "// suggested roles"
	for _, e in ipairs(M.roles(c)) do
		lines[#lines + 1] = ("// %s: @%s"):format(prop(e[1]), prop(e[2]))
	end
	lines[#lines + 1] = ""
	return table.concat(lines, "\n")
end

return M
