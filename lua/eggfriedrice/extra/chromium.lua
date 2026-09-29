---@module "eggfriedrice.extra.chromium"
---@license MIT

local M = {}

---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	return require("eggfriedrice.extra.browser").roles(c)
end

-- Manifest theme color keys and the browser role each takes. Chromium
-- reads colors as [r, g, b] triples.
local colors = {
	{ "frame", "frame" },
	{ "frame_inactive", "frame" },
	{ "frame_incognito", "frame" },
	{ "frame_incognito_inactive", "frame" },
	{ "background_tab", "frame" },
	{ "background_tab_inactive", "frame" },
	{ "background_tab_incognito", "frame" },
	{ "background_tab_incognito_inactive", "frame" },
	{ "toolbar", "toolbar" },
	{ "toolbar_text", "toolbar_text" },
	{ "toolbar_button_icon", "toolbar_icon" },
	{ "bookmark_text", "toolbar_text" },
	{ "tab_text", "tab_active_text" },
	{ "tab_background_text", "tab_inactive_text" },
	{ "tab_background_text_inactive", "tab_inactive_text" },
	{ "tab_background_text_incognito", "tab_inactive_text" },
	{ "tab_background_text_incognito_inactive", "tab_inactive_text" },
	{ "omnibox_background", "urlbar" },
	{ "omnibox_text", "urlbar_text" },
	{ "button_background", "tab_active" },
	{ "ntp_background", "newtab" },
	{ "ntp_text", "newtab_text" },
	{ "ntp_header", "newtab_text" },
	{ "ntp_link", "link" },
}

---`[r, g, b]` for a hex color.
---@param hex string
---@return string
local function triple(hex)
	return ("[%d, %d, %d]"):format(
		tonumber(hex:sub(2, 3), 16),
		tonumber(hex:sub(4, 5), 16),
		tonumber(hex:sub(6, 7), 16)
	)
end

---@param c table
---@return string
function M.generate(c)
	-- An unpacked extension: the extras/chromium folder itself is what
	-- "Load unpacked" takes, so the file must be named manifest.json.
	local extra = require("eggfriedrice.extra")
	local roles = M.roles(c)
	local lines = {}
	for _, entry in ipairs(colors) do
		lines[#lines + 1] = ('      "%s": %s'):format(entry[1], triple(extra.hex(c, extra.role(roles, entry[2]))))
	end
	return table.concat({
		"{",
		'  "manifest_version": 3,',
		'  "name": "eggfriedrice",',
		'  "version": "1.0.0",',
		'  "description": "Yolk-yellow accents, rice-cream text and navy chrome. Generated from eggfriedrice.nvim by make extras; do not edit by hand.",',
		'  "theme": {',
		'    "colors": {',
		table.concat(lines, ",\n"),
		"    }",
		"  }",
		"}",
		"",
	}, "\n")
end

return M
