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
	hl("CursorLineNr", { fg = c.orange, bold = true })
	hl("SignColumn", { fg = c.fg_gutter, bg = bg })
	hl("VertSplit", { fg = c.border, bg = bg })
	hl("WinSeparator", { fg = c.border, bg = bg })
	hl("Folded", { fg = c.comment, bg = config.transparent and c.none or c.bg_light })
	hl("FoldColumn", { fg = c.comment, bg = bg })
	hl("NonText", { fg = c.fg_gutter })
	hl("SpecialKey", { fg = c.fg_gutter })
	hl("Whitespace", { fg = c.fg_gutter })

	-- Search & Selection
	hl("Search", { fg = c.bg, bg = c.orange })
	hl("IncSearch", { fg = c.bg, bg = c.orange })
	hl("CurSearch", { fg = c.bg, bg = c.orange })
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
	hl("Directory", { fg = c.yellow })
	hl("Title", { fg = c.yellow, bold = true })
	hl("Conceal", { fg = c.comment })
	hl("MatchParen", { fg = c.rose, bold = true })
	hl("FloatBorder", { fg = c.border, bg = config.transparent and c.none or c.bg_dark })
	hl("WildMenu", { fg = c.bg, bg = c.yellow })
	hl("QuickFixLine", { bg = c.selection })

	-- Syntax highlighting
	hl("Comment", { fg = c.comment, italic = config.italic_comments })
	hl("Constant", { fg = c.fg })
	hl("String", { fg = c.cyan })
	hl("Character", { fg = c.green })
	hl("Number", { fg = c.yellow })
	hl("Boolean", { fg = c.yellow })
	hl("Float", { fg = c.yellow })

	hl("Identifier", { fg = c.fg })
	hl("Function", { fg = c.orange })

	hl("Statement", { fg = c.yellow })
	hl("Conditional", { fg = c.rose })
	hl("Repeat", { fg = c.red })
	hl("Label", { fg = c.yellow })
	hl("Operator", { fg = c.yellow })
	hl("Keyword", { fg = c.yellow })
	hl("Exception", { fg = c.rose })

	hl("PreProc", { fg = c.yellow })
	hl("Include", { fg = c.yellow })
	hl("Define", { fg = c.yellow })
	hl("Macro", { fg = c.yellow })
	hl("PreCondit", { fg = c.yellow })

	hl("Type", { fg = c.yellow })
	hl("StorageClass", { fg = c.yellow })
	hl("Structure", { fg = c.yellow })
	hl("Typedef", { fg = c.yellow })

	hl("Special", { fg = c.yellow })
	hl("SpecialChar", { fg = c.yellow })
	hl("Tag", { fg = c.orange })
	hl("Delimiter", { fg = c.rose })
	hl("SpecialComment", { fg = c.comment })
	hl("Debug", { fg = c.orange })

	hl("Underlined", { underline = true })
	hl("Ignore", { fg = c.bg })
	hl("Error", { fg = c.error })
	hl("Todo", { fg = c.bg, bg = c.orange, bold = true })
end

return M
