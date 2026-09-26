---@module "eggfriedrice.extra.rofi"
---@license MIT

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- Global rasi properties, hyphenated because rasi identifiers take no
	-- underscores. Themes `@import` this file and reference `@yellow`.
	-- `border` is renamed `border-accent`: in the `*` block a plain
	-- `border` would shadow rofi's own border-width property on every
	-- widget.
	local extra = require("eggfriedrice.extra")
	local lines = { extra.header("rofi") .. "* {" }
	for _, color in ipairs(extra.colors(c)) do
		local name = color[1] == "border" and "border-accent" or color[1]:gsub("_", "-")
		lines[#lines + 1] = ("    %s: %s;"):format(name, color[2])
	end
	lines[#lines + 1] = "}"
	lines[#lines + 1] = ""
	return table.concat(lines, "\n")
end

return M
