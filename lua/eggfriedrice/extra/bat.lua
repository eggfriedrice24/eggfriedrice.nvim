---@module "eggfriedrice.extra.bat"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---One `<dict>` entry of the tmTheme settings array.
---@param name string
---@param scope string
---@param settings table<string, string> foreground, fontStyle...
---@return string
local function rule(name, scope, settings)
	local keys = vim.tbl_keys(settings)
	table.sort(keys)
	local lines = {
		"\t\t<dict>",
		"\t\t\t<key>name</key>",
		"\t\t\t<string>" .. name .. "</string>",
		"\t\t\t<key>scope</key>",
		"\t\t\t<string>" .. scope .. "</string>",
		"\t\t\t<key>settings</key>",
		"\t\t\t<dict>",
	}
	for _, k in ipairs(keys) do
		lines[#lines + 1] = "\t\t\t\t<key>" .. k .. "</key>"
		lines[#lines + 1] = "\t\t\t\t<string>" .. settings[k] .. "</string>"
	end
	lines[#lines + 1] = "\t\t\t</dict>"
	lines[#lines + 1] = "\t\t</dict>"
	return table.concat(lines, "\n")
end

---@param c table
---@return string
function M.generate(c)
	-- Scopes follow the Sublime Text conventions bat's syntaxes use.
	-- Punctuation is muted like the editor, but string delimiters keep the
	-- string color so quotes are not greyed out.
	local rules = {
		rule("Comment", "comment, punctuation.definition.comment", { foreground = c.comment, fontStyle = "italic" }),
		rule("String", "string", { foreground = c.green }),
		rule("Escape", "constant.character.escape", { foreground = c.cyan }),
		rule(
			"Enum member",
			"variable.other.enummember, entity.name.enum-member, constant.other.enum",
			{ foreground = c.cyan }
		),
		rule("Keyword", "keyword, keyword.control, keyword.other", { foreground = c.purple }),
		rule("Storage", "storage, storage.type, storage.modifier", { foreground = c.purple }),
		rule(
			"Decorator",
			"meta.annotation, storage.type.annotation, punctuation.definition.annotation, entity.name.function.decorator, meta.decorator",
			{ foreground = c.purple }
		),
		rule(
			"Function",
			"entity.name.function, support.function, meta.function-call, variable.function",
			{ foreground = c.yellow }
		),
		rule(
			"Type",
			"entity.name.type, entity.name.class, entity.name.struct, entity.name.enum, entity.name.interface, entity.name.namespace, support.type, support.class, entity.other.inherited-class",
			{ foreground = c.yellow }
		),
		rule("Constant", "constant, constant.language, constant.numeric, support.constant", { foreground = c.yellow }),
		rule("Attribute", "entity.other.attribute-name", { foreground = c.yellow }),
		rule("Variable", "variable, variable.other, variable.parameter, variable.language", { foreground = c.red }),
		rule(
			"Property",
			"variable.other.member, variable.other.property, variable.other.object.property, support.type.property-name, meta.object-literal.key, entity.name.label",
			{ foreground = c.red }
		),
		rule("Tag", "entity.name.tag, punctuation.definition.tag", { foreground = c.red }),
		rule("Operator", "keyword.operator", { foreground = c.blue }),
		rule(
			"Punctuation",
			"punctuation.separator, punctuation.terminator, punctuation.accessor, punctuation.section, meta.brace",
			{ foreground = c.fg_dark }
		),
		rule("Invalid", "invalid, invalid.illegal", { foreground = c.red, fontStyle = "underline" }),
		rule("Markup heading", "markup.heading, entity.name.section", { foreground = c.red, fontStyle = "bold" }),
		rule("Markup bold", "markup.bold", { fontStyle = "bold" }),
		rule("Markup italic", "markup.italic", { fontStyle = "italic" }),
		rule(
			"Markup link",
			"markup.underline.link, string.other.link",
			{ foreground = c.purple, fontStyle = "underline" }
		),
		rule("Markup code", "markup.raw, markup.raw.inline, markup.raw.block", { foreground = c.green }),
		rule("Markup list", "markup.list, punctuation.definition.list_item", { foreground = c.yellow }),
		rule("Markup quote", "markup.quote", { foreground = c.comment, fontStyle = "italic" }),
		rule("Diff inserted", "markup.inserted", { foreground = c.green }),
		rule("Diff deleted", "markup.deleted", { foreground = c.red }),
		rule("Diff changed", "markup.changed", { foreground = c.yellow }),
		rule("Diff header", "meta.diff.header, meta.diff.range, meta.diff.index", { foreground = c.cyan }),
	}

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
				<key>background</key>
				<string>${bg}</string>
				<key>foreground</key>
				<string>${fg}</string>
				<key>caret</key>
				<string>${yellow}</string>
				<key>selection</key>
				<string>${selection}</string>
				<key>lineHighlight</key>
				<string>${bg_light}</string>
				<key>gutter</key>
				<string>${bg}</string>
				<key>gutterForeground</key>
				<string>${fg_gutter_ui}</string>
				<key>findHighlight</key>
				<string>${search}</string>
				<key>findHighlightForeground</key>
				<string>${fg}</string>
				<key>invisibles</key>
				<string>${fg_gutter}</string>
			</dict>
		</dict>
]],
		c
	) .. table.concat(rules, "\n") .. [[

	</array>
</dict>
</plist>
]]
end

return M
