---@module "eggfriedrice.plugins"
---@author eggfriedrice24
---@license MIT

local M = {}

---Plugin highlight groups.
---@param c table
---@param config eggfriedrice.Config
---@return table<string, vim.api.keyset.highlight>
function M.get(c, config)
	local bg = config.transparent and c.none or c.bg
	local bg_dark = config.transparent and c.none or c.bg_dark
	local bg_light = config.transparent and c.none or c.bg_light

	return {
		-- Telescope
		TelescopeNormal = { fg = c.fg, bg = bg_dark },
		TelescopeBorder = { fg = c.border, bg = bg_dark },
		TelescopePromptNormal = { fg = c.fg, bg = bg_light },
		TelescopePromptBorder = { fg = c.border, bg = bg_light },
		TelescopePromptTitle = { fg = c.bg, bg = c.yellow, bold = true },
		TelescopeResultsTitle = { fg = c.bg, bg = c.cyan },
		TelescopePreviewTitle = { fg = c.bg, bg = c.green },
		TelescopeSelection = { bg = c.selection },
		TelescopeSelectionCaret = { fg = c.yellow },
		TelescopeMatching = { fg = c.yellow, bold = true },
		TelescopePromptPrefix = { fg = c.yellow },

		-- nvim-tree
		NvimTreeNormal = { fg = c.fg, bg = bg_dark },
		NvimTreeNormalNC = { fg = c.fg, bg = bg_dark },
		NvimTreeRootFolder = { fg = c.yellow, bold = true },
		NvimTreeFolderName = { fg = c.cyan },
		NvimTreeFolderIcon = { fg = c.cyan },
		NvimTreeOpenedFolderName = { fg = c.cyan },
		NvimTreeEmptyFolderName = { fg = c.comment },
		NvimTreeIndentMarker = { fg = c.fg_gutter },
		NvimTreeSymlink = { fg = c.cyan },
		NvimTreeSpecialFile = { fg = c.yellow },
		NvimTreeImageFile = { fg = c.fg },
		NvimTreeGitDirty = { fg = c.git_change },
		NvimTreeGitNew = { fg = c.git_add },
		NvimTreeGitDeleted = { fg = c.git_delete },
		NvimTreeGitStaged = { fg = c.green },

		-- neo-tree
		NeoTreeNormal = { fg = c.fg, bg = bg_dark },
		NeoTreeNormalNC = { fg = c.fg, bg = bg_dark },
		NeoTreeDirectoryName = { fg = c.cyan },
		NeoTreeDirectoryIcon = { fg = c.cyan },
		NeoTreeRootName = { fg = c.yellow, bold = true },
		NeoTreeGitAdded = { fg = c.git_add },
		NeoTreeGitModified = { fg = c.git_change },
		NeoTreeGitDeleted = { fg = c.git_delete },
		NeoTreeGitConflict = { fg = c.red, bold = true },
		NeoTreeIndentMarker = { fg = c.fg_gutter },

		-- gitsigns (the *Nr variants default-link to these)
		GitSignsAdd = { fg = c.git_add },
		GitSignsChange = { fg = c.git_change },
		GitSignsDelete = { fg = c.git_delete },
		GitSignsAddLn = { bg = c.diff.add },
		GitSignsChangeLn = { bg = c.diff.change },
		GitSignsDeleteLn = { bg = c.diff.delete },
		GitSignsCurrentLineBlame = { fg = c.comment },

		-- indent-blankline
		IndentBlanklineChar = { fg = c.fg_gutter },
		IndentBlanklineContextChar = { fg = c.scope },
		IndentBlanklineContextStart = { sp = c.scope, underline = true },
		IblIndent = { fg = c.fg_gutter },
		IblScope = { fg = c.scope },

		-- which-key
		WhichKey = { fg = c.yellow },
		WhichKeyGroup = { fg = c.cyan },
		WhichKeyDesc = { fg = c.fg },
		WhichKeySeparator = { fg = c.comment },
		WhichKeyFloat = { bg = bg_dark },
		WhichKeyBorder = { fg = c.border, bg = bg_dark },
		WhichKeyValue = { fg = c.fg_dark },

		-- nvim-cmp (kinds follow the syntax role map)
		CmpItemAbbr = { fg = c.fg },
		CmpItemAbbrDeprecated = { fg = c.comment, strikethrough = true },
		CmpItemAbbrMatch = { fg = c.yellow, bold = true },
		CmpItemAbbrMatchFuzzy = { fg = c.yellow },
		CmpItemMenu = { fg = c.comment },
		CmpItemKindDefault = { fg = c.fg_dark },
		CmpItemKindKeyword = { fg = c.purple },
		CmpItemKindFunction = { fg = c.yellow },
		CmpItemKindMethod = { fg = c.yellow },
		CmpItemKindConstructor = { fg = c.yellow },
		CmpItemKindClass = { fg = c.yellow },
		CmpItemKindInterface = { fg = c.yellow },
		CmpItemKindStruct = { fg = c.yellow },
		CmpItemKindEnum = { fg = c.yellow },
		CmpItemKindModule = { fg = c.yellow },
		CmpItemKindTypeParameter = { fg = c.yellow },
		CmpItemKindEnumMember = { fg = c.cyan },
		CmpItemKindEvent = { fg = c.yellow },
		CmpItemKindFolder = { fg = c.cyan },
		CmpItemKindConstant = { fg = c.yellow },
		CmpItemKindValue = { fg = c.yellow },
		CmpItemKindUnit = { fg = c.yellow },
		CmpItemKindColor = { fg = c.yellow },
		CmpItemKindOperator = { fg = c.blue },
		CmpItemKindSnippet = { fg = c.green },
		CmpItemKindVariable = { fg = c.red },
		CmpItemKindReference = { fg = c.red },
		CmpItemKindProperty = { fg = c.red },
		CmpItemKindField = { fg = c.red },
		CmpItemKindText = { fg = c.fg },
		CmpItemKindFile = { fg = c.fg },

		-- lazy.nvim
		LazyH1 = { fg = c.bg, bg = c.yellow, bold = true },
		LazyButton = { fg = c.fg, bg = bg_light },
		LazyButtonActive = { fg = c.bg, bg = c.yellow },
		LazySpecial = { fg = c.yellow },
		LazyProgressDone = { fg = c.green },
		LazyProgressTodo = { fg = c.fg_gutter },

		-- mason.nvim
		MasonNormal = { fg = c.fg, bg = bg_dark },
		MasonHeader = { fg = c.bg, bg = c.yellow, bold = true },
		MasonHeaderSecondary = { fg = c.bg, bg = c.cyan, bold = true },
		MasonHighlight = { fg = c.yellow },
		MasonHighlightBlock = { fg = c.bg, bg = c.green },
		MasonHighlightBlockBold = { fg = c.bg, bg = c.green, bold = true },
		MasonMuted = { fg = c.comment },
		MasonMutedBlock = { fg = c.bg, bg = c.fg_gutter },

		-- bufferline.nvim
		BufferLineFill = { bg = bg_dark },
		BufferLineBackground = { fg = c.comment, bg = bg_dark },
		BufferLineBuffer = { fg = c.comment, bg = bg_dark },
		BufferLineBufferSelected = { fg = c.fg, bg = bg, bold = true },
		BufferLineBufferVisible = { fg = c.fg_dark, bg = bg },
		BufferLineCloseButton = { fg = c.comment, bg = bg_dark },
		BufferLineCloseButtonSelected = { fg = c.red, bg = bg },
		BufferLineCloseButtonVisible = { fg = c.fg_dark, bg = bg },
		BufferLineIndicatorSelected = { fg = c.yellow, bg = bg },
		BufferLineSeparator = { fg = bg_dark, bg = bg_dark },
		BufferLineSeparatorSelected = { fg = bg_dark, bg = bg },
		BufferLineSeparatorVisible = { fg = bg_dark, bg = bg },
		BufferLineTab = { fg = c.comment, bg = bg_dark },
		BufferLineTabSelected = { fg = c.fg, bg = bg },
		BufferLineTabClose = { fg = c.red, bg = bg_dark },
		BufferLineModified = { fg = c.git_change, bg = bg_dark },
		BufferLineModifiedSelected = { fg = c.git_change, bg = bg },
		BufferLineModifiedVisible = { fg = c.git_change, bg = bg },

		-- nvim-notify
		NotifyERRORBorder = { fg = c.error },
		NotifyWARNBorder = { fg = c.warning },
		NotifyINFOBorder = { fg = c.info },
		NotifyDEBUGBorder = { fg = c.comment },
		NotifyTRACEBorder = { fg = c.purple },
		NotifyERRORIcon = { fg = c.error },
		NotifyWARNIcon = { fg = c.warning },
		NotifyINFOIcon = { fg = c.info },
		NotifyDEBUGIcon = { fg = c.comment },
		NotifyTRACEIcon = { fg = c.purple },
		NotifyERRORTitle = { fg = c.error },
		NotifyWARNTitle = { fg = c.warning },
		NotifyINFOTitle = { fg = c.info },
		NotifyDEBUGTitle = { fg = c.comment },
		NotifyTRACETitle = { fg = c.purple },

		-- noice.nvim
		NoiceCmdlinePopup = { fg = c.fg, bg = bg_dark },
		NoiceCmdlinePopupBorder = { fg = c.border },
		NoiceCmdlineIcon = { fg = c.yellow },
		NoiceConfirm = { fg = c.fg, bg = bg_dark },
		NoiceConfirmBorder = { fg = c.border },

		-- flash.nvim
		FlashLabel = { fg = c.bg, bg = c.red, bold = true },
		FlashMatch = { bg = c.search },
		FlashCurrent = { fg = c.bg, bg = c.yellow },

		-- mini.nvim (mode colors match the lualine theme)
		MiniStatuslineDevinfo = { fg = c.fg, bg = bg_light },
		MiniStatuslineFileinfo = { fg = c.fg, bg = bg_light },
		MiniStatuslineFilename = { fg = c.fg_dark, bg = bg_dark },
		MiniStatuslineInactive = { fg = c.comment, bg = bg_dark },
		MiniStatuslineModeNormal = { fg = c.bg, bg = c.yellow, bold = true },
		MiniStatuslineModeInsert = { fg = c.bg, bg = c.green, bold = true },
		MiniStatuslineModeVisual = { fg = c.bg, bg = c.purple, bold = true },
		MiniStatuslineModeReplace = { fg = c.bg, bg = c.red, bold = true },
		MiniStatuslineModeCommand = { fg = c.bg, bg = c.cyan, bold = true },
		MiniStatuslineModeOther = { fg = c.bg, bg = c.cyan, bold = true },
		MiniIndentscopeSymbol = { fg = c.scope },
		MiniCursorword = { bg = c.selection },
		MiniCursorwordCurrent = { bg = c.selection },
	}
end

return M
