---@module "eggfriedrice.extra.tmux"
---@license MIT

local M = {}

---Styles only, no status layout. A style role becomes `<name>-style`;
---a plain color role becomes the option of the same name; the indicator
---is a comment, since it belongs inside the user's format string.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "status", { fg = "fg_dark", bg = "bg_dark" } },
		{ "status_left", { fg = "bg", bg = "yellow", bold = true } },
		{ "status_right", { fg = "comment", bg = "bg_dark" } },
		{ "" },
		{ "window_status", { fg = "comment", bg = "bg_dark" } },
		{ "window_status_current", { fg = "fg", bg = "bg", bold = true } },
		{ "window_status_activity", { fg = "orange", bg = "bg_dark" } },
		{ "window_status_bell", { fg = "bg", bg = "yellow", bold = true } },
		{ "" },
		{ "window", { bg = "bg_dark" } },
		{ "window_active", { bg = "bg" } },
		{ "pane_border", { fg = "fg_gutter_ui" } },
		{ "pane_active_border", { fg = "border" } },
		{ "" },
		{ "window_status_current_indicator", { fg = "yellow" } },
		{ "" },
		{ "message", { fg = "fg", bg = "bg_light" } },
		{ "message_command", { fg = "yellow", bg = "bg_light" } },
		{ "mode", { fg = "fg", bg = "selection" } },
		{ "copy_mode_match", { fg = "fg", bg = "search" } },
		{ "copy_mode_current_match", { fg = "bg", bg = "search_selected" } },
		{ "" },
		{ "popup", { fg = "fg", bg = "bg_dark" } },
		{ "popup_border", { fg = "border" } },
		{ "" },
		{ "clock_mode_colour", "yellow" },
		{ "display_panes_colour", "fg_gutter_ui" },
		{ "display_panes_active_colour", "yellow" },
	}
end

---tmux style string: fg=..,bg=..,bold
---@param c table
---@param style table
---@return string
local function spec(c, style)
	local extra = require("eggfriedrice.extra")
	local parts = {}
	if style.fg then
		parts[#parts + 1] = "fg=" .. extra.hex(c, style.fg)
	end
	if style.bg then
		parts[#parts + 1] = "bg=" .. extra.hex(c, style.bg)
	end
	if style.bold then
		parts[#parts + 1] = "bold"
	end
	return table.concat(parts, ",")
end

---@param c table
---@return string
function M.generate(c)
	-- The palette is also exported as user options so a status format can
	-- say #[fg=#{@eggfriedrice_yellow}].
	local extra = require("eggfriedrice.extra")
	local lines = {}
	for _, color in ipairs(extra.colors(c)) do
		lines[#lines + 1] = ('set -g @eggfriedrice_%s "%s"'):format(color[1], color[2])
	end
	lines[#lines + 1] = ""
	for _, e in ipairs(M.roles(c)) do
		local name, v = e[1]:gsub("_", "-"), e[2]
		if e[1] == "" then
			lines[#lines + 1] = ""
		elseif e[1] == "window_status_current_indicator" then
			lines[#lines + 1] = ("# current-window indicator, for your window-status-current-format: #[fg=%s]"):format(
				extra.hex(c, v.fg)
			)
		elseif extra.is_style(v) then
			lines[#lines + 1] = ('set -g %s-style "%s"'):format(name, spec(c, v))
		else
			lines[#lines + 1] = ('set -g %s "%s"'):format(name, extra.hex(c, v))
		end
	end
	lines[#lines + 1] = ""
	return extra.header("tmux") .. table.concat(lines, "\n")
end

return M
