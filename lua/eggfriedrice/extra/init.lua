---@module "eggfriedrice.extra"
---@author eggfriedrice24
---@license MIT

-- Generates the files under extras/ from the palette, so every app that
-- wears the theme reads the same hexes as Neovim. Run `make extras` (or
-- `nvim -l scripts/extras.lua`) after changing colors.lua; CI fails when
-- the committed output drifts from the palette.

local M = {}

---@class eggfriedrice.Extra
---@field label string human-readable app name
---@field ext string output extension without the dot, "" for none
---@field comment string comment prefix for the generated header, "" to skip
---@field install string one-line install hint

---Registered extras, keyed by their directory name under extras/.
---@type table<string, eggfriedrice.Extra>
M.extras = {
	ghostty = {
		label = "Ghostty",
		ext = "",
		comment = "#",
		install = "copy to ~/.config/ghostty/themes/eggfriedrice and set `theme = eggfriedrice`",
	},
	fzf = {
		label = "fzf",
		ext = "sh",
		comment = "#",
		install = "source from your shell rc",
	},
	zsh = {
		label = "zsh (zsh-syntax-highlighting, zsh-autosuggestions)",
		ext = "zsh",
		comment = "#",
		install = "source from .zshrc",
	},
	fsh = {
		label = "fast-syntax-highlighting",
		ext = "ini",
		comment = ";",
		install = "copy to ~/.config/fsh/eggfriedrice.ini and run `fast-theme XDG:eggfriedrice`",
	},
	starship = {
		label = "Starship",
		ext = "toml",
		comment = "#",
		install = "paste into starship.toml and reference the names in `style`",
	},
	tmux = {
		label = "tmux (>= 3.3)",
		ext = "tmux",
		comment = "#",
		install = "`source-file` it from tmux.conf",
	},
	lazygit = {
		label = "lazygit",
		ext = "yml",
		comment = "#",
		install = 'export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,/path/to/eggfriedrice.yml"',
	},
	bat = {
		label = "bat and Sublime Text",
		ext = "tmTheme",
		comment = "",
		install = "copy to ~/.config/bat/themes/, run `bat cache --build`, set BAT_THEME=eggfriedrice",
	},
	palette = {
		label = "palette JSON",
		ext = "json",
		comment = "",
		install = "",
	},
	hyprland = {
		label = "Hyprland and hyprlock",
		ext = "conf",
		comment = "#",
		install = "`source = /path/to/eggfriedrice.conf` in hyprland.conf or hyprlock.conf, then use $yellow or rgba($yellowAlphaee)",
	},
	lua = {
		label = "Lua",
		ext = "lua",
		comment = "--",
		install = 'put it on your Lua path and `require("eggfriedrice")` (Hyprland\'s Lua config, wezterm, ...)',
	},
	gtk = {
		label = "GTK CSS (waybar, ghostty gtk-custom-css)",
		ext = "css",
		comment = "",
		install = '`@import url("/path/to/eggfriedrice.css");` at the top of your stylesheet, then use @yellow or alpha(@bg, 0.7)',
	},
	rofi = {
		label = "rofi",
		ext = "rasi",
		comment = "//",
		install = '`@import "/path/to/eggfriedrice.rasi"` in your rasi theme, then use @yellow',
	},
	dunst = {
		label = "dunst",
		ext = "conf",
		comment = "#",
		install = "copy or symlink into ~/.config/dunst/dunstrc.d/",
	},
	btop = {
		label = "btop",
		ext = "theme",
		comment = "#",
		install = 'copy or symlink into ~/.config/btop/themes/ and set color_theme = "eggfriedrice"',
	},
	eza = {
		label = "eza",
		ext = "yml",
		comment = "#",
		install = "copy or symlink to ~/.config/eza/theme.yml",
	},
	opencode = {
		label = "opencode",
		ext = "json",
		comment = "",
		install = 'copy or symlink into ~/.config/opencode/themes/, then set theme.name to "eggfriedrice" in cli.json (opencode 2) or "theme" in tui.json (opencode 1)',
	},
}

---Every palette color as an ordered flat list, for variables-style extras
---(hyprland, lua, gtk, rofi) that expose the whole palette by name.
---@param c table
---@return { [1]: string, [2]: string }[] name, hex
function M.colors(c)
	local names = {
		"bg_dark",
		"bg",
		"bg_light",
		"selection",
		"fg_gutter",
		"fg_gutter_ui",
		"border",
		"fg",
		"fg_dark",
		"fg_bright",
		"comment",
		"yellow",
		"orange",
		"green",
		"cyan",
		"blue",
		"purple",
		"red",
		"red_bright",
		"green_bright",
		"yellow_bright",
		"blue_bright",
		"purple_bright",
		"cyan_bright",
		"search",
		"search_selected",
		"scope",
	}
	local out = {}
	for _, n in ipairs(names) do
		out[#out + 1] = { n, c[n] }
	end
	for _, n in ipairs({ "add", "change", "delete", "text" }) do
		out[#out + 1] = { "diff_" .. n, c.diff[n] }
	end
	return out
end

---Header lines for a generated file, or "" for formats without comments.
---@param name string
---@return string
function M.header(name)
	local extra = M.extras[name]
	if extra.comment == "" then
		return ""
	end
	local p = extra.comment .. " "
	return table.concat({
		p .. "eggfriedrice for " .. extra.label,
		p .. "generated from lua/eggfriedrice/colors.lua by `make extras`; do not edit by hand",
		p .. "install: " .. extra.install,
		"",
		"",
	}, "\n")
end

---Output path of an extra, relative to the repository root.
---@param name string
---@return string
function M.path(name)
	local extra = M.extras[name]
	return "extras/" .. name .. "/eggfriedrice" .. (extra.ext ~= "" and "." .. extra.ext or "")
end

---Render every extra into `<root>/extras/`.
---@param root string repository root
---@return string[] written paths, relative to root
function M.generate(root)
	local c = require("eggfriedrice.colors").get()
	local names = vim.tbl_keys(M.extras)
	table.sort(names)

	local written = {}
	for _, name in ipairs(names) do
		local rel = M.path(name)
		vim.fn.mkdir(root .. "/extras/" .. name, "p")
		local content = require("eggfriedrice.extra." .. name).generate(c)
		local f = assert(io.open(root .. "/" .. rel, "w"))
		f:write(content)
		f:close()
		written[#written + 1] = rel
	end
	return written
end

return M
