---@module "eggfriedrice.extra.bat"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

-- Global tmTheme settings, snake_case here and camelCase in the XML.
local settings = {
	"background",
	"foreground",
	"caret",
	"selection",
	"line_highlight",
	"gutter",
	"gutter_foreground",
	"find_highlight",
	"find_highlight_foreground",
	"invisibles",
}

-- Scope selectors per rule, following the Sublime Text conventions bat's
-- syntaxes use. Punctuation is muted like the editor, but string
-- delimiters keep the string color so quotes are not greyed out.
local scopes = {
	comment = { "Comment", "comment, punctuation.definition.comment" },
	string = { "String", "string" },
	escape = { "Escape", "constant.character.escape" },
	enum_member = { "Enum member", "variable.other.enummember, entity.name.enum-member, constant.other.enum" },
	keyword = { "Keyword", "keyword, keyword.control, keyword.other" },
	storage = { "Storage", "storage, storage.type, storage.modifier" },
	decorator = {
		"Decorator",
		"meta.annotation, storage.type.annotation, punctuation.definition.annotation, entity.name.function.decorator, meta.decorator",
	},
	["function"] = { "Function", "entity.name.function, support.function, meta.function-call, variable.function" },
	type = {
		"Type",
		"entity.name.type, entity.name.class, entity.name.struct, entity.name.enum, entity.name.interface, entity.name.namespace, support.type, support.class, entity.other.inherited-class",
	},
	constant = { "Constant", "constant, constant.language, support.constant" },
	number = { "Number", "constant.numeric" },
	attribute = { "Attribute", "entity.other.attribute-name" },
	variable = { "Variable", "variable, variable.other, variable.parameter, variable.language" },
	property = {
		"Property",
		"variable.other.member, variable.other.property, variable.other.object.property, support.type.property-name, meta.object-literal.key, entity.name.label",
	},
	tag = { "Tag", "entity.name.tag, punctuation.definition.tag" },
	operator = { "Operator", "keyword.operator" },
	punctuation = {
		"Punctuation",
		"punctuation.separator, punctuation.terminator, punctuation.accessor, punctuation.section, meta.brace",
	},
	invalid = { "Invalid", "invalid, invalid.illegal" },
	markup_heading = { "Markup heading", "markup.heading, entity.name.section" },
	markup_bold = { "Markup bold", "markup.bold" },
	markup_italic = { "Markup italic", "markup.italic" },
	markup_link = { "Markup link", "markup.underline.link, string.other.link" },
	markup_code = { "Markup code", "markup.raw, markup.raw.inline, markup.raw.block" },
	markup_list = { "Markup list", "markup.list, punctuation.definition.list_item" },
	markup_quote = { "Markup quote", "markup.quote" },
	diff_inserted = { "Diff inserted", "markup.inserted" },
	diff_deleted = { "Diff deleted", "markup.deleted" },
	diff_changed = { "Diff changed", "markup.changed" },
	diff_header = { "Diff header", "meta.diff.header, meta.diff.range, meta.diff.index" },
}

