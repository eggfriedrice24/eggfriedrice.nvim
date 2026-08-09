---@module "eggfriedrice.colors"
---@author eggfriedrice24
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---Build the palette. Derived values are computed before the `on_colors`
---hook runs, so the hook receives the complete table and can override
---anything, including derived backgrounds.
---@param config? eggfriedrice.Config
---@return table
function M.get(config)
	local c = {
		-- Base
		bg = "#1a1a1a",
		bg_dark = "#121212",
		bg_light = "#252525",
		fg = "#d8d3c3", -- rice: warm cream
		fg_dark = "#a8a396",
		fg_gutter = "#4d4a41",

		-- Palette
		yellow = "#f2c94c", -- yolk: keywords, the signature
		orange = "#ffae57", -- functions, annotations
		green = "#a5d65f", -- scallion: strings
		cyan = "#7fd8ce", -- the one cool accent: types
		rose = "#ffa1ad", -- data literals: numbers, constants, escapes
		red = "#eb5757", -- errors, deletions

		-- Semantic
		comment = "#7a7568",
		selection = "#3d3225",
		border = "#c9a747",

		none = "NONE",
	}

	-- Diagnostic
	c.error = c.red
	c.warning = c.orange
	c.info = c.cyan
	c.hint = c.green

	-- Git
	c.git_add = c.green
	c.git_change = c.yellow
	c.git_delete = c.red

	-- Derived backgrounds
	c.diff = {
		add = util.blend(c.green, c.bg, 0.15),
		change = util.blend(c.yellow, c.bg, 0.10),
		delete = util.blend(c.red, c.bg, 0.15),
		text = util.blend(c.yellow, c.bg, 0.30),
	}
	c.search = util.blend(c.yellow, c.bg, 0.30)
	c.scope = util.blend(c.yellow, c.bg, 0.45)

	if config and config.on_colors then
		config.on_colors(c)
	end

	return c
end

return M
