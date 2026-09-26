---@module "eggfriedrice.extra.slack"
---@license MIT

local M = {}

---Slack's custom theme string, ten colors in this fixed order.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "column_bg", "bg_dark" },
		{ "menu_bg_hover", "bg_light" },
		{ "active_item", "yellow" },
		{ "active_item_text", "bg" },
		{ "hover_item", "selection" },
		{ "text_color", "fg" },
		{ "active_presence", "green" },
		{ "mention_badge", "red" },
		{ "top_nav_bg", "bg" },
		{ "top_nav_text", "fg" },
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
	return extra.header("slack") .. "# order: " .. table.concat(names, ", ") .. "\n" .. table.concat(hexes, ",") .. "\n"
end

return M
