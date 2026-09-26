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
}

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
