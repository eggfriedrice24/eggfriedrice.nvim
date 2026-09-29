---@module "eggfriedrice.extra.browser"
---@license MIT

-- Shared role map for browser chrome, used by the zen and chromium
-- extras so both browsers dress the same way. Not an extra itself.

local M = {}

---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "frame", "bg_dark" },
		{ "toolbar", "bg" },
		{ "toolbar_text", "fg" },
		{ "toolbar_icon", "fg_dark" },
		{ "tab_active", "bg_light" },
		{ "tab_active_text", "fg" },
		{ "tab_inactive_text", "comment" },
		{ "urlbar", "bg_light" },
		{ "urlbar_text", "fg" },
		{ "accent", "yellow" },
		{ "accent_hover", "yellow_bright" },
		{ "accent_text", "bg" },
		{ "hover", "selection" },
		{ "border", "fg_gutter" },
		{ "sidebar", "bg_dark" },
		{ "sidebar_text", "fg" },
		{ "popup", "bg_dark" },
		{ "popup_text", "fg" },
		{ "newtab", "bg" },
		{ "newtab_text", "fg" },
		{ "link", "purple" },
		{ "muted", "comment" },
		{ "success", "green" },
		{ "warning", "orange" },
		{ "error", "red" },
	}
end

return M
