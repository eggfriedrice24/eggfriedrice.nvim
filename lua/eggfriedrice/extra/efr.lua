---@module "eggfriedrice.extra.efr"
---@license MIT

local M = {}

---Palette key behind a semantic token of the design system.
---@param name string
---@return string
local function token(name)
	for _, e in ipairs(require("eggfriedrice.extra.palette").semantic) do
		if e[1] == name then
			return e[2]
		end
	end
	error("unknown semantic token " .. name)
end

---efr's render roles, as the terminal design of efr maps them (its Legend
---board): muted rows and marks in text_subtle, quotes in text_muted, the
---accent in the primary yolk, red headings (as on the phone), inline code
---in the string green, diffs in the git colours with their tints as row
---backgrounds, and code blocks on surface_2. A background role has a key
---of its own (code_bg, diff.add_bg), because TOML cannot hold code.bg next
---to code.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "text", token("text_primary") },
		{ "muted", token("text_subtle") },
		{ "accent", token("accent_primary") },
		{ "heading", "red" },
		{ "link", token("link") },
		{ "code", token("code_string") },
		{ "success", token("state_success") },
		{ "warning", token("state_warning") },
		{ "error", token("state_error") },
		{ "quote", token("text_muted") },
		{ "code_bg", token("surface_2") },
		{
			"diff",
			{
				{ "add", token("git_add") },
				{ "remove", token("git_delete") },
				{ "hunk", token("accent_ui") },
				{ "add_bg", token("diff_add_bg") },
				{ "remove_bg", token("diff_delete_bg") },
			},
		},
	}
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local lines = {}
	for _, e in ipairs(M.roles(c)) do
		if extra.is_entries(e[2]) then
			for _, sub in ipairs(e[2]) do
				-- A bare dotted key, such as diff.add, is the key add of the table diff, as
				-- efr reads it; a quoted "diff.add" would be one unknown key.
				lines[#lines + 1] = ('%s.%s = "%s"'):format(e[1], sub[1], extra.hex(c, sub[2]))
			end
		else
			lines[#lines + 1] = ('%s = "%s"'):format(e[1], extra.hex(c, e[2]))
		end
	end
	return extra.header("efr")
		.. "# Code and diffs use the bat themes of this repository: code_theme in truecolor,\n"
		.. "# code_theme_ansi (the 16 colours of the terminal) in 16 colours. efr reads a\n"
		.. "# relative path from the directory of this file; in a copy, use absolute paths.\n"
		.. 'code_theme = "../bat/eggfriedrice.tmTheme"\n'
		.. 'code_theme_ansi = "../bat/eggfriedrice-ansi.tmTheme"\n'
		.. "\n"
		.. "[colors]\n"
		.. table.concat(lines, "\n")
		.. "\n"
end

return M
