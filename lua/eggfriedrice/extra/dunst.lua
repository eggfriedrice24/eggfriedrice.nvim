---@module "eggfriedrice.extra.dunst"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---Frames follow the border roles (gray default, gold accent, red
---critical); the progress bar is the signature.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "global", { { "frame_color", "fg_gutter_ui" }, { "separator_color", "frame" }, { "highlight", "yellow" } } },
		{
			"urgency_low",
			{
				{ "background", "bg" },
				{ "foreground", "comment" },
				{ "frame_color", "fg_gutter_ui" },
				{ "highlight", "cyan" },
			},
		},
		{
			"urgency_normal",
			{ { "background", "bg" }, { "foreground", "fg" }, { "frame_color", "border" }, { "highlight", "yellow" } },
		},
		{
			"urgency_critical",
			{ { "background", "bg" }, { "foreground", "fg" }, { "frame_color", "red" }, { "highlight", "red" } },
		},
	}
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	return extra.header("dunst")
		.. util.template(
			[[
[global]
    frame_color = "${global_frame_color}"
    separator_color = ${global_separator_color}
    highlight = "${global_highlight}"

[urgency_low]
    background = "${urgency_low_background}"
    foreground = "${urgency_low_foreground}"
    frame_color = "${urgency_low_frame_color}"
    highlight = "${urgency_low_highlight}"

[urgency_normal]
    background = "${urgency_normal_background}"
    foreground = "${urgency_normal_foreground}"
    frame_color = "${urgency_normal_frame_color}"
    highlight = "${urgency_normal_highlight}"

[urgency_critical]
    background = "${urgency_critical_background}"
    foreground = "${urgency_critical_foreground}"
    frame_color = "${urgency_critical_frame_color}"
    highlight = "${urgency_critical_highlight}"
]],
			extra.vars(c, M.roles(c))
		)
end

return M
