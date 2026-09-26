---@module "eggfriedrice.extra.lazygit"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	return require("eggfriedrice.extra").header("lazygit")
		.. util.template(
			[[
gui:
  theme:
    activeBorderColor: ["${yellow}", bold]
    inactiveBorderColor: ["${fg_gutter_ui}"]
    searchingActiveBorderColor: ["${cyan}", bold]
    optionsTextColor: ["${cyan}"]
    selectedLineBgColor: ["${selection}"]
    inactiveViewSelectedLineBgColor: ["${bg_light}"]
    cherryPickedCommitFgColor: ["${bg}"]
    cherryPickedCommitBgColor: ["${cyan}"]
    markedBaseCommitFgColor: ["${bg}"]
    markedBaseCommitBgColor: ["${yellow}"]
    unstagedChangesColor: ["${red}"]
    defaultFgColor: ["${fg}"]
]],
			c
		)
end

return M
