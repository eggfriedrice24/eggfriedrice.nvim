---@module "eggfriedrice.extra.palette"
---@license MIT

local M = {}

-- Ordered so regenerating never reorders the file. Names and order
-- follow the design-system export, so the two can be diffed directly.

---@type { [1]: string, [2]: string }[] name, palette key (dotted for nested)
local primitives = {
	{ "bg_dark", "bg_dark" },
	{ "bg", "bg" },
	{ "bg_light", "bg_light" },
	{ "selection", "selection" },
	{ "fg_gutter", "fg_gutter" },
	{ "border", "border" },
	{ "fg", "fg" },
	{ "fg_dark", "fg_dark" },
	{ "comment", "comment" },
	{ "yellow", "yellow" },
	{ "red", "red" },
	{ "purple", "purple" },
	{ "green", "green" },
	{ "blue", "blue" },
	{ "cyan", "cyan" },
	{ "orange", "orange" },
	{ "fg_gutter_ui", "fg_gutter_ui" },
	{ "red_bright", "red_bright" },
	{ "green_bright", "green_bright" },
	{ "yellow_bright", "yellow_bright" },
	{ "blue_bright", "blue_bright" },
	{ "purple_bright", "purple_bright" },
	{ "cyan_bright", "cyan_bright" },
	{ "fg_bright", "fg_bright" },
	{ "search_match", "search" },
	{ "search_selected", "search_selected" },
	{ "diff_add", "diff.add" },
	{ "diff_change", "diff.change" },
	{ "diff_delete", "diff.delete" },
	{ "diff_text", "diff.text" },
}

---@type { [1]: string, [2]: string }[]
local semantic = {
	{ "text_primary", "fg" },
	{ "text_muted", "fg_dark" },
	{ "text_subtle", "comment" },
	{ "text_bright", "fg_bright" },
	{ "text_on_accent", "bg" },
	{ "text_line_number", "fg_gutter_ui" },
	{ "text_decorative", "fg_gutter" },
	{ "surface_0", "bg_dark" },
	{ "surface_1", "bg" },
	{ "surface_2", "bg_light" },
	{ "accent_primary", "yellow" },
	{ "accent_ui", "cyan" },
	{ "state_success", "green" },
	{ "state_warning", "yellow" },
	{ "state_error", "red" },
	{ "state_info", "cyan" },
	{ "state_hint", "green" },
	{ "focus", "yellow" },
	{ "selection_bg", "selection" },
	{ "selection_fg", "fg" },
	{ "search_match_bg", "search" },
	{ "search_match_fg", "fg" },
	{ "search_selected_bg", "search_selected" },
	{ "search_selected_fg", "bg" },
	{ "border_default", "fg_gutter_ui" },
	{ "border_accent", "border" },
	{ "link", "purple" },
	{ "git_add", "git_add" },
	{ "git_change", "git_change" },
	{ "git_delete", "git_delete" },
	{ "diff_add_bg", "diff.add" },
	{ "diff_change_bg", "diff.change" },
	{ "diff_delete_bg", "diff.delete" },
	{ "diff_text_bg", "diff.text" },
	{ "code_keyword", "purple" },
	{ "code_function", "yellow" },
	{ "code_type", "yellow" },
	{ "code_constant", "yellow" },
	{ "code_string", "green" },
	{ "code_variable", "red" },
	{ "code_operator", "blue" },
	{ "code_escape", "cyan" },
	{ "code_decorator", "purple" },
	{ "code_punctuation", "fg_dark" },
	{ "code_comment", "comment" },
	{ "term_cursor", "yellow" },
	{ "term_cursor_text", "bg" },
	{ "term_selection_bg", "selection" },
	{ "term_selection_fg", "fg" },
	{ "term_search_match_bg", "search" },
	{ "term_search_match_fg", "fg" },
	{ "term_search_selected_bg", "search_selected" },
	{ "term_search_selected_fg", "bg" },
	{ "term_split_divider", "fg_gutter_ui" },
	{ "term_pane_inactive_fill", "bg_dark" },
	{ "term_tab_active_bg", "bg" },
	{ "term_tab_active_fg", "fg" },
	{ "term_tab_active_indicator", "yellow" },
	{ "term_tab_inactive_bg", "bg_dark" },
	{ "term_tab_inactive_fg", "comment" },
	{ "term_tab_hover_bg", "bg_light" },
	{ "term_tab_hover_fg", "fg" },
	{ "term_badge_bg", "yellow" },
	{ "term_badge_fg", "bg" },
	{ "term_link", "purple" },
	{ "prompt_directory", "yellow" },
	{ "prompt_git_branch", "purple" },
	{ "prompt_git_clean", "green" },
	{ "prompt_git_dirty", "cyan" },
	{ "prompt_git_ahead", "yellow" },
	{ "prompt_git_behind", "orange" },
	{ "prompt_char_success", "cyan" },
	{ "prompt_char_error", "red" },
	{ "prompt_duration", "orange" },
	{ "prompt_lang_badge", "blue" },
	{ "prompt_ghost", "comment" },
	{ "fzf_fg", "fg" },
	{ "fzf_fg_plus", "fg" },
	{ "fzf_bg", "bg" },
	{ "fzf_bg_plus", "bg_light" },
	{ "fzf_hl", "yellow" },
	{ "fzf_hl_plus", "yellow" },
	{ "fzf_info", "comment" },
	{ "fzf_prompt", "yellow" },
	{ "fzf_pointer", "yellow" },
	{ "fzf_marker", "green" },
	{ "fzf_spinner", "cyan" },
	{ "fzf_border", "fg_gutter_ui" },
	{ "fzf_header", "cyan" },
	{ "sh_command", "yellow" },
	{ "sh_builtin", "yellow" },
	{ "sh_alias", "yellow" },
	{ "sh_function", "yellow" },
	{ "sh_path", "fg" },
	{ "sh_option", "cyan" },
	{ "sh_string", "green" },
	{ "sh_variable", "red" },
	{ "sh_comment", "comment" },
	{ "sh_unknown", "red" },
	{ "sh_redirection", "blue" },
	{ "sh_reserved_word", "purple" },
}

