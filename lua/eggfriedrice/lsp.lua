---@module "eggfriedrice.lsp"
---@author eggfriedrice24
---@license MIT

local M = {}

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

function M.setup(c, config)
	-- Diagnostics
	hl("DiagnosticError", { fg = c.error })
	hl("DiagnosticWarn", { fg = c.warning })
	hl("DiagnosticInfo", { fg = c.info })
	hl("DiagnosticHint", { fg = c.hint })
	hl("DiagnosticOk", { fg = c.green })

	-- Diagnostic virtual text
	hl("DiagnosticVirtualTextError", { fg = c.error, bg = "#2d202a" })
	hl("DiagnosticVirtualTextWarn", { fg = c.warning, bg = "#2d2a20" })
	hl("DiagnosticVirtualTextInfo", { fg = c.info, bg = "#202a2d" })
	hl("DiagnosticVirtualTextHint", { fg = c.hint, bg = "#1a2a2a" })
	hl("DiagnosticVirtualTextOk", { fg = c.green, bg = "#1a2a1a" })

	-- Diagnostic underlines
	hl("DiagnosticUnderlineError", { undercurl = true, sp = c.error })
	hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.warning })
	hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.info })
	hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.hint })
	hl("DiagnosticUnderlineOk", { undercurl = true, sp = c.green })

	-- Diagnostic floating windows
	hl("DiagnosticFloatingError", { fg = c.error })
	hl("DiagnosticFloatingWarn", { fg = c.warning })
	hl("DiagnosticFloatingInfo", { fg = c.info })
	hl("DiagnosticFloatingHint", { fg = c.hint })
	hl("DiagnosticFloatingOk", { fg = c.green })

	-- Diagnostic signs
	hl("DiagnosticSignError", { fg = c.error })
	hl("DiagnosticSignWarn", { fg = c.warning })
	hl("DiagnosticSignInfo", { fg = c.info })
	hl("DiagnosticSignHint", { fg = c.hint })
	hl("DiagnosticSignOk", { fg = c.green })

	-- LSP references
	hl("LspReferenceText", { bg = c.selection })
	hl("LspReferenceRead", { bg = c.selection })
	hl("LspReferenceWrite", { bg = c.selection })

	-- LSP signature help
	hl("LspSignatureActiveParameter", { fg = c.orange, bold = true })

	-- LSP codelens
	hl("LspCodeLens", { fg = c.comment })
	hl("LspCodeLensSeparator", { fg = c.fg_gutter })

	-- LSP inlay hints
	hl("LspInlayHint", { fg = c.comment, bg = c.bg_light })

	-- Semantic tokens
	hl("@lsp.type.class", { fg = c.yellow })
	hl("@lsp.type.decorator", { fg = c.orange })
	hl("@lsp.type.enum", { fg = c.yellow })
	hl("@lsp.type.enumMember", { fg = c.fg })
	hl("@lsp.type.function", { fg = c.orange })
	hl("@lsp.type.interface", { fg = c.yellow })
	hl("@lsp.type.macro", { fg = c.yellow })
	hl("@lsp.type.method", { fg = c.orange })
	hl("@lsp.type.namespace", { fg = c.yellow })
	hl("@lsp.type.parameter", { fg = c.fg })
	hl("@lsp.type.property", { fg = c.fg_dark })
	hl("@lsp.type.struct", { fg = c.yellow })
	hl("@lsp.type.type", { fg = c.yellow })
	hl("@lsp.type.typeAlias", { fg = c.yellow })
	hl("@lsp.type.typeParameter", { fg = c.yellow })
	hl("@lsp.type.variable", { fg = c.fg })

	-- Semantic token modifiers
	hl("@lsp.mod.deprecated", { strikethrough = true })
	hl("@lsp.mod.readonly", { italic = true })
	hl("@lsp.mod.defaultLibrary", { fg = c.yellow })

	-- Type modifiers
	hl("@lsp.typemod.variable.defaultLibrary", { fg = c.yellow })
	hl("@lsp.typemod.function.defaultLibrary", { fg = c.orange })
end

return M
