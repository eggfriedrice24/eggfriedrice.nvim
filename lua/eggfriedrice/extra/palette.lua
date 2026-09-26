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
	{ "prompt_directory", "cyan" },
	{ "prompt_git_branch", "purple" },
	{ "prompt_git_clean", "green" },
	{ "prompt_git_dirty", "yellow" },
	{ "prompt_git_ahead", "cyan" },
	{ "prompt_git_behind", "orange" },
	{ "prompt_char_success", "yellow" },
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

local ansi = {
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

---Machine-readable palette for consumers outside Neovim: the design
---system's primitives, semantic tokens and ANSI slots, regenerated live.
---@param c table
---@return string
function M.generate(c)
	local slots = {}
	for _, k in ipairs(ansi) do
		slots[#slots + 1] = '    "' .. c[k] .. '"'
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
		"  ]",
		"}",
		"",
	}, "\n")
end

return M
