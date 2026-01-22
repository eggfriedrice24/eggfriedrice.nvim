---@module "eggfriedrice.plugins"
---@author eggfriedrice24
---@license MIT

local M = {}

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

function M.setup(c, config)
	local bg = config.transparent and c.none or c.bg
	local bg_dark = config.transparent and c.none or c.bg_dark
	local bg_light = config.transparent and c.none or c.bg_light

	-- Telescope
	hl("TelescopeNormal", { fg = c.fg, bg = bg_dark })
	hl("TelescopeBorder", { fg = c.border, bg = bg_dark })
	hl("TelescopePromptNormal", { fg = c.fg, bg = bg_light })
	hl("TelescopePromptBorder", { fg = c.border, bg = bg_light })
	hl("TelescopePromptTitle", { fg = c.bg, bg = c.cyan })
	hl("TelescopePreviewTitle", { fg = c.bg, bg = c.green })
	hl("TelescopeResultsTitle", { fg = c.bg, bg = c.cyan })
	hl("TelescopeSelection", { bg = c.selection })
	hl("TelescopeSelectionCaret", { fg = c.cyan })
	hl("TelescopeMatching", { fg = c.orange, bold = true })
	hl("TelescopePromptPrefix", { fg = c.cyan })

	-- nvim-tree
	hl("NvimTreeNormal", { fg = c.fg, bg = bg_dark })
	hl("NvimTreeNormalNC", { fg = c.fg, bg = bg_dark })
	hl("NvimTreeRootFolder", { fg = c.cyan, bold = true })
	hl("NvimTreeFolderName", { fg = c.cyan })
	hl("NvimTreeFolderIcon", { fg = c.cyan })
	hl("NvimTreeOpenedFolderName", { fg = c.cyan })
	hl("NvimTreeEmptyFolderName", { fg = c.comment })
	hl("NvimTreeIndentMarker", { fg = c.fg_gutter })
	hl("NvimTreeSymlink", { fg = c.cyan })
	hl("NvimTreeSpecialFile", { fg = c.orange })
	hl("NvimTreeImageFile", { fg = c.fg })
	hl("NvimTreeGitDirty", { fg = c.git_change })
	hl("NvimTreeGitNew", { fg = c.git_add })
	hl("NvimTreeGitDeleted", { fg = c.git_delete })
	hl("NvimTreeGitStaged", { fg = c.green })

	-- neo-tree
	hl("NeoTreeNormal", { fg = c.fg, bg = bg_dark })
	hl("NeoTreeNormalNC", { fg = c.fg, bg = bg_dark })
	hl("NeoTreeDirectoryName", { fg = c.cyan })
	hl("NeoTreeDirectoryIcon", { fg = c.cyan })
	hl("NeoTreeRootName", { fg = c.cyan, bold = true })
	hl("NeoTreeGitAdded", { fg = c.git_add })
	hl("NeoTreeGitModified", { fg = c.git_change })
	hl("NeoTreeGitDeleted", { fg = c.git_delete })
	hl("NeoTreeGitConflict", { fg = c.red, bold = true })
	hl("NeoTreeIndentMarker", { fg = c.fg_gutter })

	-- gitsigns
	hl("GitSignsAdd", { fg = c.git_add })
	hl("GitSignsChange", { fg = c.git_change })
	hl("GitSignsDelete", { fg = c.git_delete })
	hl("GitSignsAddNr", { fg = c.git_add })
	hl("GitSignsChangeNr", { fg = c.git_change })
	hl("GitSignsDeleteNr", { fg = c.git_delete })
	hl("GitSignsAddLn", { bg = "#1a2f1a" })
	hl("GitSignsChangeLn", { bg = "#2a2a1a" })
	hl("GitSignsDeleteLn", { bg = "#2f1a1a" })
	hl("GitSignsCurrentLineBlame", { fg = c.comment })

	-- indent-blankline
	hl("IndentBlanklineChar", { fg = c.fg_gutter })
	hl("IndentBlanklineContextChar", { fg = c.cyan })
	hl("IndentBlanklineContextStart", { sp = c.cyan, underline = true })
	hl("IblIndent", { fg = c.fg_gutter })
	hl("IblScope", { fg = c.cyan })

	-- which-key
	hl("WhichKey", { fg = c.cyan })
	hl("WhichKeyGroup", { fg = c.cyan })
	hl("WhichKeyDesc", { fg = c.fg })
	hl("WhichKeySeparator", { fg = c.comment })
	hl("WhichKeyFloat", { bg = bg_dark })
	hl("WhichKeyBorder", { fg = c.border, bg = bg_dark })
	hl("WhichKeyValue", { fg = c.fg_dark })

	-- nvim-cmp
	hl("CmpItemAbbr", { fg = c.fg })
	hl("CmpItemAbbrDeprecated", { fg = c.comment, strikethrough = true })
	hl("CmpItemAbbrMatch", { fg = c.cyan, bold = true })
	hl("CmpItemAbbrMatchFuzzy", { fg = c.cyan })
	hl("CmpItemMenu", { fg = c.comment })
	hl("CmpItemKindDefault", { fg = c.fg_dark })
	hl("CmpItemKindKeyword", { fg = c.yellow })
	hl("CmpItemKindVariable", { fg = c.fg })
	hl("CmpItemKindConstant", { fg = c.yellow })
	hl("CmpItemKindReference", { fg = c.fg })
	hl("CmpItemKindValue", { fg = c.yellow })
	hl("CmpItemKindFunction", { fg = c.orange })
	hl("CmpItemKindMethod", { fg = c.orange })
	hl("CmpItemKindConstructor", { fg = c.cyan })
	hl("CmpItemKindClass", { fg = c.cyan })
	hl("CmpItemKindInterface", { fg = c.cyan })
	hl("CmpItemKindStruct", { fg = c.cyan })
	hl("CmpItemKindEvent", { fg = c.cyan })
	hl("CmpItemKindEnum", { fg = c.cyan })
	hl("CmpItemKindUnit", { fg = c.cyan })
	hl("CmpItemKindModule", { fg = c.cyan })
	hl("CmpItemKindProperty", { fg = c.fg })
	hl("CmpItemKindField", { fg = c.fg })
	hl("CmpItemKindTypeParameter", { fg = c.cyan })
	hl("CmpItemKindEnumMember", { fg = c.yellow })
	hl("CmpItemKindOperator", { fg = c.cyan })
	hl("CmpItemKindSnippet", { fg = c.green })
	hl("CmpItemKindText", { fg = c.fg })
	hl("CmpItemKindFile", { fg = c.fg })
	hl("CmpItemKindFolder", { fg = c.cyan })
	hl("CmpItemKindColor", { fg = c.fg })

	-- lazy.nvim
	hl("LazyH1", { fg = c.bg, bg = c.cyan, bold = true })
	hl("LazyButton", { fg = c.fg, bg = bg_light })
	hl("LazyButtonActive", { fg = c.bg, bg = c.cyan })
	hl("LazySpecial", { fg = c.cyan })
	hl("LazyProgressDone", { fg = c.green })
	hl("LazyProgressTodo", { fg = c.fg_gutter })

	-- mason.nvim
	hl("MasonNormal", { fg = c.fg, bg = bg_dark })
	hl("MasonHeader", { fg = c.bg, bg = c.cyan, bold = true })
	hl("MasonHeaderSecondary", { fg = c.bg, bg = c.cyan, bold = true })
	hl("MasonHighlight", { fg = c.cyan })
	hl("MasonHighlightBlock", { fg = c.bg, bg = c.green })
	hl("MasonHighlightBlockBold", { fg = c.bg, bg = c.green, bold = true })
	hl("MasonMuted", { fg = c.comment })
	hl("MasonMutedBlock", { fg = c.bg, bg = c.fg_gutter })

	-- bufferline.nvim
	hl("BufferLineFill", { bg = bg_dark })
	hl("BufferLineBackground", { fg = c.comment, bg = bg_dark })
	hl("BufferLineBuffer", { fg = c.comment, bg = bg_dark })
	hl("BufferLineBufferSelected", { fg = c.fg, bg = bg, bold = true })
	hl("BufferLineBufferVisible", { fg = c.fg_dark, bg = bg })
	hl("BufferLineCloseButton", { fg = c.comment, bg = bg_dark })
	hl("BufferLineCloseButtonSelected", { fg = c.red, bg = bg })
	hl("BufferLineCloseButtonVisible", { fg = c.fg_dark, bg = bg })
	hl("BufferLineIndicatorSelected", { fg = c.cyan, bg = bg })
	hl("BufferLineSeparator", { fg = bg_dark, bg = bg_dark })
	hl("BufferLineSeparatorSelected", { fg = bg_dark, bg = bg })
	hl("BufferLineSeparatorVisible", { fg = bg_dark, bg = bg })
	hl("BufferLineTab", { fg = c.comment, bg = bg_dark })
	hl("BufferLineTabSelected", { fg = c.fg, bg = bg })
	hl("BufferLineTabClose", { fg = c.red, bg = bg_dark })
	hl("BufferLineModified", { fg = c.git_change, bg = bg_dark })
	hl("BufferLineModifiedSelected", { fg = c.git_change, bg = bg })
	hl("BufferLineModifiedVisible", { fg = c.git_change, bg = bg })

	-- notify.nvim
	hl("NotifyERRORBorder", { fg = c.error })
	hl("NotifyWARNBorder", { fg = c.warning })
	hl("NotifyINFOBorder", { fg = c.info })
	hl("NotifyDEBUGBorder", { fg = c.comment })
	hl("NotifyTRACEBorder", { fg = c.yellow })
	hl("NotifyERRORIcon", { fg = c.error })
	hl("NotifyWARNIcon", { fg = c.warning })
	hl("NotifyINFOIcon", { fg = c.info })
	hl("NotifyDEBUGIcon", { fg = c.comment })
	hl("NotifyTRACEIcon", { fg = c.yellow })
	hl("NotifyERRORTitle", { fg = c.error })
	hl("NotifyWARNTitle", { fg = c.warning })
	hl("NotifyINFOTitle", { fg = c.info })
	hl("NotifyDEBUGTitle", { fg = c.comment })
	hl("NotifyTRACETitle", { fg = c.yellow })

	-- noice.nvim
	hl("NoiceCmdlinePopup", { fg = c.fg, bg = bg_dark })
	hl("NoiceCmdlinePopupBorder", { fg = c.border })
	hl("NoiceCmdlineIcon", { fg = c.cyan })
	hl("NoiceConfirm", { fg = c.fg, bg = bg_dark })
	hl("NoiceConfirmBorder", { fg = c.border })

	-- flash.nvim
	hl("FlashLabel", { fg = c.bg, bg = c.yellow, bold = true })
	hl("FlashMatch", { fg = c.fg, bg = c.selection })
	hl("FlashCurrent", { fg = c.bg, bg = c.orange })

	-- mini.nvim
	hl("MiniStatuslineDevinfo", { fg = c.fg, bg = bg_light })
	hl("MiniStatuslineFileinfo", { fg = c.fg, bg = bg_light })
	hl("MiniStatuslineFilename", { fg = c.fg_dark, bg = bg_dark })
	hl("MiniStatuslineInactive", { fg = c.comment, bg = bg_dark })
	hl("MiniStatuslineModeCommand", { fg = c.bg, bg = c.orange, bold = true })
	hl("MiniStatuslineModeInsert", { fg = c.bg, bg = c.green, bold = true })
	hl("MiniStatuslineModeNormal", { fg = c.bg, bg = c.cyan, bold = true })
	hl("MiniStatuslineModeOther", { fg = c.bg, bg = c.cyan, bold = true })
	hl("MiniStatuslineModeReplace", { fg = c.bg, bg = c.red, bold = true })
	hl("MiniStatuslineModeVisual", { fg = c.bg, bg = c.yellow, bold = true })
	hl("MiniIndentscopeSymbol", { fg = c.cyan })
	hl("MiniCursorword", { bg = c.selection })
	hl("MiniCursorwordCurrent", { bg = c.selection })
end

return M
