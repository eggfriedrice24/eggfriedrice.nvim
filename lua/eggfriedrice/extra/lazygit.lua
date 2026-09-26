---@module "eggfriedrice.extra.lazygit"
---@license MIT

local M = {}

---lazygit's gui.theme keys, each a color list with optional attributes.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "activeBorderColor", { fg = "yellow", bold = true } },
		{ "inactiveBorderColor", { fg = "fg_gutter_ui" } },
		{ "searchingActiveBorderColor", { fg = "cyan", bold = true } },
		{ "optionsTextColor", { fg = "cyan" } },
		{ "selectedLineBgColor", { bg = "selection" } },
		{ "inactiveViewSelectedLineBgColor", { bg = "bg_light" } },
		{ "cherryPickedCommitFgColor", { fg = "bg" } },
		{ "cherryPickedCommitBgColor", { bg = "cyan" } },
		{ "markedBaseCommitFgColor", { fg = "bg" } },
		{ "markedBaseCommitBgColor", { bg = "yellow" } },
		{ "unstagedChangesColor", { fg = "red" } },
		{ "defaultFgColor", { fg = "fg" } },
	}
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local lines = { "gui:", "  theme:" }
	for _, e in ipairs(M.roles(c)) do
		local items = { ('"%s"'):format(extra.hex(c, e[2].fg or e[2].bg)) }
		if e[2].bold then
			items[#items + 1] = "bold"
		end
		lines[#lines + 1] = ("    %s: [%s]"):format(e[1], table.concat(items, ", "))
	end
	lines[#lines + 1] = ""
	return extra.header("lazygit") .. table.concat(lines, "\n")
end

return M
