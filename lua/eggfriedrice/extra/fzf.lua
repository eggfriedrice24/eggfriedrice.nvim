---@module "eggfriedrice.extra.fzf"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "fg", "fg" },
		{ "fg_plus", "fg" },
		{ "bg", "bg" },
		{ "bg_plus", "bg_light" },
		{ "hl", "yellow" },
		{ "hl_plus", "yellow" },
		{ "info", "comment" },
		{ "prompt", "yellow" },
		{ "pointer", "yellow" },
		{ "marker", "green" },
		{ "spinner", "cyan" },
		{ "border", "fg_gutter_ui" },
		{ "header", "cyan" },
		{ "gutter", "bg" },
		{ "query", "fg" },
		{ "label", "border" },
		{ "separator", "fg_gutter_ui" },
		{ "scrollbar", "fg_gutter" },
	}
end

---@param c table
---@return string
function M.generate(c)
	-- query, label, separator and scrollbar need fzf 0.36 or newer; older
	-- binaries refuse unknown color names.
	local extra = require("eggfriedrice.extra")
	return extra.header("fzf")
		.. util.template(
			[[
# requires fzf >= 0.36
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:${fg},fg+:${fg_plus},bg:${bg},bg+:${bg_plus} \
  --color=hl:${hl},hl+:${hl_plus},info:${info},prompt:${prompt} \
  --color=pointer:${pointer},marker:${marker},spinner:${spinner},header:${header} \
  --color=border:${border},gutter:${gutter},query:${query},label:${label} \
  --color=separator:${separator},scrollbar:${scrollbar}"
]],
			extra.vars(c, M.roles(c))
		)
end

return M
