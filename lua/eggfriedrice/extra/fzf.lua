---@module "eggfriedrice.extra.fzf"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- Only color names every fzf since 0.21 understands, so an old binary
	-- does not refuse to start. bg is left unset so a translucent terminal
	-- shows through; add --color=bg:${bg} for an opaque list.
	return require("eggfriedrice.extra").header("fzf")
		.. util.template(
			[[
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:${fg},fg+:${fg},bg+:${bg_light},gutter:-1 \
  --color=hl:${yellow},hl+:${yellow},info:${comment},prompt:${yellow} \
  --color=pointer:${yellow},marker:${green},spinner:${cyan},header:${cyan} \
  --color=border:${fg_gutter_ui}"
]],
			c
		)
end

return M
