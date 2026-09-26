---@module "eggfriedrice.extra.hyprland"
---@license MIT

local M = {}

---The roles a Hyprland setup takes from the palette. The file exposes
---the whole palette as variables and lists these as suggested uses.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "active_border", "border" },
		{ "inactive_border", "fg_gutter_ui" },
		{ "lock_outer", "yellow" },
		{ "lock_inner", "bg" },
		{ "lock_font", "fg" },
	}
end

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
	local roles = M.roles(c)
	vim.list_extend(lines, {
		"",
		"# suggested roles",
		("# general:col.active_border = $%s"):format(extra.role(roles, "active_border")),
		("# general:col.inactive_border = $%s"):format(extra.role(roles, "inactive_border")),
		("# hyprlock input-field: outer_color = $%s, inner_color = $%s, font_color = $%s"):format(
			extra.role(roles, "lock_outer"),
			extra.role(roles, "lock_inner"),
			extra.role(roles, "lock_font")
		),
		"",
	})
	return extra.header("hyprland") .. table.concat(lines, "\n")
end

return M
