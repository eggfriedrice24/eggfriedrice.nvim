---@module "eggfriedrice.extra.btop"
---@license MIT

local M = {}

---Every key btop's bundled themes define. Gradients run cool to warm as
---load rises, so the signature yellow marks "getting busy".
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "main_bg", "bg" },
		{ "main_fg", "fg" },
		{ "title", "fg" },
		{ "hi_fg", "yellow" },
		{ "selected_bg", "selection" },
		{ "selected_fg", "yellow" },
		{ "inactive_fg", "fg_gutter" },
		{ "graph_text", "comment" },
		{ "meter_bg", "bg_light" },
		{ "proc_misc", "cyan" },
		{ "cpu_box", "fg_gutter_ui" },
		{ "mem_box", "fg_gutter_ui" },
		{ "net_box", "fg_gutter_ui" },
		{ "proc_box", "fg_gutter_ui" },
		{ "div_line", "fg_gutter" },
		{ "temp_start", "green" },
		{ "temp_mid", "yellow" },
		{ "temp_end", "red" },
		{ "cpu_start", "green" },
		{ "cpu_mid", "yellow" },
		{ "cpu_end", "red" },
		{ "free_start", "cyan" },
		{ "free_mid", "blue" },
		{ "free_end", "purple" },
		{ "cached_start", "blue" },
		{ "cached_mid", "purple" },
		{ "cached_end", "purple_bright" },
		{ "available_start", "green" },
		{ "available_mid", "green_bright" },
		{ "available_end", "cyan" },
		{ "used_start", "yellow" },
		{ "used_mid", "orange" },
		{ "used_end", "red" },
		{ "download_start", "cyan" },
		{ "download_mid", "blue" },
		{ "download_end", "purple" },
		{ "upload_start", "green" },
		{ "upload_mid", "yellow" },
		{ "upload_end", "orange" },
		{ "process_start", "green" },
		{ "process_mid", "yellow" },
		{ "process_end", "red" },
		{ "proc_pause_bg", "bg_light" },
		{ "proc_follow_bg", "search" },
		{ "proc_banner_fg", "bg" },
		{ "proc_banner_bg", "yellow" },
		{ "followed_fg", "bg" },
		{ "followed_bg", "search_selected" },
	}
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local lines = {}
	for _, e in ipairs(M.roles(c)) do
		lines[#lines + 1] = ('theme[%s]="%s"'):format(e[1], extra.hex(c, e[2]))
	end
	lines[#lines + 1] = ""
	return extra.header("btop") .. table.concat(lines, "\n")
end

return M
