---@module "eggfriedrice.treesitter"
---@author eggfriedrice24
---@license MIT

local M = {}

---Treesitter captures. Role map (One Dark Pro's roles on our palette,
---with yellow, the signature, taking their yellow, blue and orange):
---red = identifiers: variables, parameters, fields and properties on
---both declaration and access, object keys, tags, headings;
---purple = keywords, decorators, attributes, interpolation braces;
---yellow = functions, methods, macros, types, classes, constructors,
---namespaces, this/self, builtins, and literal values: numbers,
---booleans, constants, HTML/JSX attributes, bold markup;
---blue = operators; cyan = escapes, enum members, special strings;
---green = strings; fg_dark = punctuation.
---Orange is dormant and must not be referenced here.
---@param c table
---@param config eggfriedrice.Config
---@return table<string, vim.api.keyset.highlight>
function M.get(c, config)
	return {
		-- Identifiers (One Dark Pro paints every plain identifier red)
		["@variable"] = { fg = c.red },
		["@variable.builtin"] = { fg = c.yellow }, -- this, self, super, console
		["@variable.parameter"] = { fg = c.red },
		["@variable.parameter.builtin"] = { fg = c.red },
		["@variable.member"] = { fg = c.red }, -- field access and declarations
		["@property"] = { fg = c.red }, -- object keys, struct fields, yaml/json/toml keys

		-- Constants (Go const, Rust const, PY_UPPER, None, nil, iota)
		["@constant"] = { fg = c.yellow },
		["@constant.builtin"] = { fg = c.yellow },
		["@constant.macro"] = { fg = c.yellow },

		-- Modules (Go packages, Python modules, Lua string/table)
		["@module"] = { fg = c.yellow },
		["@module.builtin"] = { fg = c.yellow },

		-- Labels (goto labels, loop labels, yaml anchors)
		["@label"] = { fg = c.red },

		-- Strings
		["@string"] = { fg = c.green },
		["@string.documentation"] = { fg = c.green },
		["@string.regexp"] = { fg = c.red },
		["@string.escape"] = { fg = c.cyan },
		["@string.special"] = { fg = c.cyan },
		["@string.special.symbol"] = { fg = c.red },
		["@string.special.url"] = { fg = c.cyan, underline = true },

		-- Characters
		["@character"] = { fg = c.green },
		["@character.special"] = { fg = c.purple }, -- wildcards, `_` placeholders

		-- Numbers & Booleans
		["@number"] = { fg = c.yellow },
		["@number.float"] = { fg = c.yellow },
		["@boolean"] = { fg = c.yellow },

		-- Types (structs, traits, interfaces, classes, generics)
		["@type"] = { fg = c.yellow },
		["@type.builtin"] = { fg = c.yellow },
		["@type.definition"] = { fg = c.yellow },

		-- Attributes (Python/TS decorators, Rust #[derive] and lifetimes, Java @Override)
		["@attribute"] = { fg = c.purple },
		["@attribute.builtin"] = { fg = c.purple },

		-- Functions
		["@function"] = { fg = c.yellow },
		["@function.builtin"] = { fg = c.yellow }, -- print, len, require, pairs
		["@function.call"] = { fg = c.yellow },
		["@function.macro"] = { fg = c.yellow }, -- println!, vec!
		["@function.method"] = { fg = c.yellow },
		["@function.method.call"] = { fg = c.yellow },

		-- Constructors (new Foo, Rust variants, Python classes)
		["@constructor"] = { fg = c.yellow },

		-- Operators: blue, where One Dark Pro uses cyan
		["@operator"] = { fg = c.blue },

		-- Keywords: all purple. Explicit subcaptures so runtime default
		-- links (e.g. @keyword.operator -> Operator) cannot pull them
		-- toward other roles.
		["@keyword"] = { fg = c.purple },
		["@keyword.coroutine"] = { fg = c.purple },
		["@keyword.function"] = { fg = c.purple },
		["@keyword.operator"] = { fg = c.purple }, -- and, or, not, in, new, instanceof
		["@keyword.import"] = { fg = c.purple },
		["@keyword.export"] = { fg = c.purple },
		["@keyword.type"] = { fg = c.purple },
		["@keyword.modifier"] = { fg = c.purple }, -- pub, mut, public, static, async
		["@keyword.repeat"] = { fg = c.purple },
		["@keyword.return"] = { fg = c.purple },
		["@keyword.debug"] = { fg = c.purple },
		["@keyword.exception"] = { fg = c.purple },
		["@keyword.conditional"] = { fg = c.purple },
		["@keyword.conditional.ternary"] = { fg = c.purple },
		["@keyword.directive"] = { fg = c.purple },
		["@keyword.directive.define"] = { fg = c.purple },

		-- Punctuation: muted, except special (template ${}, f-string {},
		-- shell $var, Rust #[attr]) which reads as an embedding marker.
		["@punctuation.delimiter"] = { fg = c.fg_dark },
		["@punctuation.bracket"] = { fg = c.fg_dark },
		["@punctuation.special"] = { fg = c.purple },

		-- Comments
		["@comment"] = { fg = c.comment, italic = config.italic_comments },
		["@comment.documentation"] = { fg = c.comment, italic = config.italic_comments },
		["@comment.error"] = { fg = c.error },
		["@comment.warning"] = { fg = c.warning },
		["@comment.todo"] = { fg = c.bg, bg = c.yellow, bold = true },
		["@comment.note"] = { fg = c.bg, bg = c.info },

		-- Markup (headings red, bold yellow, italic purple, list markers red)
		["@markup.strong"] = { fg = c.yellow, bold = true },
		["@markup.italic"] = { fg = c.purple, italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },
		["@markup.heading"] = { fg = c.red, bold = true },
		["@markup.heading.1"] = { fg = c.red, bold = true },
		["@markup.heading.2"] = { fg = c.red, bold = true },
		["@markup.heading.3"] = { fg = c.red, bold = true },
		["@markup.heading.4"] = { fg = c.red, bold = true },
		["@markup.heading.5"] = { fg = c.red, bold = true },
		["@markup.heading.6"] = { fg = c.red, bold = true },
		["@markup.quote"] = { fg = c.comment, italic = true },
		["@markup.math"] = { fg = c.cyan },
		["@markup.link"] = { fg = c.cyan },
		["@markup.link.label"] = { fg = c.cyan },
		["@markup.link.url"] = { fg = c.purple, underline = true },
		["@markup.raw"] = { fg = c.green },
		["@markup.raw.block"] = { fg = c.green },
		["@markup.list"] = { fg = c.red },
		["@markup.list.checked"] = { fg = c.green },
		["@markup.list.unchecked"] = { fg = c.fg_dark },

		-- Diff
		["@diff.plus"] = { fg = c.git_add },
		["@diff.minus"] = { fg = c.git_delete },
		["@diff.delta"] = { fg = c.git_change },

		-- Tags (HTML, JSX/TSX): names red, attributes yellow
		["@tag"] = { fg = c.red },
		["@tag.builtin"] = { fg = c.red },
		["@tag.attribute"] = { fg = c.yellow },
		["@tag.delimiter"] = { fg = c.fg_dark },

		-- CSS/SCSS, following One Dark Pro: property names are plain
		-- text, class and id selectors share the attribute color, pseudo
		-- classes/elements are cyan. Tag selectors stay
		-- red via @tag and custom properties red via @variable.
		["@property.css"] = { fg = c.fg },
		["@property.scss"] = { fg = c.fg },
		["@type.css"] = { fg = c.yellow },
		["@type.scss"] = { fg = c.yellow },
		["@constant.css"] = { fg = c.yellow },
		["@constant.scss"] = { fg = c.yellow },
		["@attribute.css"] = { fg = c.cyan },
		["@attribute.scss"] = { fg = c.cyan },
	}
end

return M