---Settings first, then one style per scope rule in render order.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "background", "bg" },
		{ "foreground", "fg" },
		{ "caret", "yellow" },
		{ "selection", "selection" },
		{ "line_highlight", "bg_light" },
		{ "gutter", "bg" },
		{ "gutter_foreground", "fg_gutter_ui" },
		{ "find_highlight", "search" },
		{ "find_highlight_foreground", "fg" },
		{ "invisibles", "fg_gutter" },
		{ "comment", { fg = "comment", italic = true } },
		{ "string", { fg = "green" } },
		{ "escape", { fg = "cyan" } },
		{ "enum_member", { fg = "cyan" } },
		{ "keyword", { fg = "purple" } },
		{ "storage", { fg = "purple" } },
		{ "decorator", { fg = "purple" } },
		{ "function", { fg = "yellow" } },
		{ "type", { fg = "yellow" } },
		{ "constant", { fg = "yellow" } },
		{ "number", { fg = "yellow" } },
		{ "attribute", { fg = "yellow" } },
		{ "variable", { fg = "red" } },
		{ "property", { fg = "red" } },
		{ "tag", { fg = "red" } },
		{ "operator", { fg = "blue" } },
		{ "punctuation", { fg = "fg_dark" } },
		{ "invalid", { fg = "red", underline = true } },
		{ "markup_heading", { fg = "red", bold = true } },
		{ "markup_bold", { bold = true } },
		{ "markup_italic", { italic = true } },
		{ "markup_link", { fg = "purple", underline = true } },
		{ "markup_code", { fg = "green" } },
		{ "markup_list", { fg = "yellow" } },
		{ "markup_quote", { fg = "comment", italic = true } },
		{ "diff_inserted", { fg = "green" } },
		{ "diff_deleted", { fg = "red" } },
		{ "diff_changed", { fg = "yellow" } },
		{ "diff_header", { fg = "cyan" } },
	}
end

---snake_case to camelCase, as tmTheme setting keys are spelled.
---@param s string
---@return string
local function camel(s)
	return (s:gsub("_(%l)", string.upper))
end

---One `<dict>` entry of the tmTheme settings array.
---@param c table
---@param id string
---@param style table
---@return string
local function rule(c, id, style)
	local extra = require("eggfriedrice.extra")
	local pairs_ = {}
	local flags = {}
	for _, flag in ipairs({ "bold", "italic", "underline" }) do
		if style[flag] then
			flags[#flags + 1] = flag
		end
	end
	if #flags > 0 then
		pairs_[#pairs_ + 1] = { "fontStyle", table.concat(flags, " ") }
	end
	if style.fg then
		pairs_[#pairs_ + 1] = { "foreground", extra.hex(c, style.fg) }
	end
	local lines = {
		"\t\t<dict>",
		"\t\t\t<key>name</key>",
		"\t\t\t<string>" .. scopes[id][1] .. "</string>",
		"\t\t\t<key>scope</key>",
		"\t\t\t<string>" .. scopes[id][2] .. "</string>",
		"\t\t\t<key>settings</key>",
		"\t\t\t<dict>",
	}
	for _, kv in ipairs(pairs_) do
		lines[#lines + 1] = "\t\t\t\t<key>" .. kv[1] .. "</key>"
		lines[#lines + 1] = "\t\t\t\t<string>" .. kv[2] .. "</string>"
	end
	lines[#lines + 1] = "\t\t\t</dict>"
	lines[#lines + 1] = "\t\t</dict>"
	return table.concat(lines, "\n")
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local roles = M.roles(c)
	local global = {}
	for _, key in ipairs(settings) do
		global[#global + 1] = "\t\t\t\t<key>" .. camel(key) .. "</key>"
		global[#global + 1] = "\t\t\t\t<string>" .. extra.hex(c, extra.role(roles, key)) .. "</string>"
	end
	local rules = {}
	for _, e in ipairs(roles) do
		if extra.is_style(e[2]) then
			rules[#rules + 1] = rule(c, e[1], e[2])
		end
	end
	return util.template(
		[[
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<!--
  eggfriedrice for bat and Sublime Text
  generated from lua/eggfriedrice/colors.lua by `make extras`; do not edit by hand
  install: copy to ~/.config/bat/themes/, run `bat cache -b`, set BAT_THEME=eggfriedrice
-->
<plist version="1.0">
<dict>
	<key>name</key>
	<string>eggfriedrice</string>
	<key>uuid</key>
	<string>df3b6327-0ef5-47aa-9223-0c6eca464ba6</string>
	<key>settings</key>
	<array>
		<dict>
			<key>settings</key>
			<dict>
${global}
			</dict>
		</dict>
${rules}
	</array>
</dict>
</plist>
]],
		{ global = table.concat(global, "\n"), rules = table.concat(rules, "\n") }
	)
end

return M
