---@module "eggfriedrice.extra.slack"
---@license MIT

local M = {}

---The four fields of the redesigned Slack's custom theme, in the order
---its Import box takes them, plus the classic ten-color string for the
---old client. The main navy, not the darkest shade, carries the sidebar
---so the hue survives next to Slack's fixed dark message pane.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "system_navigation", "bg" },
		{ "selected_items", "yellow" },
		{ "presence_indication", "green" },
		{ "notifications", "red" },
		{
			"legacy",
			{
				{ "column_bg", "bg" },
				{ "menu_bg_hover", "bg_light" },
				{ "active_item", "yellow" },
				{ "active_item_text", "bg" },
				{ "hover_item", "selection" },
				{ "text_color", "fg" },
				{ "active_presence", "green" },
				{ "mention_badge", "red" },
				{ "top_nav_bg", "bg" },
				{ "top_nav_text", "fg" },
			},
		},
	}
end

---@param c table
---@param entries eggfriedrice.Entry[]
---@return string names, string hexes
local function line(c, entries)
	local extra = require("eggfriedrice.extra")
	local hexes, names = {}, {}
	for _, e in ipairs(entries) do
		hexes[#hexes + 1] = extra.hex(c, e[2])
		names[#names + 1] = e[1]
	end
	return table.concat(names, ", "), table.concat(hexes, ",")
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local roles = M.roles(c)
	local current = {}
	for _, e in ipairs(roles) do
		if e[1] ~= "legacy" then
			current[#current + 1] = e
		end
	end
	local names, hexes = line(c, current)
	local legacy_names, legacy_hexes = line(c, extra.role(roles, "legacy"))
	return extra.header("slack")
		.. "# "
		.. names
		.. "\n"
		.. "# turn off Window gradient unless you want the yellow bleeding into the sidebar\n"
		.. hexes
		.. "\n\n"
		.. "# classic client: "
		.. legacy_names
		.. "\n"
		.. legacy_hexes
		.. "\n"
end

return M
