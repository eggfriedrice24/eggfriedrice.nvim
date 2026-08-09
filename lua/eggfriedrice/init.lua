---@module "eggfriedrice"
---@author eggfriedrice24
---@license MIT

local M = {}

---@class eggfriedrice.Config
---@field transparent boolean
---@field italic_comments boolean
---@field dim_inactive boolean
---@field on_colors? fun(colors: table)
---@field on_highlights? fun(highlights: table<string, vim.api.keyset.highlight>, colors: table)
M.config = {
	transparent = false,
	italic_comments = true,
	dim_inactive = false,
	on_colors = nil,
	on_highlights = nil,
}

---@param opts? eggfriedrice.Config
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

---@param c table
local function terminal(c)
	local util = require("eggfriedrice.util")
	vim.g.terminal_color_0 = c.bg_light
	vim.g.terminal_color_8 = c.comment
	vim.g.terminal_color_1 = c.red
	vim.g.terminal_color_9 = c.red
	vim.g.terminal_color_2 = c.green
	vim.g.terminal_color_10 = c.green
	vim.g.terminal_color_3 = c.yellow
	vim.g.terminal_color_11 = c.yellow
	vim.g.terminal_color_4 = c.cyan
	vim.g.terminal_color_12 = c.cyan
	vim.g.terminal_color_5 = c.rose
	vim.g.terminal_color_13 = c.rose
	vim.g.terminal_color_6 = util.blend(c.cyan, "#ffffff", 0.8)
	vim.g.terminal_color_14 = util.blend(c.cyan, "#ffffff", 0.8)
	vim.g.terminal_color_7 = c.fg
	vim.g.terminal_color_15 = util.blend(c.fg, "#ffffff", 0.7)
end

function M.load()
	if vim.g.colors_name then
		vim.cmd("hi clear")
	end

	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.o.background = "dark"
	vim.g.colors_name = "eggfriedrice"

	local config = M.config
	local c = require("eggfriedrice.colors").get(config)

	local groups = {}
	for _, mod in ipairs({ "highlights", "treesitter", "lsp", "plugins" }) do
		for group, spec in pairs(require("eggfriedrice." .. mod).get(c, config)) do
			groups[group] = spec
		end
	end

	if config.on_highlights then
		config.on_highlights(groups, c)
	end

	require("eggfriedrice.util").apply(groups)
	terminal(c)
end

return M
