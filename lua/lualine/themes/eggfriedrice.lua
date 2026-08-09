---eggfriedrice lualine theme
---@author eggfriedrice24
---@license MIT

local config = require("eggfriedrice").config
local c = require("eggfriedrice.colors").get(config)

local function mode(color)
	return {
		a = { fg = c.bg, bg = color, gui = "bold" },
		b = { fg = c.fg, bg = c.bg_light },
		c = { fg = c.fg_dark, bg = c.bg_dark },
	}
end

return {
	normal = mode(c.yellow),
	insert = mode(c.green),
	visual = mode(c.rose),
	replace = mode(c.red),
	command = mode(c.orange),
	terminal = mode(c.cyan),
	inactive = {
		a = { fg = c.comment, bg = c.bg_dark },
		b = { fg = c.comment, bg = c.bg_dark },
		c = { fg = c.comment, bg = c.bg_dark },
	},
}
