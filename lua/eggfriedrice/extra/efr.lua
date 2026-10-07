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

---efr's render roles, each from a semantic token: prose on the text
---tokens, yolk for the accent and headings, teal for inline code and
---hunk headers, and the state tokens for results and diff lines.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "text", token("text_primary") },
		{ "muted", token("text_muted") },
		{ "accent", token("accent_primary") },
		{ "heading", token("accent_primary") },
		{ "link", token("link") },
		{ "code", token("accent_ui") },
		{ "success", token("state_success") },
		{ "warning", token("state_warning") },
		{ "error", token("state_error") },
		{ "quote", token("text_subtle") },
		{
			"diff",
			{
				{ "add", token("state_success") },
				{ "remove", token("state_error") },
				{ "hunk", token("accent_ui") },
			},
		},
	}
end

---TOML key for a role: bare when it is a plain word, quoted when it
---contains a dot, so "diff.add" stays one key and not a nested table.
---@param name string
---@return string
local function key(name)
	if name:find("^[%w_-]+$") then
		return name
	end
	return ('"%s"'):format(name)
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local lines = {}
	for _, e in ipairs(M.roles(c)) do
		if extra.is_entries(e[2]) then
			for _, sub in ipairs(e[2]) do
				lines[#lines + 1] = ('%s = "%s"'):format(key(e[1] .. "." .. sub[1]), extra.hex(c, sub[2]))
			end
		else
			lines[#lines + 1] = ('%s = "%s"'):format(key(e[1]), extra.hex(c, e[2]))
		end
	end
	return extra.header("efr")
		.. "# Code and diffs use the bat theme of this repository. A relative path does not\n"
		.. "# work in a copied file, so set code_theme to the absolute path of\n"
		.. "# extras/bat/eggfriedrice.tmTheme:\n"
		.. '# code_theme = "/path/to/eggfriedrice.nvim/extras/bat/eggfriedrice.tmTheme"\n'
		.. "\n"
		.. "[colors]\n"
		.. table.concat(lines, "\n")
		.. "\n"
end

return M
