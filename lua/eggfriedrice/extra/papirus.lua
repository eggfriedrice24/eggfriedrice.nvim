---@module "eggfriedrice.extra.papirus"
---@license MIT

-- Papirus draws each folder color with three hexes: the front face, the
-- back face behind it, and the symbol stamped on the front (documents,
-- music, ...). papirus-folders only switches between its preset colors,
-- so this file carries the palette's three as shell variables and the
-- dotfiles' recolor script swaps them into a copy of Papirus's yellow
-- folders. The back and symbol keep the accent's hue at Papirus's own
-- lightness steps, so the folder still reads as one solid object.

local M = {}

local util = require("eggfriedrice.util")

---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	return {
		{ "folder_front", "yellow" },
		{ "folder_back", util.tint(c.yellow, 0.74, 0.155) },
		{ "folder_symbol", util.tint(c.yellow, 0.40, 0.07) },
	}
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local lines = {}
	for _, e in ipairs(M.roles(c)) do
		lines[#lines + 1] = ('%s="%s"'):format(e[1]:upper(), extra.hex(c, e[2]))
	end
	return extra.header("papirus") .. table.concat(lines, "\n") .. "\n"
end

return M
