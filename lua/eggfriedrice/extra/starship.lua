---@module "eggfriedrice.extra.starship"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- A palette only, never a prompt layout: the user keeps their format
	-- and swaps hexes for names. Redefining `red`, `green`... also retints
	-- any module that still uses the ANSI names.
	return require("eggfriedrice.extra").header("starship")
		.. util.template(
			[[
palette = "eggfriedrice"

[palettes.eggfriedrice]
# base
bg = "${bg}"
bg_dark = "${bg_dark}"
bg_light = "${bg_light}"
fg = "${fg}"
fg_dark = "${fg_dark}"
comment = "${comment}"

# accents (these names shadow starship's ANSI names on purpose)
yellow = "${yellow}"
orange = "${orange}"
red = "${red}"
green = "${green}"
cyan = "${cyan}"
blue = "${blue}"
purple = "${purple}"

# roles, one per module
directory = "${cyan}"
git_branch = "${purple}"
git_status_clean = "${green}"
git_status_dirty = "${yellow}"
git_status_ahead = "${cyan}"
git_status_behind = "${orange}"
git_status_conflicted = "${red}"
character_success = "${yellow}"
character_error = "${red}"
character_vimcmd = "${purple}"
cmd_duration = "${orange}"
language = "${blue}"
status = "${red}"
jobs = "${cyan}"
time = "${comment}"
username = "${fg_dark}"
hostname = "${fg_dark}"

# module styles that use them; merge into your own module tables
# [character]
# success_symbol = "[❯](bold character_success)"
# error_symbol = "[❯](bold character_error)"
# vimcmd_symbol = "[❮](bold character_vimcmd)"
#
# [directory]
# style = "bold directory"
#
# [git_branch]
# style = "git_branch"
#
# [git_status]
# style = "git_status_dirty"
# up_to_date = "[✓](git_status_clean)"
# ahead = "[↑$count](git_status_ahead)"
# behind = "[↓$count](git_status_behind)"
# diverged = "[↕↑$ahead_count↓$behind_count](git_status_behind)"
# conflicted = "[=](bold git_status_conflicted)"
#
# [cmd_duration]
# style = "cmd_duration"
#
# [nodejs]  # and python, golang, java, rust...
# style = "language"
#
# [status]
# style = "status"
#
# [jobs]
# style = "jobs"
#
# [time]
# style = "time"
#
# [username]
# style = "username"
#
# [hostname]
# style = "hostname"
]],
			c
		)
end

return M
