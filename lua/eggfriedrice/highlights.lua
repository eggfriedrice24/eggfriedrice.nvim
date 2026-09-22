---@module "eggfriedrice.highlights"
---@author eggfriedrice24
---@license MIT

local M = {}

---Editor UI and legacy syntax groups.
---@param c table
---@param config eggfriedrice.Config
---@return table<string, vim.api.keyset.highlight>
function M.get(c, config)
	local bg = config.transparent and c.none or c.bg
	local bg_dark = config.transparent and c.none or c.bg_dark
	local bg_light = config.transparent and c.none or c.bg_light

	return {
		-- Editor UI
		Normal = { fg = c.fg, bg = bg },
		NormalFloat = { fg = c.fg, bg = bg_dark },
		NormalNC = {
			fg = c.fg,
			bg = config.transparent and c.none or (config.dim_inactive and c.bg_dark or c.bg),
		},
		Cursor = { fg = c.bg, bg = c.fg },
		CursorLine = { bg = bg_light },
		CursorColumn = { bg = bg_light },
		ColorColumn = { bg = bg_light },
		LineNr = { fg = c.fg_gutter },
		CursorLineNr = { fg = c.yellow, bold = true },
		SignColumn = { fg = c.fg_gutter, bg = bg },
		VertSplit = { fg = c.border, bg = bg },
		WinSeparator = { fg = c.border, bg = bg },
		Folded = { fg = c.comment, bg = bg_light },
		FoldColumn = { fg = c.comment, bg = bg },
		NonText = { fg = c.fg_gutter },
		SpecialKey = { fg = c.fg_gutter },
		Whitespace = { fg = c.fg_gutter },

		-- Search & Selection
		Search = { bg = c.search },
		IncSearch = { fg = c.bg, bg = c.yellow, bold = true },
		CurSearch = { link = "IncSearch" },
		Substitute = { fg = c.bg, bg = c.red },
		Visual = { bg = c.selection },
		VisualNOS = { bg = c.selection },

		-- Pmenu (completion menu)
		Pmenu = { fg = c.fg, bg = c.bg_dark },
		PmenuSel = { fg = c.fg, bg = c.selection },
		PmenuKind = { fg = c.fg_dark, bg = c.bg_dark },
		PmenuExtra = { fg = c.comment, bg = c.bg_dark },
		PmenuSbar = { bg = c.bg_light },
		PmenuThumb = { bg = c.fg_gutter },

		-- Statusline & Tabline
		StatusLine = { fg = c.fg, bg = bg_dark },
		StatusLineNC = { fg = c.fg_gutter, bg = bg_dark },
		TabLine = { fg = c.fg_gutter, bg = bg_dark },
		TabLineFill = { bg = bg_dark },
		TabLineSel = { fg = c.fg, bg = bg },
		WinBar = { fg = c.fg, bg = bg },
		WinBarNC = { fg = c.fg_gutter, bg = bg },

		-- Messages
		ModeMsg = { fg = c.fg, bold = true },
		MoreMsg = { fg = c.cyan },
		Question = { fg = c.cyan },
		WarningMsg = { fg = c.warning },
		ErrorMsg = { fg = c.error },

		-- Diff
		DiffAdd = { bg = c.diff.add },
		DiffChange = { bg = c.diff.change },
		DiffDelete = { bg = c.diff.delete },
		DiffText = { bg = c.diff.text },
		Added = { fg = c.git_add },
		Changed = { fg = c.git_change },
		Removed = { fg = c.git_delete },

		-- Spell
		SpellBad = { undercurl = true, sp = c.error },
		SpellCap = { undercurl = true, sp = c.warning },
		SpellLocal = { undercurl = true, sp = c.info },
		SpellRare = { undercurl = true, sp = c.hint },

		-- Misc UI
		Directory = { fg = c.cyan },
		Title = { fg = c.yellow, bold = true },
		Conceal = { fg = c.comment },
		MatchParen = { fg = c.yellow, bold = true },
		FloatBorder = { fg = c.border, bg = bg_dark },
		FloatTitle = { fg = c.yellow, bg = bg_dark, bold = true },
		WildMenu = { fg = c.bg, bg = c.yellow },
		QuickFixLine = { bg = c.selection },

		-- Syntax (legacy groups; must agree with the treesitter role map)
		Comment = { fg = c.comment, italic = config.italic_comments },
		Constant = { fg = c.yellow },
		String = { fg = c.green },
		Character = { fg = c.green },
		Number = { fg = c.yellow },
		Boolean = { fg = c.yellow },
		Float = { fg = c.yellow },

		Identifier = { fg = c.red },
		Function = { fg = c.yellow },

		Statement = { fg = c.purple },
		Conditional = { fg = c.purple },
		Repeat = { fg = c.purple },
		Label = { fg = c.red },
		Operator = { fg = c.blue },
		Keyword = { fg = c.purple },
		Exception = { fg = c.purple },

		PreProc = { fg = c.purple },
		Include = { fg = c.purple },
		Define = { fg = c.purple },
		Macro = { fg = c.yellow },
		PreCondit = { fg = c.purple },

		Type = { fg = c.yellow },
		StorageClass = { fg = c.purple },
		Structure = { fg = c.purple },
		Typedef = { fg = c.purple },

		Special = { fg = c.cyan },
		SpecialChar = { fg = c.cyan },
		Tag = { fg = c.red },
		Delimiter = { fg = c.fg_dark },
		SpecialComment = { fg = c.comment },
		Debug = { fg = c.yellow },

		Underlined = { underline = true },
		Ignore = { fg = c.bg },
		Error = { fg = c.error },
		Todo = { fg = c.bg, bg = c.yellow, bold = true },
	}
end

return M
