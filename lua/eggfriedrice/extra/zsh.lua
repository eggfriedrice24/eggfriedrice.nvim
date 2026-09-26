---@module "eggfriedrice.extra.zsh"
---@license MIT

local M = {}

M.app = "zsh_syntax"

---Same roles as the editor: commands are functions (yellow), quoted
---words are strings (green), $vars are variables (red), redirections
---and separators are operators (blue), options are cyan like escapes.
---Names are zsh-syntax-highlighting's own. zsh 5.9 knows bold, standout
---and underline only, so nothing here is italic.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "autosuggestion", { fg = "comment" } },
		{ "default", { fg = "fg" } },
		{ "arg0", { fg = "fg" } },
		{ "unknown-token", { fg = "red", bold = true, underline = true } },
		{ "reserved-word", { fg = "purple" } },
		{ "history-expansion", { fg = "purple" } },
		{ "" },
		{ "command", { fg = "yellow" } },
		{ "builtin", { fg = "yellow" } },
		{ "function", { fg = "yellow" } },
		{ "alias", { fg = "yellow" } },
		{ "suffix-alias", { fg = "yellow" } },
		{ "global-alias", { fg = "yellow" } },
		{ "precommand", { fg = "yellow" } },
		{ "hashed-command", { fg = "yellow" } },
		{ "" },
		{ "path", { fg = "fg", underline = true } },
		{ "path_prefix", { fg = "fg", underline = true } },
		{ "autodirectory", { fg = "fg", underline = true } },
		{ "globbing", { fg = "blue" } },
		{ "" },
		{ "single-hyphen-option", { fg = "cyan" } },
		{ "double-hyphen-option", { fg = "cyan" } },
		{ "" },
		{ "single-quoted-argument", { fg = "green" } },
		{ "double-quoted-argument", { fg = "green" } },
		{ "dollar-quoted-argument", { fg = "green" } },
		{ "rc-quote", { fg = "green" } },
		{ "dollar-double-quoted-argument", { fg = "red" } },
		{ "back-double-quoted-argument", { fg = "cyan" } },
		{ "back-dollar-quoted-argument", { fg = "cyan" } },
		{ "back-quoted-argument", { fg = "cyan" } },
		{ "back-quoted-argument-delimiter", { fg = "cyan" } },
		{ "command-substitution", { fg = "cyan" } },
		{ "command-substitution-delimiter", { fg = "cyan" } },
		{ "process-substitution", { fg = "cyan" } },
		{ "process-substitution-delimiter", { fg = "cyan" } },
		{ "" },
		{ "assign", { fg = "red" } },
		{ "redirection", { fg = "blue" } },
		{ "commandseparator", { fg = "blue" } },
		{ "named-fd", { fg = "blue" } },
		{ "numeric-fd", { fg = "blue" } },
		{ "comment", { fg = "comment" } },
	}
end

---zsh style spec: fg=#hex plus attribute flags.
---@param c table
---@param style table
---@return string
local function spec(c, style)
	local extra = require("eggfriedrice.extra")
	local parts = { "fg=" .. extra.hex(c, style.fg) }
	for _, flag in ipairs({ "bold", "underline" }) do
		if style[flag] then
			parts[#parts + 1] = flag
		end
	end
	return table.concat(parts, ",")
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local roles = M.roles(c)
	local lines = {
		"# zsh-autosuggestions: ghost text in the comment color",
		('ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="%s"'):format(spec(c, extra.role(roles, "autosuggestion"))),
		"",
		"# zsh-syntax-highlighting: the `main` highlighter styles",
		"typeset -gA ZSH_HIGHLIGHT_STYLES",
	}
	for _, e in ipairs(roles) do
		if e[1] == "" then
			lines[#lines + 1] = ""
		elseif e[1] ~= "autosuggestion" then
			lines[#lines + 1] = ('ZSH_HIGHLIGHT_STYLES[%s]="%s"'):format(e[1], spec(c, e[2]))
		end
	end
	lines[#lines + 1] = ""
	return extra.header("zsh") .. table.concat(lines, "\n")
end

return M
