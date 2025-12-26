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
	hl("@variable.builtin", { fg = c.orange })
	hl("@variable.parameter", { fg = c.fg })
	hl("@variable.member", { fg = c.fg })

	-- Constants
	hl("@constant", { fg = c.fg })
	hl("@constant.builtin", { fg = c.orange })
	hl("@constant.macro", { fg = c.orange })

	-- Modules
	hl("@module", { fg = c.orange })
	hl("@module.builtin", { fg = c.orange })

	-- Strings
	hl("@string", { fg = c.green })
	hl("@string.documentation", { fg = c.green })
	hl("@string.regexp", { fg = c.cyan })
	hl("@string.escape", { fg = c.orange })
	hl("@string.special", { fg = c.cyan })
	hl("@string.special.symbol", { fg = c.orange })
	hl("@string.special.url", { fg = c.cyan, underline = true })

	-- Characters
	hl("@character", { fg = c.green })
	hl("@character.special", { fg = c.orange })

	-- Numbers & Booleans
	hl("@number", { fg = c.orange })
	hl("@number.float", { fg = c.orange })
	hl("@boolean", { fg = c.orange })

	-- Types
	hl("@type", { fg = c.cyan })
	hl("@type.builtin", { fg = c.cyan })
	hl("@type.definition", { fg = c.cyan })

	-- Attributes & Properties
	hl("@attribute", { fg = c.yellow })
	hl("@attribute.builtin", { fg = c.yellow })
	hl("@property", { fg = c.fg })

	-- Functions
	hl("@function", { fg = c.yellow })
	hl("@function.builtin", { fg = c.yellow })
	hl("@function.call", { fg = c.yellow })
	hl("@function.macro", { fg = c.cyan })
	hl("@function.method", { fg = c.yellow })
	hl("@function.method.call", { fg = c.yellow })

	-- Constructors
	hl("@constructor", { fg = c.cyan })

	-- Operators
	hl("@operator", { fg = c.cyan })

	-- Keywords
	hl("@keyword", { fg = c.orange })
	hl("@keyword.coroutine", { fg = c.cyan })
	hl("@keyword.function", { fg = c.cyan })
	hl("@keyword.operator", { fg = c.cyan })
	hl("@keyword.import", { fg = c.orange })
	hl("@keyword.export", { fg = c.orange })
	hl("@keyword.type", { fg = c.orange })
	hl("@keyword.modifier", { fg = c.cyan })
	hl("@keyword.repeat", { fg = c.red })
	hl("@keyword.return", { fg = c.rose })
	hl("@keyword.debug", { fg = c.yellow })
	hl("@keyword.exception", { fg = c.rose })
	hl("@keyword.conditional", { fg = c.rose })
	hl("@keyword.conditional.ternary", { fg = c.rose })
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
	hl("@comment.todo", { fg = c.bg, bg = c.yellow, bold = true })
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
	hl("@markup.heading.4", { fg = c.yellow, bold = true })
	hl("@markup.heading.5", { fg = c.orange, bold = true })
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
	hl("@tag", { fg = c.yellow })
	hl("@tag.builtin", { fg = c.yellow })
	hl("@tag.attribute", { fg = c.cyan })
	hl("@tag.delimiter", { fg = c.rose })
end

return M
