---@module "eggfriedrice.extra.ghostty"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	return require("eggfriedrice.extra").header("ghostty")
		.. util.template(
			[[
background = ${bg}
foreground = ${fg}

cursor-color = ${yellow}
cursor-text = ${bg}

selection-background = ${selection}
selection-foreground = ${fg}

# matches blend yellow into the background; the current match is lit
# enough to carry dark text
search-background = ${search}
search-foreground = ${fg}
search-selected-background = ${search_selected}
search-selected-foreground = ${bg}

split-divider-color = ${fg_gutter_ui}
unfocused-split-fill = ${bg_dark}
unfocused-split-opacity = 0.85

window-titlebar-background = ${bg_dark}
window-titlebar-foreground = ${fg_dark}

palette = 0=${bg_light}
palette = 1=${red}
palette = 2=${green}
palette = 3=${yellow}
palette = 4=${blue}
palette = 5=${purple}
palette = 6=${cyan}
palette = 7=${fg}
palette = 8=${comment}
palette = 9=${red_bright}
palette = 10=${green_bright}
palette = 11=${yellow_bright}
palette = 12=${blue_bright}
palette = 13=${purple_bright}
palette = 14=${cyan_bright}
palette = 15=${fg_bright}

# derive the 256-color cube from these sixteen instead of the xterm defaults
palette-generate = true
]],
			c
		)
end

return M
