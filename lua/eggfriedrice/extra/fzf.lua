---@module "eggfriedrice.extra.fzf"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- query, label, separator and scrollbar need fzf 0.36 or newer; older
	-- binaries refuse unknown color names.
	return require("eggfriedrice.extra").header("fzf")
		.. util.template(
			[[
# requires fzf >= 0.36
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:${fg},fg+:${fg},bg:${bg},bg+:${bg_light} \
  --color=hl:${yellow},hl+:${yellow},info:${comment},prompt:${yellow} \
  --color=pointer:${yellow},marker:${green},spinner:${cyan},header:${cyan} \
  --color=border:${fg_gutter_ui},gutter:${bg},query:${fg},label:${border} \
  --color=separator:${fg_gutter_ui},scrollbar:${fg_gutter}"
]],
			c
		)
end

return M
