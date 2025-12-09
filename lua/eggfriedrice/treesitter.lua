---@module "eggfriedrice.treesitter"
---@author eggfriedrice24
---@license MIT

local M = {}

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

function M.setup(c, config)
	-- Identifiers
	hl("@variable", { fg = c.fg })
	hl("@variable.builtin", { fg = c.magenta })
	hl("@variable.parameter", { fg = c.fg })
	hl("@variable.member", { fg = c.fg })

	-- Constants
	hl("@constant", { fg = c.fg })
	hl("@constant.builtin", { fg = c.magenta })
	hl("@constant.macro", { fg = c.magenta })

	-- Modules
	hl("@module", { fg = c.cyan })
	hl("@module.builtin", { fg = c.cyan })

	-- Strings
	hl("@string", { fg = c.green })
	hl("@string.documentation", { fg = c.green })
	hl("@string.regexp", { fg = c.cyan })
	hl("@string.escape", { fg = c.magenta })
	hl("@string.special", { fg = c.cyan })
	hl("@string.special.symbol", { fg = c.magenta })
	hl("@string.special.url", { fg = c.cyan, underline = true })

	-- Characters
	hl("@character", { fg = c.green })
	hl("@character.special", { fg = c.magenta })

	-- Numbers & Booleans
	hl("@number", { fg = c.magenta })
	hl("@number.float", { fg = c.magenta })
	hl("@boolean", { fg = c.magenta })

	-- Types
	hl("@type", { fg = c.cyan })
	hl("@type.builtin", { fg = c.cyan })
	hl("@type.definition", { fg = c.cyan })

	-- Attributes & Properties
	hl("@attribute", { fg = c.orange })
	hl("@attribute.builtin", { fg = c.orange })
	hl("@property", { fg = c.fg })

	-- Functions
	hl("@function", { fg = c.orange })
	hl("@function.builtin", { fg = c.orange })
	hl("@function.call", { fg = c.orange })
	hl("@function.macro", { fg = c.cyan })
	hl("@function.method", { fg = c.orange })
	hl("@function.method.call", { fg = c.orange })

	-- Constructors
	hl("@constructor", { fg = c.cyan })

	-- Operators
	hl("@operator", { fg = c.cyan })

	-- Keywords
	hl("@keyword", { fg = c.cyan })
	hl("@keyword.coroutine", { fg = c.cyan })
	hl("@keyword.function", { fg = c.cyan })
	hl("@keyword.operator", { fg = c.cyan })
	hl("@keyword.import", { fg = c.orange })
	hl("@keyword.type", { fg = c.cyan })
	hl("@keyword.modifier", { fg = c.cyan })
	hl("@keyword.repeat", { fg = c.red })
	hl("@keyword.return", { fg = c.red })
	hl("@keyword.debug", { fg = c.orange })
	hl("@keyword.exception", { fg = c.red })
	hl("@keyword.conditional", { fg = c.red })
	hl("@keyword.conditional.ternary", { fg = c.red })
	hl("@keyword.directive", { fg = c.cyan })
	hl("@keyword.directive.define", { fg = c.cyan })

	-- Punctuation
	hl("@punctuation.delimiter", { fg = c.rose })
	hl("@punctuation.bracket", { fg = c.rose })
	hl("@punctuation.special", { fg = c.rose })

	-- Comments
	hl("@comment", { fg = c.comment, italic = config.italic_comments })
	hl("@comment.documentation", { fg = c.comment, italic = config.italic_comments })
	hl("@comment.error", { fg = c.error })
	hl("@comment.warning", { fg = c.warning })
	hl("@comment.todo", { fg = c.bg, bg = c.orange, bold = true })
	hl("@comment.note", { fg = c.bg, bg = c.info })

	-- Markup
	hl("@markup.strong", { bold = true })
	hl("@markup.italic", { italic = true })
	hl("@markup.strikethrough", { strikethrough = true })
	hl("@markup.underline", { underline = true })
	hl("@markup.heading", { fg = c.cyan, bold = true })
	hl("@markup.heading.1", { fg = c.cyan, bold = true })
	hl("@markup.heading.2", { fg = c.cyan, bold = true })
	hl("@markup.heading.3", { fg = c.green, bold = true })
	hl("@markup.heading.4", { fg = c.orange, bold = true })
	hl("@markup.heading.5", { fg = c.magenta, bold = true })
	hl("@markup.heading.6", { fg = c.red, bold = true })
	hl("@markup.quote", { fg = c.fg_dark, italic = true })
	hl("@markup.math", { fg = c.cyan })
	hl("@markup.link", { fg = c.cyan })
	hl("@markup.link.label", { fg = c.cyan })
	hl("@markup.link.url", { fg = c.cyan, underline = true })
	hl("@markup.raw", { fg = c.green })
	hl("@markup.raw.block", { fg = c.green })
	hl("@markup.list", { fg = c.cyan })
	hl("@markup.list.checked", { fg = c.green })
	hl("@markup.list.unchecked", { fg = c.fg_gutter })

	-- Diff
	hl("@diff.plus", { fg = c.git_add })
	hl("@diff.minus", { fg = c.git_delete })
	hl("@diff.delta", { fg = c.git_change })

	-- Tags (HTML, JSX)
	hl("@tag", { fg = c.orange })
	hl("@tag.builtin", { fg = c.orange })
	hl("@tag.attribute", { fg = c.cyan })
	hl("@tag.delimiter", { fg = c.rose })
end

return M
