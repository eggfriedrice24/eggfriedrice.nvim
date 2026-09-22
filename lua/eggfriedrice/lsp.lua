---@module "eggfriedrice.lsp"
---@author eggfriedrice24
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---Diagnostics and LSP semantic tokens. Semantic tokens override
---treesitter (rust-analyzer, gopls, jdtls, ts_ls, lua_ls and
---basedpyright all send them), so they must follow the same role map.
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
		LspSignatureActiveParameter = { fg = c.yellow, bold = true },
		LspCodeLens = { fg = c.comment },
		LspCodeLensSeparator = { fg = c.fg_gutter },
		LspInlayHint = { fg = c.comment, bg = c.bg_light },
		LspInfoBorder = { fg = c.border },

		-- Semantic tokens: types and builtins (yellow)
		["@lsp.type.class"] = { fg = c.yellow },
		["@lsp.type.interface"] = { fg = c.yellow },
		["@lsp.type.struct"] = { fg = c.yellow },
		["@lsp.type.enum"] = { fg = c.yellow },
		["@lsp.type.union"] = { fg = c.yellow }, -- rust-analyzer
		["@lsp.type.type"] = { fg = c.yellow },
		["@lsp.type.typeAlias"] = { fg = c.yellow },
		["@lsp.type.typeParameter"] = { fg = c.yellow },
		["@lsp.type.builtinType"] = { fg = c.yellow }, -- rust-analyzer: i32, str
		["@lsp.type.record"] = { fg = c.yellow }, -- jdtls
		["@lsp.type.namespace"] = { fg = c.yellow }, -- Go packages, Python modules
		["@lsp.type.toolModule"] = { fg = c.yellow }, -- rust-analyzer: #[rustfmt::skip]
		["@lsp.type.selfKeyword"] = { fg = c.yellow }, -- rust-analyzer: self
		["@lsp.type.selfTypeKeyword"] = { fg = c.yellow }, -- rust-analyzer: Self
		["@lsp.type.selfParameter"] = { fg = c.yellow }, -- basedpyright: self
		["@lsp.type.clsParameter"] = { fg = c.yellow }, -- basedpyright: cls
		["@lsp.type.enumMember"] = { fg = c.cyan },
		["@lsp.type.escapeSequence"] = { fg = c.cyan }, -- rust-analyzer
		["@lsp.typemod.function.defaultLibrary"] = { fg = c.yellow }, -- len, append, require
		["@lsp.typemod.method.defaultLibrary"] = { fg = c.yellow },

		-- Semantic tokens: callables (yellow)
		["@lsp.type.function"] = { fg = c.yellow },
		["@lsp.type.method"] = { fg = c.yellow },
		["@lsp.type.member"] = { fg = c.yellow }, -- ts_ls: methods and function-valued keys
		["@lsp.type.macro"] = { fg = c.yellow }, -- rust-analyzer: println!
		["@lsp.type.procMacro"] = { fg = c.yellow },
		["@lsp.type.magicFunction"] = { fg = c.yellow }, -- basedpyright: __init__

		-- Semantic tokens: keywords and annotations (purple)
		["@lsp.type.keyword"] = { fg = c.purple },
		["@lsp.type.modifier"] = { fg = c.purple }, -- jdtls: public, static
		["@lsp.type.decorator"] = { fg = c.purple },
		["@lsp.type.annotation"] = { fg = c.purple }, -- jdtls: @Override
		["@lsp.type.lifetime"] = { fg = c.purple }, -- rust-analyzer: 'a
		["@lsp.type.derive"] = { fg = c.purple }, -- rust-analyzer: #[derive(Debug)]
		["@lsp.type.deriveHelper"] = { fg = c.purple },
		["@lsp.type.builtinAttribute"] = { fg = c.purple },
		["@lsp.type.formatSpecifier"] = { fg = c.purple }, -- rust-analyzer: {} in println!

		-- Semantic tokens: identifiers (red) and literals (yellow).
		-- Plain variables are left to treesitter: ts_ls, gopls, lua_ls
		-- and rust-analyzer send SCREAMING_CASE constants as variable
		-- (+readonly) too, which would repaint them red. Treesitter
		-- already paints identifiers red and constants yellow.
		["@lsp.type.variable"] = {},
		["@lsp.type.parameter"] = { fg = c.red },
		["@lsp.type.property"] = { fg = c.red },
		["@lsp.type.label"] = { fg = c.red }, -- rust-analyzer: 'outer
		["@lsp.type.recordComponent"] = { fg = c.red }, -- jdtls
		["@lsp.type.annotationMember"] = { fg = c.red }, -- jdtls
		["@lsp.type.builtinConstant"] = { fg = c.yellow }, -- basedpyright: True, None

		-- Semantic token modifiers. @lsp.mod.readonly italic is
		-- deliberately not set: rust-analyzer marks most bindings
		-- readonly and the buffer turns italic.
		["@lsp.mod.deprecated"] = { strikethrough = true },
	}
end

return M
