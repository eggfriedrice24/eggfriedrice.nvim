---@module "eggfriedrice.extra.btop"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- Every key btop's bundled themes define. Gradients run cool to warm
	-- as load rises, so the signature yellow marks "getting busy".
	return require("eggfriedrice.extra").header("btop")
		.. util.template(
			[[
theme[main_bg]="${bg}"
theme[main_fg]="${fg}"
theme[title]="${fg}"
theme[hi_fg]="${yellow}"
theme[selected_bg]="${selection}"
theme[selected_fg]="${yellow}"
theme[inactive_fg]="${fg_gutter}"
theme[graph_text]="${comment}"
theme[meter_bg]="${bg_light}"
theme[proc_misc]="${cyan}"
theme[cpu_box]="${fg_gutter_ui}"
theme[mem_box]="${fg_gutter_ui}"
theme[net_box]="${fg_gutter_ui}"
theme[proc_box]="${fg_gutter_ui}"
theme[div_line]="${fg_gutter}"
theme[temp_start]="${green}"
theme[temp_mid]="${yellow}"
theme[temp_end]="${red}"
theme[cpu_start]="${green}"
theme[cpu_mid]="${yellow}"
theme[cpu_end]="${red}"
theme[free_start]="${cyan}"
theme[free_mid]="${blue}"
theme[free_end]="${purple}"
theme[cached_start]="${blue}"
theme[cached_mid]="${purple}"
theme[cached_end]="${purple_bright}"
theme[available_start]="${green}"
theme[available_mid]="${green_bright}"
theme[available_end]="${cyan}"
theme[used_start]="${yellow}"
theme[used_mid]="${orange}"
theme[used_end]="${red}"
theme[download_start]="${cyan}"
theme[download_mid]="${blue}"
theme[download_end]="${purple}"
theme[upload_start]="${green}"
theme[upload_mid]="${yellow}"
theme[upload_end]="${orange}"
theme[process_start]="${green}"
theme[process_mid]="${yellow}"
theme[process_end]="${red}"
theme[proc_pause_bg]="${bg_light}"
theme[proc_follow_bg]="${search}"
theme[proc_banner_fg]="${bg}"
theme[proc_banner_bg]="${yellow}"
theme[followed_fg]="${bg}"
theme[followed_bg]="${search_selected}"
]],
			c
		)
end

return M
