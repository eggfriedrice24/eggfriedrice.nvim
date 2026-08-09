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
		-- Base (halcyon-inspired navy)
		bg = "#171c28",
		bg_dark = "#111522",
		bg_light = "#1d2433",
		fg = "#d8d3c3", -- rice: warm cream
		fg_dark = "#a8a396",
		fg_gutter = "#46516c",

		-- Palette
		yellow = "#ffc940", -- yolk: keywords, the signature
		orange = "#ffae57", -- functions
		green = "#a5d65f", -- scallion: strings
		cyan = "#5ad4c6", -- types, classes, tags
		blue = "#6cb8ff", -- members, properties
		purple = "#c678dd", -- booleans, builtin constants, decorators
		rose = "#ff7a95", -- numbers, constants, escapes
		red = "#eb5757", -- errors, deletions

		-- Semantic
		comment = "#8695b7", -- halcyon blue-gray: recedes on navy
		selection = "#2f3b54",
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
