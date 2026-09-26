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

# roles
directory = "${cyan}"
git_branch = "${purple}"
git_clean = "${green}"
git_dirty = "${yellow}"
git_ahead = "${cyan}"
git_behind = "${orange}"
git_conflicted = "${red}"
success = "${yellow}"
error = "${red}"
vimcmd = "${purple}"
duration = "${orange}"
language = "${blue}"
jobs = "${cyan}"
time = "${comment}"
user = "${fg_dark}"

# example usage
# [character]
# success_symbol = "[❯](bold success)"
# error_symbol = "[❯](bold error)"
# vimcmd_symbol = "[❮](bold vimcmd)"
#
# [directory]
# style = "bold directory"
#
# [git_branch]
# style = "bold git_branch"
]],
			c
		)
end

return M
