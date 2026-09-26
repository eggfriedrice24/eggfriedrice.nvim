---@module "eggfriedrice.extra.zsh"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- Same roles as the editor: commands are functions (yellow), quoted
	-- words are strings (green), $vars are variables (red), redirections
	-- and separators are operators (blue), options are cyan like escapes.
	return require("eggfriedrice.extra").header("zsh")
		.. util.template(
			[[
# zsh-autosuggestions: ghost text in the comment color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${comment}"

# zsh-syntax-highlighting: the `main` highlighter styles
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]="fg=${fg}"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=${fg}"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=${red},bold,underline"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=${purple}"
ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=${purple}"

ZSH_HIGHLIGHT_STYLES[command]="fg=${yellow}"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=${yellow}"
ZSH_HIGHLIGHT_STYLES[function]="fg=${yellow}"
ZSH_HIGHLIGHT_STYLES[alias]="fg=${yellow}"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=${yellow}"
ZSH_HIGHLIGHT_STYLES[global-alias]="fg=${yellow}"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=${yellow}"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=${yellow}"

ZSH_HIGHLIGHT_STYLES[path]="fg=${fg},underline"
ZSH_HIGHLIGHT_STYLES[path_prefix]="fg=${fg},underline"
ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=${fg},underline"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=${blue}"

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=${cyan}"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=${cyan}"

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=${green}"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=${green}"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=${green}"
ZSH_HIGHLIGHT_STYLES[rc-quote]="fg=${green}"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=${red}"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=${cyan}"
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=${cyan}"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=${cyan}"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="fg=${cyan}"
ZSH_HIGHLIGHT_STYLES[command-substitution]="fg=${cyan}"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=${cyan}"
ZSH_HIGHLIGHT_STYLES[process-substitution]="fg=${cyan}"
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]="fg=${cyan}"

ZSH_HIGHLIGHT_STYLES[assign]="fg=${red}"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=${blue}"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=${blue}"
ZSH_HIGHLIGHT_STYLES[named-fd]="fg=${blue}"
ZSH_HIGHLIGHT_STYLES[numeric-fd]="fg=${blue}"
ZSH_HIGHLIGHT_STYLES[comment]="fg=${comment}"
]],
			c
		)
end

return M
