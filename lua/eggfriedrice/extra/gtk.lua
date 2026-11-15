---@module "eggfriedrice.extra.gtk"
---@license MIT

local M = {}

---The roles a bar or tab strip takes from the palette. The file exposes
---the whole palette as named colors and lists these as suggested uses.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "bar_background", "bg" },
		{ "bar_foreground", "fg" },
		{ "bar_border", "fg_gutter" },
		{ "muted", "comment" },
		{ "active", "yellow" },
		{ "active_text", require("eggfriedrice.extra.palette").on_accent },
		{ "urgent", "red" },
		{ "success", "green" },
		{ "info", "blue" },
		{ "tab_background", "bg_dark" },
		{ "tab_selected", "bg_light" },
		{ "tab_indicator", "yellow" },
	}
end

---@param c table
---@return string
function M.generate(c)
	-- `@define-color` works in GTK3 (waybar) and GTK4 (ghostty's
	-- gtk-custom-css) alike; stylesheets `@import` this file and then
	-- use `@yellow` or `alpha(@bg, 0.7)`.
	local extra = require("eggfriedrice.extra")
	local lines = {
		"/*",
		" * eggfriedrice for " .. extra.extras.gtk.label,
		" * generated from lua/eggfriedrice/colors.lua by `make extras`; do not edit by hand",
		" * install: " .. extra.extras.gtk.install,
		" */",
		"",
	}
	for _, color in ipairs(extra.colors(c)) do
		lines[#lines + 1] = ("@define-color %s %s;"):format(color[1], color[2])
	end
	lines[#lines + 1] = ""
	lines[#lines + 1] = "/* suggested roles */"
	for _, e in ipairs(M.roles(c)) do
		lines[#lines + 1] = ("/* %s: @%s */"):format(e[1], e[2])
	end
	lines[#lines + 1] = ""
	return table.concat(lines, "\n")
end

---Block-comment header of a typography file, which renders from
---typography.lua rather than the palette.
---@param name string extra name
---@return string[]
local function typography_header(name)
	local extra = require("eggfriedrice.extra").extras[name]
	return {
		"/*",
		" * eggfriedrice for " .. extra.label,
		" * generated from lua/eggfriedrice/typography.lua by `make extras`; do not edit by hand",
		" * install: " .. extra.install,
		" */",
		"",
	}
end

---The size scale as a one-line comment, for files that can only carry
---one size as a value.
---@param t eggfriedrice.Typography
---@return string
local function scale(t)
	local parts = {}
	for _, size in ipairs(require("eggfriedrice.typography").sizes) do
		parts[#parts + 1] = ("%s %dpt"):format(size, t.size[size])
	end
	return table.concat(parts, ", ")
end

---The ui font on every widget, at the ui weight and the default size, with
---the icon font behind it for nerd glyphs. GTK3 CSS has no variables, so
---this is a plain rule for a stylesheet that styles a whole app of its own
---(waybar); GTK apps in general take the ui font from GTK's font-name
---setting instead, which a `*` rule at user priority would override even
---where an app sets a monospace font.
---@param c table
---@return string
function M.generate_font(c)
	local _ = c
	local t = require("eggfriedrice.typography").get()
	local lines = typography_header("gtk-font")
	vim.list_extend(lines, {
		("/* scale: %s; weights: ui %d, emphasis %d */"):format(scale(t), t.weight.ui, t.weight.emphasis),
		"* {",
		('  font-family: "%s", "%s";'):format(t.font.ui, t.font.icon),
		("  font-weight: %d;"):format(t.weight.ui),
		("  font-size: %dpt;"):format(t.size.sm),
		"}",
		"",
	})
	return table.concat(lines, "\n")
end

---Every token as a CSS custom property on :root, for GTK 4.16 and newer
---(ghostty's gtk-custom-css): `font-family: var(--font-ui)`. GTK3 rejects
---the :root selector, so GTK3 stylesheets use font.css instead.
---@param c table
---@return string
function M.generate_typography(c)
	local _ = c
	local typography = require("eggfriedrice.typography")
	local t = typography.get()
	local lines = typography_header("gtk-typography")
	lines[#lines + 1] = ":root {"
	for _, font in ipairs(typography.fonts) do
		lines[#lines + 1] = ('  --font-%s: "%s";'):format(font, t.font[font])
	end
	for _, weight in ipairs({ "ui", "emphasis" }) do
		lines[#lines + 1] = ("  --font-weight-%s: %d;"):format(weight, t.weight[weight])
	end
	for _, size in ipairs(typography.sizes) do
		lines[#lines + 1] = ("  --font-size-%s: %dpt;"):format(size, t.size[size])
	end
	lines[#lines + 1] = "}"
	lines[#lines + 1] = ""
	return table.concat(lines, "\n")
end

return M
