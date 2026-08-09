---@module "eggfriedrice.lsp"
---@author eggfriedrice24
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---Diagnostics and LSP semantic tokens. Semantic tokens override
---treesitter (rust-analyzer, gopls, jdtls, pyright all send them),
---so they must follow the same role map.
---@param c table
---@param config eggfriedrice.Config
---@return table<string, vim.api.keyset.highlight>
function M.get(c, config)
	return {
		-- Diagnostics
		DiagnosticError = { fg = c.error },
		DiagnosticWarn = { fg = c.warning },
		DiagnosticInfo = { fg = c.info },
		DiagnosticHint = { fg = c.hint },
		DiagnosticOk = { fg = c.green },
		DiagnosticUnnecessary = { fg = c.comment },
		DiagnosticDeprecated = { strikethrough = true, sp = c.fg_dark },
		-- DiagnosticSign* and DiagnosticFloating* default-link to the
		-- groups above, so they are not repeated here.

		-- Diagnostic virtual text
		DiagnosticVirtualTextError = { fg = c.error, bg = util.blend(c.error, c.bg, 0.12) },
		DiagnosticVirtualTextWarn = { fg = c.warning, bg = util.blend(c.warning, c.bg, 0.12) },
		DiagnosticVirtualTextInfo = { fg = c.info, bg = util.blend(c.info, c.bg, 0.12) },
		DiagnosticVirtualTextHint = { fg = c.hint, bg = util.blend(c.hint, c.bg, 0.12) },
		DiagnosticVirtualTextOk = { fg = c.green, bg = util.blend(c.green, c.bg, 0.12) },

		-- Diagnostic underlines
		DiagnosticUnderlineError = { undercurl = true, sp = c.error },
		DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning },
		DiagnosticUnderlineInfo = { undercurl = true, sp = c.info },
		DiagnosticUnderlineHint = { undercurl = true, sp = c.hint },
		DiagnosticUnderlineOk = { undercurl = true, sp = c.green },

		-- LSP references
		LspReferenceText = { bg = c.selection },
		LspReferenceRead = { bg = c.selection },
		LspReferenceWrite = { bg = c.selection },
		LspReferenceTarget = { bg = c.selection },

		-- LSP UI
		LspSignatureActiveParameter = { fg = c.orange, bold = true },
		LspCodeLens = { fg = c.comment },
		LspCodeLensSeparator = { fg = c.fg_gutter },
		LspInlayHint = { fg = c.comment, bg = c.bg_light },
		LspInfoBorder = { fg = c.border },

		-- Semantic tokens: types
		["@lsp.type.class"] = { fg = c.cyan },
		["@lsp.type.interface"] = { fg = c.cyan },
		["@lsp.type.struct"] = { fg = c.cyan },
		["@lsp.type.enum"] = { fg = c.cyan },
		["@lsp.type.type"] = { fg = c.cyan },
		["@lsp.type.typeAlias"] = { fg = c.cyan },
		["@lsp.type.typeParameter"] = { fg = c.cyan },
		["@lsp.type.builtinType"] = { fg = c.cyan }, -- rust-analyzer: i32, str

		-- Semantic tokens: callables and annotations
		["@lsp.type.function"] = { fg = c.orange },
		["@lsp.type.method"] = { fg = c.orange },
		["@lsp.type.macro"] = { fg = c.orange }, -- rust-analyzer: println!
		["@lsp.type.decorator"] = { fg = c.purple },

		-- Semantic tokens: values and identifiers
		["@lsp.type.enumMember"] = { fg = c.rose },
		["@lsp.type.lifetime"] = { fg = c.rose }, -- rust-analyzer
		["@lsp.type.selfKeyword"] = { fg = c.yellow }, -- rust-analyzer
		["@lsp.type.namespace"] = { fg = c.fg },
		["@lsp.type.parameter"] = { fg = c.fg },
		["@lsp.type.property"] = { fg = c.blue },
		["@lsp.type.variable"] = { fg = c.fg },

		-- Semantic token modifiers. @lsp.mod.readonly italic is
		-- deliberately not set: rust-analyzer marks most bindings
		-- readonly and the buffer turns italic.
		["@lsp.mod.deprecated"] = { strikethrough = true },
	}
end

return M
