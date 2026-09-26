---@module "eggfriedrice.extra.ghostty"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "background", "bg" },
		{ "foreground", "fg" },
		{ "cursor_color", "yellow" },
		{ "cursor_text", "bg" },
		{ "selection_background", "selection" },
		{ "selection_foreground", "fg" },
		{ "search_background", "search" },
		{ "search_foreground", "fg" },
		{ "search_selected_background", "search_selected" },
		{ "search_selected_foreground", "bg" },
		{ "split_divider_color", "fg_gutter_ui" },
		{ "unfocused_split_fill", "bg_dark" },
		{ "unfocused_split_opacity", 0.85 },
		{ "window_titlebar_background", "bg_dark" },
		{ "window_titlebar_foreground", "fg_dark" },
		{ "palette", require("eggfriedrice.extra.palette").ansi },
		{ "palette_generate", true },
	}
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	return extra.header("ghostty")
		.. util.template(
			[[
background = ${background}
foreground = ${foreground}

cursor-color = ${cursor_color}
cursor-text = ${cursor_text}

selection-background = ${selection_background}
selection-foreground = ${selection_foreground}

# matches blend yellow into the background; the current match is lit
# enough to carry dark text
search-background = ${search_background}
search-foreground = ${search_foreground}
search-selected-background = ${search_selected_background}
search-selected-foreground = ${search_selected_foreground}

split-divider-color = ${split_divider_color}
unfocused-split-fill = ${unfocused_split_fill}
unfocused-split-opacity = ${unfocused_split_opacity}

window-titlebar-background = ${window_titlebar_background}
window-titlebar-foreground = ${window_titlebar_foreground}

palette = 0=${palette_0}
palette = 1=${palette_1}
palette = 2=${palette_2}
palette = 3=${palette_3}
palette = 4=${palette_4}
palette = 5=${palette_5}
palette = 6=${palette_6}
palette = 7=${palette_7}
palette = 8=${palette_8}
palette = 9=${palette_9}
palette = 10=${palette_10}
palette = 11=${palette_11}
palette = 12=${palette_12}
palette = 13=${palette_13}
palette = 14=${palette_14}
palette = 15=${palette_15}

# derive the 256-color cube from these sixteen instead of the xterm defaults
palette-generate = ${palette_generate}
]],
			extra.vars(c, M.roles(c))
		)
end

return M
