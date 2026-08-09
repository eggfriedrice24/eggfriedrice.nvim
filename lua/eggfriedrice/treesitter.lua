---@module "eggfriedrice.treesitter"
---@author eggfriedrice24
---@license MIT

local M = {}

---Treesitter captures. Role map:
---yellow = keywords, orange = functions, green = strings, cyan = types,
---blue = members/properties, purple = booleans/builtins/decorators,
---rose = numbers/constants/escapes and special punctuation,
---fg_dark = operators and plain punctuation.
---@param c table
---@param config eggfriedrice.Config
---@return table<string, vim.api.keyset.highlight>
function M.get(c, config)
	return {
		-- Identifiers
		["@variable"] = { fg = c.fg },
		["@variable.builtin"] = { fg = c.yellow }, -- self, this, super
		["@variable.parameter"] = { fg = c.fg },
		["@variable.parameter.builtin"] = { fg = c.fg },
		["@variable.member"] = { fg = c.blue },
		["@property"] = { fg = c.blue },

		-- Constants (Go const, Rust const, PY_UPPER, None, nil, iota)
		["@constant"] = { fg = c.rose },
		["@constant.builtin"] = { fg = c.purple },
		["@constant.macro"] = { fg = c.rose },

		-- Modules (Go packages, Python modules, Java packages)
		["@module"] = { fg = c.fg },
		["@module.builtin"] = { fg = c.fg },

		-- Labels (goto labels, Rust lifetimes)
		["@label"] = { fg = c.rose },

		-- Strings
		["@string"] = { fg = c.green },
		["@string.documentation"] = { fg = c.green },
		["@string.regexp"] = { fg = c.orange },
		["@string.escape"] = { fg = c.rose },
		["@string.special"] = { fg = c.rose },
		["@string.special.symbol"] = { fg = c.rose },
		["@string.special.url"] = { fg = c.cyan, underline = true },

		-- Characters
		["@character"] = { fg = c.green },
		["@character.special"] = { fg = c.rose },

		-- Numbers & Booleans
		["@number"] = { fg = c.rose },
		["@number.float"] = { fg = c.rose },
		["@boolean"] = { fg = c.purple },

		-- Types (structs, traits, interfaces, classes, generics)
		["@type"] = { fg = c.cyan },
		["@type.builtin"] = { fg = c.cyan },
		["@type.definition"] = { fg = c.cyan },

		-- Attributes (Python/TS decorators, Rust #[derive], Java @Override)
		["@attribute"] = { fg = c.purple },
		["@attribute.builtin"] = { fg = c.purple },

		-- Functions
		["@function"] = { fg = c.orange },
		["@function.builtin"] = { fg = c.orange },
		["@function.call"] = { fg = c.orange },
		["@function.macro"] = { fg = c.orange }, -- println!, vec!
		["@function.method"] = { fg = c.orange },
		["@function.method.call"] = { fg = c.orange },

		-- Constructors (new Foo, Rust variants, Java/TS classes)
		["@constructor"] = { fg = c.cyan },

		-- Operators (muted so identifiers and literals pop)
		["@operator"] = { fg = c.fg_dark },

		-- Keywords: all yellow, the signature. Explicit subcaptures so
		-- runtime default links (e.g. @keyword.operator -> Operator)
		-- cannot pull them toward other roles.
		["@keyword"] = { fg = c.yellow },
		["@keyword.coroutine"] = { fg = c.yellow },
		["@keyword.function"] = { fg = c.yellow },
		["@keyword.operator"] = { fg = c.yellow }, -- and, or, not, in, new, instanceof
		["@keyword.import"] = { fg = c.yellow },
		["@keyword.export"] = { fg = c.yellow },
		["@keyword.type"] = { fg = c.yellow },
		["@keyword.modifier"] = { fg = c.yellow }, -- pub, mut, public, static, async
		["@keyword.repeat"] = { fg = c.yellow },
		["@keyword.return"] = { fg = c.yellow },
		["@keyword.debug"] = { fg = c.yellow },
		["@keyword.exception"] = { fg = c.yellow },
		["@keyword.conditional"] = { fg = c.yellow },
		["@keyword.conditional.ternary"] = { fg = c.yellow },
		["@keyword.directive"] = { fg = c.yellow },
		["@keyword.directive.define"] = { fg = c.yellow },

		-- Punctuation: muted, except special (template ${}, f-string {})
		["@punctuation.delimiter"] = { fg = c.fg_dark },
		["@punctuation.bracket"] = { fg = c.fg_dark },
		["@punctuation.special"] = { fg = c.rose },

		-- Comments
		["@comment"] = { fg = c.comment, italic = config.italic_comments },
		["@comment.documentation"] = { fg = c.comment, italic = config.italic_comments },
		["@comment.error"] = { fg = c.error },
		["@comment.warning"] = { fg = c.warning },
		["@comment.todo"] = { fg = c.bg, bg = c.orange, bold = true },
		["@comment.note"] = { fg = c.bg, bg = c.info },

		-- Markup
		["@markup.strong"] = { bold = true },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },
		["@markup.heading"] = { fg = c.yellow, bold = true },
		["@markup.heading.1"] = { fg = c.yellow, bold = true },
		["@markup.heading.2"] = { fg = c.orange, bold = true },
		["@markup.heading.3"] = { fg = c.green, bold = true },
		["@markup.heading.4"] = { fg = c.cyan, bold = true },
		["@markup.heading.5"] = { fg = c.rose, bold = true },
		["@markup.heading.6"] = { fg = c.fg_dark, bold = true },
		["@markup.quote"] = { fg = c.fg_dark, italic = true },
		["@markup.math"] = { fg = c.cyan },
		["@markup.link"] = { fg = c.cyan },
		["@markup.link.label"] = { fg = c.cyan },
		["@markup.link.url"] = { fg = c.cyan, underline = true },
		["@markup.raw"] = { fg = c.green },
		["@markup.raw.block"] = { fg = c.green },
		["@markup.list"] = { fg = c.rose },
		["@markup.list.checked"] = { fg = c.green },
		["@markup.list.unchecked"] = { fg = c.fg_dark },

		-- Diff
		["@diff.plus"] = { fg = c.git_add },
		["@diff.minus"] = { fg = c.git_delete },
		["@diff.delta"] = { fg = c.git_change },

		-- Tags (HTML, JSX/TSX)
		["@tag"] = { fg = c.cyan },
		["@tag.builtin"] = { fg = c.cyan },
		["@tag.attribute"] = { fg = c.orange },
		["@tag.delimiter"] = { fg = c.fg_dark },
	}
end

return M
