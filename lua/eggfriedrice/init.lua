---@module "eggfriedrice"
---@author eggfriedrice24
---@license MIT

local M = {}

M.config = {
	transparent = false,
	italic_comments = true,
	dim_inactive = false,
}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.load()
	if vim.g.colors_name then
		vim.cmd("hi clear")
	end

	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.o.background = "dark"
	vim.g.colors_name = "eggfriedrice"

	local colors = require("eggfriedrice.colors")

	require("eggfriedrice.highlights").setup(colors, M.config)
	require("eggfriedrice.treesitter").setup(colors, M.config)
	require("eggfriedrice.lsp").setup(colors, M.config)
	require("eggfriedrice.plugins").setup(colors, M.config)
end

return M
