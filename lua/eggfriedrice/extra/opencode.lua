---@module "eggfriedrice.extra.opencode"
---@license MIT

local M = {}

---Theme keys in opencode's documented order, each a palette key that
---becomes a def reference in the file.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "primary", "yellow" },
		{ "secondary", "purple" },
		{ "accent", "cyan" },
		{ "error", "red" },
		{ "warning", "yellow" },
		{ "success", "green" },
		{ "info", "cyan" },
		{ "text", "fg" },
		{ "textMuted", "fg_dark" },
		{ "background", "bg" },
		{ "backgroundPanel", "bg_dark" },
		{ "backgroundElement", "bg_light" },
		{ "border", "fg_gutter_ui" },
		{ "borderActive", "border" },
		{ "borderSubtle", "fg_gutter" },
		{ "diffAdded", "green" },
		{ "diffRemoved", "red" },
		{ "diffContext", "comment" },
		{ "diffHunkHeader", "cyan" },
		{ "diffHighlightAdded", "green_bright" },
		{ "diffHighlightRemoved", "red_bright" },
		{ "diffAddedBg", "diff_add" },
		{ "diffRemovedBg", "diff_delete" },
		{ "diffContextBg", "bg" },
		{ "diffLineNumber", "fg_gutter_ui" },
		{ "diffAddedLineNumberBg", "diff_add" },
		{ "diffRemovedLineNumberBg", "diff_delete" },
		{ "markdownText", "fg" },
		{ "markdownHeading", "red" },
		{ "markdownLink", "purple" },
		{ "markdownLinkText", "cyan" },
		{ "markdownCode", "green" },
		{ "markdownBlockQuote", "comment" },
		{ "markdownEmph", "fg" },
		{ "markdownStrong", "fg_bright" },
		{ "markdownHorizontalRule", "fg_gutter_ui" },
		{ "markdownListItem", "yellow" },
		{ "markdownListEnumeration", "yellow" },
		{ "markdownImage", "purple" },
		{ "markdownImageText", "cyan" },
		{ "markdownCodeBlock", "green" },
		{ "syntaxComment", "comment" },
		{ "syntaxKeyword", "purple" },
		{ "syntaxFunction", "yellow" },
		{ "syntaxVariable", "red" },
		{ "syntaxString", "green" },
		{ "syntaxNumber", "yellow" },
		{ "syntaxType", "yellow" },
		{ "syntaxOperator", "blue" },
		{ "syntaxPunctuation", "fg_dark" },
	}
end

---@param c table
---@return string
function M.generate(c)
	local defs = {}
	for _, color in ipairs(require("eggfriedrice.extra").colors(c)) do
		defs[#defs + 1] = ('    "%s": "%s"'):format(color[1], color[2])
	end
	local keys = {}
	for _, e in ipairs(M.roles(c)) do
		keys[#keys + 1] = ('    "%s": "%s"'):format(e[1], e[2])
	end
	return table.concat({
		"{",
		'  "$schema": "https://opencode.ai/theme.json",',
		'  "defs": {',
		table.concat(defs, ",\n"),
		"  },",
		'  "theme": {',
		table.concat(keys, ",\n"),
		"  }",
		"}",
		"",
	}, "\n")
end

return M
