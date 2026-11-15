---@module "eggfriedrice.extra.rofi"
---@license MIT

local M = {}

---`#rrggbbaa`, since rasi has no alpha().
---@param hex string
---@param a number 0..1
---@return string
local function alpha(hex, a)
	return hex .. ("%02x"):format(math.floor(a * 255 + 0.5))
end

---The roles a launcher takes from the palette: a translucent panel the
---compositor blurs through, a faint edge and divider, and a filled accent
---row for the selection. The file exposes the whole palette and these
---roles as global properties.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	return {
		{ "panel", alpha(c.bg, 0.72) },
		{ "panel_edge", alpha(c.fg_gutter_ui, 0.40) },
		{ "panel_divider", alpha(c.fg_gutter_ui, 0.25) },
		{ "foreground", "fg" },
		{ "input", "fg_bright" },
		{ "muted", "comment" },
		{ "accent", "yellow" },
		{ "on_accent", require("eggfriedrice.extra.palette").on_accent },
		{ "urgent", "red" },
	}
end

---The fonts a launcher takes from the typography tokens, as Pango font
---strings (rofi's `font` takes family, weight and size in one value, so
---each size of the scale is its own property). The icon font matches the
---largest text; the emoji font is sized for a cell of an emoji grid, not
---for running text.
---@param t eggfriedrice.Typography
---@return { [1]: string, [2]: string }[] name, font string
function M.fonts(t)
	local typography = require("eggfriedrice.typography")
	local out = {}
	for _, size in ipairs(typography.sizes) do
		out[#out + 1] = { "font_ui_" .. size, typography.pango(t.font.ui, t.size[size], t.weight.ui) }
	end
	vim.list_extend(out, {
		{ "font_ui_emphasis", typography.pango(t.font.ui, t.size.sm, t.weight.emphasis) },
		{ "font_mono", typography.pango(t.font.mono, t.size.sm) },
		{ "font_icon", typography.pango(t.font.icon, t.size.lg) },
		{ "font_emoji", typography.pango(t.font.emoji, 20) },
	})
	return out
end

---rasi property name: hyphenated, and the palette's `border` renamed so
---it never shadows rofi's own border-width property in the `*` block.
---@param name string
---@return string
local function prop(name)
	return name == "border" and "border-accent" or (name:gsub("_", "-"))
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local lines = { extra.header("rofi") .. "* {" }
	for _, color in ipairs(extra.colors(c)) do
		lines[#lines + 1] = ("    %s: %s;"):format(prop(color[1]), color[2])
	end
	lines[#lines + 1] = ""
	lines[#lines + 1] = "    // launcher roles"
	for _, e in ipairs(M.roles(c)) do
		lines[#lines + 1] = ("    %s: %s;"):format(prop(e[1]), extra.hex(c, e[2]))
	end
	lines[#lines + 1] = ""
	lines[#lines + 1] = "    // typography, for `font: @font-ui-sm;`"
	for _, e in ipairs(M.fonts(require("eggfriedrice.typography").get())) do
		lines[#lines + 1] = ('    %s: "%s";'):format(prop(e[1]), e[2])
	end
	lines[#lines + 1] = "}"
	lines[#lines + 1] = ""
	return table.concat(lines, "\n")
end

return M
