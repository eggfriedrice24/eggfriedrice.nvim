---@module "eggfriedrice.extra.fsh"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- Keys and sections mirror fast-syntax-highlighting's themes/default.ini.
	-- Brackets stay muted like editor punctuation instead of rainbowed.
	return require("eggfriedrice.extra").header("fsh")
		.. util.template(
			[[
[base]
default          = ${fg}
unknown-token    = ${red},bold,underline
commandseparator = ${blue}
redirection      = ${blue}
here-string-tri  = ${blue}
here-string-text = ${green}
here-string-var  = ${red}
exec-descriptor  = ${blue}
comment          = ${comment}
correct-subtle   = ${green}
incorrect-subtle = ${red}
subtle-separator = ${comment}
subtle-bg        = bg:${bg_light}
secondary        = free
recursive-base   = none

[command-point]
reserved-word     = ${purple}
subcommand        = ${yellow}
alias             = ${yellow}
suffix-alias      = ${yellow}
global-alias      = ${yellow}
builtin           = ${yellow}
function          = ${yellow}
command           = ${yellow}
precommand        = ${yellow}
hashed-command    = ${yellow}
single-sq-bracket = ${blue}
double-sq-bracket = ${blue}
double-paren      = ${blue}

[paths]
path          = ${fg},underline
pathseparator =
path-to-dir   = ${fg},underline
globbing      = ${blue}
globbing-ext  = ${blue}

[brackets]
paired-bracket  = bg:${selection}
bracket-level-1 = ${fg_dark}
bracket-level-2 = ${fg_dark}
bracket-level-3 = ${fg_dark}

[arguments]
single-hyphen-option   = ${cyan}
double-hyphen-option   = ${cyan}
back-quoted-argument   = ${cyan}
single-quoted-argument = ${green}
double-quoted-argument = ${green}
dollar-quoted-argument = ${green}
optarg-string          = ${green}
optarg-number          = ${yellow}

[in-string]
back-dollar-quoted-argument           = ${cyan}
back-or-dollar-double-quoted-argument = ${red}

[other]
variable             = ${red}
assign               = ${red}
assign-array-bracket = ${fg_dark}
history-expansion    = ${purple}

[math]
mathvar = ${red}
mathnum = ${yellow}
matherr = ${red},bold

[for-loop]
forvar  = ${red}
fornum  = ${yellow}
foroper = ${blue}
forsep  = ${fg_dark}

[case]
case-input       = ${green}
case-parentheses = ${fg_dark}
case-condition   = ${cyan}
]],
			c
		)
end

return M
