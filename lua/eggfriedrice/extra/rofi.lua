---@module "eggfriedrice.extra.rofi"
---@license MIT

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- Global rasi properties, hyphenated because rasi identifiers take no
	-- underscores. Themes `@import` this file and reference `@yellow`.
	local extra = require("eggfriedrice.extra")
	local lines = { extra.header("rofi") .. "* {" }
	for _, color in ipairs(extra.colors(c)) do
		lines[#lines + 1] = ("    %s: %s;"):format(color[1]:gsub("_", "-"), color[2])
	end
	lines[#lines + 1] = "}"
	lines[#lines + 1] = ""
	return table.concat(lines, "\n")
end

return M