---Palette keys of ANSI slots 0 to 15, in order. The preview reads this
---list so its swatches match the JSON.
---@type string[]
M.ansi = {
	"bg_light",
	"red",
	"green",
	"yellow",
	"blue",
	"purple",
	"cyan",
	"fg",
	"comment",
	"red_bright",
	"green_bright",
	"yellow_bright",
	"blue_bright",
	"purple_bright",
	"cyan_bright",
	"fg_bright",
}

-- Extras whose role maps become the `apps` section, in this order.
local apps = {
	"ghostty",
	"fzf",
	"starship",
	"zsh",
	"tmux",
	"lazygit",
	"bat",
	"hyprland",
	"gtk",
	"rofi",
	"dunst",
	"btop",
	"eza",
	"opencode",
	"slack",
	"discord",
}

---@param c table
---@param path string dotted palette key
---@return string
local function lookup(c, path)
	local v = c
	for part in path:gmatch("[^%.]+") do
		v = v[part]
	end
	return assert(v, path)
end

---@param entries { [1]: string, [2]: string }[]
---@param c table
---@return string
local function object(entries, c)
	local lines = {}
	for _, e in ipairs(entries) do
		lines[#lines + 1] = ('    "%s": "%s"'):format(e[1], lookup(c, e[2]))
	end
	return table.concat(lines, ",\n")
end

---JSON key spelling: snake_case whatever the app itself calls the role.
---@param name string
---@return string
local function key(name)
	return (name:gsub("%-", "_"):gsub("(%l)(%u)", function(a, b)
		return a .. "_" .. b:lower()
	end))
end

---Encode a role value as JSON with palette keys resolved to hex.
---@param c table
---@param v any
---@param indent string
---@return string
local function encode(c, v, indent)
	local extra = require("eggfriedrice.extra")
	local inner = indent .. "  "
	if extra.is_entries(v) then
		local lines = {}
		for _, e in ipairs(v) do
			if e[1] ~= "" then
				lines[#lines + 1] = ('%s"%s": %s'):format(inner, key(e[1]), encode(c, e[2], inner))
			end
		end
		return "{\n" .. table.concat(lines, ",\n") .. "\n" .. indent .. "}"
	elseif extra.is_style(v) then
		local lines = {}
		for _, slot in ipairs({ "fg", "bg" }) do
			if v[slot] then
				lines[#lines + 1] = ('%s"%s": "%s"'):format(inner, slot, extra.hex(c, v[slot]))
			end
		end
		for _, flag in ipairs({ "bold", "italic", "underline" }) do
			if v[flag] then
				lines[#lines + 1] = ('%s"%s": true'):format(inner, flag)
			end
		end
		return "{\n" .. table.concat(lines, ",\n") .. "\n" .. indent .. "}"
	elseif type(v) == "table" then
		local items = {}
		for _, k in ipairs(v) do
			items[#items + 1] = ('%s"%s"'):format(inner, extra.hex(c, k))
		end
		return "[\n" .. table.concat(items, ",\n") .. "\n" .. indent .. "]"
	elseif type(v) == "boolean" or type(v) == "number" then
		return tostring(v)
	end
	return ('"%s"'):format(extra.hex(c, v))
end

---Machine-readable palette for consumers outside Neovim: the design
---system's primitives, semantic tokens, ANSI slots and per-app role
---maps, regenerated live from the same data the extras render from.
---@param c table
---@return string
function M.generate(c)
	local slots = {}
	for _, k in ipairs(M.ansi) do
		slots[#slots + 1] = '    "' .. c[k] .. '"'
	end
	local sections = {}
	for _, name in ipairs(apps) do
		local mod = require("eggfriedrice.extra." .. name)
		sections[#sections + 1] = ('    "%s": %s'):format(mod.app or name, encode(c, mod.roles(c), "    "))
	end
	return table.concat({
		"{",
		'  "name": "eggfriedrice",',
		'  "primitives": {',
		object(primitives, c),
		"  },",
		'  "semantic": {',
		object(semantic, c),
		"  },",
		'  "ansi": [',
		table.concat(slots, ",\n"),
		"  ],",
		'  "apps": {',
		table.concat(sections, ",\n"),
		"  }",
		"}",
		"",
	}, "\n")
end

return M
