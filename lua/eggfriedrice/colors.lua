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
		bg = "#0d111a",
		bg_dark = "#090c13",
		bg_light = "#121722",
		fg = "#d8d3c3", -- rice: warm cream
		fg_dark = "#a8a396",
		fg_gutter = "#46516c",

		-- Palette. Roles follow One Dark Pro: red is the identifier
		-- color (variables, fields, keys, tags), purple the keyword
		-- color, blue the operator color (their cyan). Yellow, the
		-- signature, takes their yellow, blue and orange roles at once:
		-- types, builtins, functions, and literals. Orange is dormant.
		yellow = "#ffc940", -- yolk: functions, types, builtins, numbers, booleans, constants, attributes
		orange = "#fc9a2c", -- dormant: not assigned to any group
		green = "#00c950", -- strings
		cyan = "#78e2d6", -- escapes, enum members, UI accents
		blue = "#6cb8ff", -- operators (One Dark Pro uses cyan here)
		purple = "#c678dd", -- keywords, decorators
		red = "#e06c75", -- variables, fields, keys, tags, errors

		-- Semantic
		comment = "#8695b7", -- halcyon blue-gray: recedes on navy
		selection = "#2f3b54",
		border = "#c9a747",

		none = "NONE",
	}

	-- Diagnostic
	c.error = c.red
	c.warning = c.yellow
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
