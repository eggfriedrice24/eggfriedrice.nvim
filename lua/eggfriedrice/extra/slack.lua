---@module "eggfriedrice.extra.slack"
---@license MIT

local M = {}

---Slack's custom theme, the four fields of Preferences > Appearance >
---Custom theme, in the order the Import box expects.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "system_navigation", "bg_dark" },
		{ "selected_items", "yellow" },
		{ "presence_indication", "green" },
		{ "notifications", "red" },
	}
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local hexes, names = {}, {}
	for _, e in ipairs(M.roles(c)) do
		hexes[#hexes + 1] = extra.hex(c, e[2])
		names[#names + 1] = e[1]
	end
	return extra.header("slack")
		.. "# order: "
		.. table.concat(names, ", ")
		.. "\n"
		.. "# turn off Window gradient unless you want the yellow bleeding into the sidebar\n"
		.. table.concat(hexes, ",")
		.. "\n"
end

return M
