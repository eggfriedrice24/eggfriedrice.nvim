---@module "eggfriedrice.extra.dunst"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- A dunstrc.d drop-in: frames follow the border roles (gray default,
	-- gold accent, red critical), the progress bar is the signature.
	return require("eggfriedrice.extra").header("dunst")
		.. util.template(
			[[
[global]
    frame_color = "${fg_gutter_ui}"
    separator_color = frame
    highlight = "${yellow}"

[urgency_low]
    background = "${bg}"
    foreground = "${comment}"
    frame_color = "${fg_gutter_ui}"
    highlight = "${cyan}"

[urgency_normal]
    background = "${bg}"
    foreground = "${fg}"
    frame_color = "${border}"
    highlight = "${yellow}"

[urgency_critical]
    background = "${bg}"
    foreground = "${fg}"
    frame_color = "${red}"
    highlight = "${red}"
]],
			c
		)
end

return M
