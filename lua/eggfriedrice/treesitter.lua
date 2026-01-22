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
	hl("@variable.builtin", { fg = c.yellow })
	hl("@variable.parameter", { fg = c.fg })
	hl("@variable.member", { fg = c.fg_dark })

	-- Constants
	hl("@constant", { fg = c.fg_dark })
	hl("@constant.builtin", { fg = c.cyan })
	hl("@constant.macro", { fg = c.yellow })

	-- Modules
	hl("@module", { fg = c.yellow })
	hl("@module.builtin", { fg = c.yellow })

	-- Strings
	hl("@string", { fg = c.green })
	hl("@string.documentation", { fg = c.cyan })
	hl("@string.regexp", { fg = c.yellow })
	hl("@string.escape", { fg = c.yellow })
	hl("@string.special", { fg = c.yellow })
	hl("@string.special.symbol", { fg = c.yellow })
	hl("@string.special.url", { fg = c.yellow, underline = true })

	-- Characters
	hl("@character", { fg = c.green })
	hl("@character.special", { fg = c.yellow })

	-- Numbers & Booleans
	hl("@number", { fg = c.yellow })
	hl("@number.float", { fg = c.yellow })
	hl("@boolean", { fg = c.yellow })

	-- Types
	hl("@type", { fg = c.yellow })
	hl("@type.builtin", { fg = c.yellow })
	hl("@type.definition", { fg = c.yellow })

	-- Attributes & Properties
	hl("@attribute", { fg = c.orange })
	hl("@attribute.builtin", { fg = c.orange })
	hl("@property", { fg = c.fg })

	-- Functions
	hl("@function", { fg = c.orange })
	hl("@function.builtin", { fg = c.orange })
	hl("@function.call", { fg = c.orange })
	hl("@function.macro", { fg = c.yellow })
	hl("@function.method", { fg = c.orange })
	hl("@function.method.call", { fg = c.orange })

	-- Constructors
	hl("@constructor", { fg = c.rose })

	-- Operators
	hl("@operator", { fg = c.yellow })

	-- Keywords
	hl("@keyword", { fg = c.yellow })
	hl("@keyword.coroutine", { fg = c.yellow })
	hl("@keyword.function", { fg = c.yellow })
	hl("@keyword.operator", { fg = c.yellow })
	hl("@keyword.import", { fg = c.yellow })
	hl("@keyword.export", { fg = c.yellow })
	hl("@keyword.type", { fg = c.yellow })
	hl("@keyword.modifier", { fg = c.yellow })
	hl("@keyword.repeat", { fg = c.cyan })
	hl("@keyword.return", { fg = c.rose })
	hl("@keyword.debug", { fg = c.orange })
	hl("@keyword.exception", { fg = c.rose })
	hl("@keyword.conditional", { fg = c.rose })
	hl("@keyword.conditional.ternary", { fg = c.rose })
	hl("@keyword.directive", { fg = c.yellow })
	hl("@keyword.directive.define", { fg = c.yellow })

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
	hl("@markup.heading", { fg = c.yellow, bold = true })
	hl("@markup.heading.1", { fg = c.yellow, bold = true })
	hl("@markup.heading.2", { fg = c.yellow, bold = true })
	hl("@markup.heading.3", { fg = c.green, bold = true })
	hl("@markup.heading.4", { fg = c.orange, bold = true })
	hl("@markup.heading.5", { fg = c.yellow, bold = true })
	hl("@markup.heading.6", { fg = c.red, bold = true })
	hl("@markup.quote", { fg = c.fg_dark, italic = true })
	hl("@markup.math", { fg = c.yellow })
	hl("@markup.link", { fg = c.yellow })
	hl("@markup.link.label", { fg = c.yellow })
	hl("@markup.link.url", { fg = c.yellow, underline = true })
	hl("@markup.raw", { fg = c.green })
	hl("@markup.raw.block", { fg = c.green })
	hl("@markup.list", { fg = c.yellow })
	hl("@markup.list.checked", { fg = c.green })
	hl("@markup.list.unchecked", { fg = c.fg_gutter })

	-- Diff
	hl("@diff.plus", { fg = c.git_add })
	hl("@diff.minus", { fg = c.git_delete })
	hl("@diff.delta", { fg = c.git_change })

	-- Tags (HTML, JSX)
	hl("@tag", { fg = c.orange })
	hl("@tag.builtin", { fg = c.orange })
	hl("@tag.attribute", { fg = c.yellow })
	hl("@tag.delimiter", { fg = c.rose })
end

return M
