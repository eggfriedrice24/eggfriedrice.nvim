---@module "eggfriedrice.typography"
---@author eggfriedrice24
---@license MIT

-- The design system's type, next to its colors: which family each kind of
-- text uses, two weights and a small size scale. The colorscheme itself
-- never reads it (the terminal picks the editor's font); the extras emit it
-- so every app around the editor sets the same fonts from one table.

local M = {}

---@class eggfriedrice.Typography
---@field font { ui: string, mono: string, icon: string, emoji: string } family names
---@field weight { ui: integer, emphasis: integer } CSS weights of the ui font
---@field size { xs: integer, sm: integer, md: integer, lg: integer } points

---@return eggfriedrice.Typography
function M.get()
	return {
		font = {
			ui = "Nunito", -- every UI surface: bars, launchers, notifications, file manager
			mono = "Cartograph CF", -- terminal text only
			icon = "JetBrainsMono Nerd Font Propo", -- nerd glyphs the ui font lacks
			emoji = "Noto Color Emoji",
		},
		weight = {
			ui = 500, -- Medium: Regular is too thin at small sizes on the navy
			emphasis = 600, -- SemiBold: titles, the clock, active labels
		},
		-- small on purpose: sm is the default UI size, md the prominent one
		-- (a search field, a location bar), lg the largest text
		size = {
			xs = 9,
			sm = 10,
			md = 11,
			lg = 13,
		},
	}
end

---Size names from small to large, for renderers that list the scale.
M.sizes = { "xs", "sm", "md", "lg" }

---Font families in the order renderers list them.
M.fonts = { "ui", "mono", "icon", "emoji" }

---Style names Pango and fontconfig use for the CSS weights.
local weight_names = {
	[400] = "Regular",
	[500] = "Medium",
	[600] = "SemiBold",
	[700] = "Bold",
}

---Style name of a CSS weight ("Medium" for 500).
---@param weight integer
---@return string
function M.weight_name(weight)
	return assert(weight_names[weight], "no style name for weight " .. weight)
end

---A Pango font description string such as "Nunito Medium 10", the form
---rofi, dunst and GTK's font-name setting take.
---@param family string
---@param size number points
---@param weight? integer CSS weight; none for fonts with a single weight
---@return string
function M.pango(family, size, weight)
	local parts = { family }
	if weight then
		parts[#parts + 1] = M.weight_name(weight)
	end
	parts[#parts + 1] = tostring(size)
	return table.concat(parts, " ")
end

return M
