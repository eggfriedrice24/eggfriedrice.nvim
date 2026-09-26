---@module "eggfriedrice.extra.tmux"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- Styles only, no status layout. The palette is also exported as user
	-- options so a status format can say #[fg=#{@eggfriedrice_yellow}].
	local extra = require("eggfriedrice.extra")
	local options = {}
	for _, color in ipairs(extra.colors(c)) do
		options[#options + 1] = ('set -g @eggfriedrice_%s "%s"'):format(color[1], color[2])
	end
	return extra.header("tmux")
		.. table.concat(options, "\n")
		.. "\n\n"
		.. util.template(
			[[
set -g status-style "fg=${fg_dark},bg=${bg_dark}"
set -g status-left-style "fg=${bg},bg=${yellow},bold"
set -g status-right-style "fg=${comment},bg=${bg_dark}"

set -g window-status-style "fg=${comment},bg=${bg_dark}"
set -g window-status-current-style "fg=${fg},bg=${bg},bold"
set -g window-status-activity-style "fg=${orange},bg=${bg_dark}"
set -g window-status-bell-style "fg=${bg},bg=${yellow},bold"

set -g window-style "bg=${bg_dark}"
set -g window-active-style "bg=${bg}"
set -g pane-border-style "fg=${fg_gutter_ui}"
set -g pane-active-border-style "fg=${border}"

# current-window indicator, for your window-status-current-format: #[fg=${yellow}]

set -g message-style "fg=${fg},bg=${bg_light}"
set -g message-command-style "fg=${yellow},bg=${bg_light}"
set -g mode-style "fg=${fg},bg=${selection}"
set -g copy-mode-match-style "fg=${fg},bg=${search}"
set -g copy-mode-current-match-style "fg=${bg},bg=${search_selected}"

set -g popup-style "fg=${fg},bg=${bg_dark}"
set -g popup-border-style "fg=${border}"

set -g clock-mode-colour "${yellow}"
set -g display-panes-colour "${fg_gutter_ui}"
set -g display-panes-active-colour "${yellow}"
]],
			c
		)
end

return M
