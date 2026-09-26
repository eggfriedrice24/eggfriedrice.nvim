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
		fg_gutter = "#46516c", -- decorative: whitespace, indent guides, scrollbar thumbs (2.4:1, on purpose)
		fg_gutter_ui = "#586480", -- readable gutter: line numbers, inactive statusline, dividers (3.2:1)

		-- Palette. Roles follow One Dark Pro: red is the identifier
		-- color (variables, fields, keys, tags), purple the keyword
		-- color, blue the operator color (their cyan). Yellow, the
		-- signature, takes their yellow, blue and orange roles at once:
		-- types, builtins, functions, and literals. Orange is dormant.
		yellow = "#ffc940", -- yolk: functions, types, builtins, numbers, booleans, constants, attributes
		orange = "#fc9a2c", -- dormant: not assigned to any group
		green = "#60e654", -- strings
		cyan = "#78e2d6", -- escapes, enum members, UI accents
		blue = "#6cb8ff", -- operators (One Dark Pro uses cyan here)
		purple = "#c084fc", -- keywords, decorators
		red = "#e06c75", -- variables, fields, keys, tags, errors

		-- Bright tier: ANSI 9-15 in :terminal and the terminal extras.
		-- Each is its base color lifted 0.04 OKLCH lightness with hue
		-- held, so bold text reads as the same color, only lit.
		red_bright = "#fb6c7a",
		green_bright = "#57f749",
		yellow_bright = "#ffda87",
		blue_bright = "#88c4ff",
		purple_bright = "#c996ff",
		cyan_bright = "#5cf5e6",
		fg_bright = "#f2eddd",

		-- Semantic
		comment = "#8695b7", -- halcyon blue-gray: recedes on navy
		selection = "#2f3b54",
		border = "#c9a747", -- accent border: active panes, floats, popups
		search_selected = "#907a41", -- current search match: lit gold that carries dark text

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

	-- Derived backgrounds. Diff tints sit at one OKLCH lightness and chroma
	-- in each accent's hue, so add, change and delete read as one family.
	c.diff = {
		add = util.tint(c.green, 0.27, 0.045),
		change = util.tint(c.yellow, 0.27, 0.045),
		delete = util.tint(c.red, 0.27, 0.045),
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
