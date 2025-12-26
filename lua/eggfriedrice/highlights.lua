---@module "eggfriedrice.highlights"
---@author eggfriedrice24
---@license MIT

local M = {}

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

function M.setup(c, config)
	local bg = config.transparent and c.none or c.bg
	local bg_dark = config.transparent and c.none or c.bg_dark

	-- Editor UI
	hl("Normal", { fg = c.fg, bg = bg })
	hl("NormalFloat", { fg = c.fg, bg = config.transparent and c.none or c.bg_dark })
	hl("NormalNC", { fg = c.fg, bg = config.dim_inactive and c.bg_dark or bg })
	hl("Cursor", { fg = c.bg, bg = c.fg })
	hl("CursorLine", { bg = config.transparent and c.none or c.bg_light })
	hl("CursorColumn", { bg = config.transparent and c.none or c.bg_light })
	hl("ColorColumn", { bg = config.transparent and c.none or c.bg_light })
	hl("LineNr", { fg = c.fg_gutter })
	hl("CursorLineNr", { fg = c.yellow, bold = true })
	hl("SignColumn", { fg = c.fg_gutter, bg = bg })
	hl("VertSplit", { fg = c.border, bg = bg })
	hl("WinSeparator", { fg = c.border, bg = bg })
	hl("Folded", { fg = c.comment, bg = config.transparent and c.none or c.bg_light })
	hl("FoldColumn", { fg = c.comment, bg = bg })
	hl("NonText", { fg = c.fg_gutter })
	hl("SpecialKey", { fg = c.fg_gutter })
	hl("Whitespace", { fg = c.fg_gutter })

	-- Search & Selection
	hl("Search", { fg = c.bg, bg = c.yellow })
	hl("IncSearch", { fg = c.bg, bg = c.yellow })
	hl("CurSearch", { fg = c.bg, bg = c.yellow })
	hl("Substitute", { fg = c.bg, bg = c.red })
	hl("Visual", { bg = c.selection })
	hl("VisualNOS", { bg = c.selection })

	-- Pmenu (completion menu)
	hl("Pmenu", { fg = c.fg, bg = c.bg_dark })
	hl("PmenuSel", { fg = c.fg, bg = c.selection })
	hl("PmenuSbar", { bg = c.bg_light })
	hl("PmenuThumb", { bg = c.fg_gutter })

	-- Statusline & Tabline
	hl("StatusLine", { fg = c.fg, bg = bg_dark })
	hl("StatusLineNC", { fg = c.fg_gutter, bg = bg_dark })
	hl("TabLine", { fg = c.fg_gutter, bg = bg_dark })
	hl("TabLineFill", { bg = bg_dark })
	hl("TabLineSel", { fg = c.fg, bg = bg })
	hl("WinBar", { fg = c.fg, bg = bg })
	hl("WinBarNC", { fg = c.fg_gutter, bg = bg })

	-- Messages
	hl("ModeMsg", { fg = c.fg, bold = true })
	hl("MoreMsg", { fg = c.cyan })
	hl("Question", { fg = c.cyan })
	hl("WarningMsg", { fg = c.warning })
	hl("ErrorMsg", { fg = c.error })

	-- Diff
	hl("DiffAdd", { bg = "#1a2f1a" })
	hl("DiffChange", { bg = "#2a2a1a" })
	hl("DiffDelete", { bg = "#2f1a1a" })
	hl("DiffText", { bg = "#3a3a1a" })

	-- Spell
	hl("SpellBad", { undercurl = true, sp = c.error })
	hl("SpellCap", { undercurl = true, sp = c.warning })
	hl("SpellLocal", { undercurl = true, sp = c.info })
	hl("SpellRare", { undercurl = true, sp = c.hint })

	-- Misc UI
	hl("Directory", { fg = c.cyan })
	hl("Title", { fg = c.cyan, bold = true })
	hl("Conceal", { fg = c.comment })
	hl("MatchParen", { fg = c.rose, bold = true })
	hl("FloatBorder", { fg = c.border, bg = config.transparent and c.none or c.bg_dark })
	hl("WildMenu", { fg = c.bg, bg = c.cyan })
	hl("QuickFixLine", { bg = c.selection })

	-- Syntax highlighting
	hl("Comment", { fg = c.comment, italic = config.italic_comments })
	hl("Constant", { fg = c.orange })
	hl("String", { fg = c.green })
	hl("Character", { fg = c.green })
	hl("Number", { fg = c.orange })
	hl("Boolean", { fg = c.orange })
	hl("Float", { fg = c.orange })

	hl("Identifier", { fg = c.fg })
	hl("Function", { fg = c.yellow })

	hl("Statement", { fg = c.cyan })
	hl("Conditional", { fg = c.red })
	hl("Repeat", { fg = c.red })
	hl("Label", { fg = c.cyan })
	hl("Operator", { fg = c.cyan })
	hl("Keyword", { fg = c.cyan })
	hl("Exception", { fg = c.red })

	hl("PreProc", { fg = c.cyan })
	hl("Include", { fg = c.yellow })
	hl("Define", { fg = c.cyan })
	hl("Macro", { fg = c.cyan })
	hl("PreCondit", { fg = c.cyan })

	hl("Type", { fg = c.cyan })
	hl("StorageClass", { fg = c.cyan })
	hl("Structure", { fg = c.cyan })
	hl("Typedef", { fg = c.cyan })

	hl("Special", { fg = c.yellow })
	hl("SpecialChar", { fg = c.cyan })
	hl("Tag", { fg = c.red })
	hl("Delimiter", { fg = c.rose })
	hl("SpecialComment", { fg = c.comment })
	hl("Debug", { fg = c.yellow })

	hl("Underlined", { underline = true })
	hl("Ignore", { fg = c.bg })
	hl("Error", { fg = c.error })
	hl("Todo", { fg = c.bg, bg = c.yellow, bold = true })
end

return M
