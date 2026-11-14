---@module "eggfriedrice.extra.adw"
---@license MIT

-- GTK apps through adw-gtk3 (GTK3) and libadwaita (GTK4). Both draw every
-- surface from a set of named colors, so redefining those names in the
-- user's gtk.css recolors the whole toolkit; the legacy @theme_* names,
-- hover, selection and borders derive from them. A stock theme with its
-- colors compiled in (catppuccin-gtk and most others) cannot be recolored
-- this way, which is why the base theme has to be adw-gtk3.

local M = {}

local util = require("eggfriedrice.util")

---Black at an opacity, for the shades that darken whatever is beneath.
---@param a number
---@return string
local function shade(a)
	return util.rgba("#000000", a)
end

---The named colors adw-gtk3 and libadwaita read, in the order the
---libadwaita docs list them.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "accent_bg_color", "yellow" },
		{ "accent_fg_color", "bg_dark" },
		{ "accent_color", "yellow" },
		{ "destructive_bg_color", "red" },
		{ "destructive_fg_color", "bg_dark" },
		{ "destructive_color", "red" },
		{ "success_bg_color", "green" },
		{ "success_fg_color", "bg_dark" },
		{ "success_color", "green" },
		{ "warning_bg_color", "warning" },
		{ "warning_fg_color", "bg_dark" },
		{ "warning_color", "warning" },
		{ "error_bg_color", "error" },
		{ "error_fg_color", "bg_dark" },
		{ "error_color", "error" },
		{ "", "" },
		{ "window_bg_color", "bg" },
		{ "window_fg_color", "fg" },
		{ "view_bg_color", "bg" },
		{ "view_fg_color", "fg" },
		{ "headerbar_bg_color", "bg_dark" },
		{ "headerbar_fg_color", "fg" },
		{ "headerbar_border_color", "fg" },
		{ "headerbar_backdrop_color", "bg_dark" },
		{ "headerbar_shade_color", shade(0.36) },
		{ "headerbar_darker_shade_color", shade(0.9) },
		{ "sidebar_bg_color", "bg_dark" },
		{ "sidebar_fg_color", "fg" },
		{ "sidebar_backdrop_color", "bg_dark" },
		{ "sidebar_shade_color", shade(0.25) },
		{ "sidebar_border_color", shade(0.36) },
		{ "secondary_sidebar_bg_color", "bg_dark" },
		{ "secondary_sidebar_fg_color", "fg" },
		{ "secondary_sidebar_backdrop_color", "bg_dark" },
		{ "secondary_sidebar_shade_color", shade(0.25) },
		{ "secondary_sidebar_border_color", shade(0.36) },
		{ "card_bg_color", "bg_light" },
		{ "card_fg_color", "fg" },
		{ "card_shade_color", shade(0.36) },
		{ "dialog_bg_color", "bg_light" },
		{ "dialog_fg_color", "fg" },
		{ "popover_bg_color", "bg_light" },
		{ "popover_fg_color", "fg" },
		{ "popover_shade_color", shade(0.25) },
		{ "thumbnail_bg_color", "bg_light" },
		{ "thumbnail_fg_color", "fg" },
		{ "shade_color", shade(0.25) },
		{ "scrollbar_outline_color", shade(0.5) },
		{ "panel_bg_color", "bg_dark" },
		{ "panel_fg_color", "fg" },
	}
end

-- adw-gtk3 writes a few colors straight into its rules instead of naming
-- them: white text on suggested buttons (unreadable on a yellow accent)
-- and a black tooltip. These rules put the named colors back.
local gtk3_fixes = [[
button.suggested-action,
button.suggested-action:hover,
button.suggested-action:active,
button.suggested-action:checked {
  color: @accent_fg_color;
}

tooltip {
  text-shadow: none;
}

tooltip.background {
  background-color: @popover_bg_color;
  border: 1px solid alpha(@window_fg_color, 0.1);
}

tooltip * {
  color: @popover_fg_color;
}
]]

-- libadwaita takes its accent from the system accent setting unless the
-- variables are set; plain GTK4 apps on adw-gtk3's tweaks read them too.
local gtk4_accent = [[
:root {
  --accent-bg-color: @accent_bg_color;
  --accent-fg-color: @accent_fg_color;
  --accent-color: @accent_color;
}
]]

---@param c table
---@param name string extra name, for the header
---@return string[]
local function colors(c, name)
	local extra = require("eggfriedrice.extra")
	local lines = {
		"/*",
		" * eggfriedrice for " .. extra.extras[name].label,
		" * generated from lua/eggfriedrice/colors.lua by `make extras`; do not edit by hand",
		" * install: " .. extra.extras[name].install,
		" */",
		"",
	}
	for _, e in ipairs(M.roles(c)) do
		if e[1] == "" then
			lines[#lines + 1] = ""
		else
			lines[#lines + 1] = ("@define-color %s %s;"):format(e[1], extra.hex(c, e[2]))
		end
	end
	lines[#lines + 1] = ""
	return lines
end

---gtk-3.0: the named colors plus the fixes for adw-gtk3's literals.
---@param c table
---@return string
function M.generate(c)
	local lines = colors(c, "adw")
	lines[#lines + 1] = gtk3_fixes
	return table.concat(lines, "\n")
end

---gtk-4.0: the named colors plus the accent variables.
---@param c table
---@return string
function M.generate_gtk4(c)
	local lines = colors(c, "adw-gtk4")
	lines[#lines + 1] = gtk4_accent
	return table.concat(lines, "\n")
end

return M
