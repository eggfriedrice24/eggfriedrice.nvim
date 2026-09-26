---@module "eggfriedrice.extra.starship"
---@license MIT

local M = {}

---One role per prompt module and per git-status item. The directory
---carries the signature yellow; the prompt character and dirty markers
---answer in cyan.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "directory", { fg = "yellow", bold = true } },
		{ "directory_repo_root", { fg = "yellow", bold = true } },
		{ "directory_before_root", { fg = "comment" } },
		{ "directory_read_only", { fg = "red" } },
		{ "git_branch", { fg = "purple" } },
		{ "git_commit", { fg = "purple" } },
		{ "git_state", { fg = "orange", bold = true } },
		{ "git_status_clean", { fg = "green" } },
		{ "git_status_dirty", { fg = "cyan" } },
		{ "git_status_staged", { fg = "green" } },
		{ "git_status_untracked", { fg = "fg_dark" } },
		{ "git_status_stashed", { fg = "comment" } },
		{ "git_status_deleted", { fg = "red" } },
		{ "git_status_conflicted", { fg = "red", bold = true } },
		{ "git_status_ahead", { fg = "yellow" } },
		{ "git_status_behind", { fg = "orange" } },
		{ "git_metrics_added", { fg = "green" } },
		{ "git_metrics_deleted", { fg = "red" } },
		{ "character_success", { fg = "cyan", bold = true } },
		{ "character_error", { fg = "red", bold = true } },
		{ "character_vimcmd", { fg = "purple", bold = true } },
		{ "character_vimcmd_replace", { fg = "red", bold = true } },
		{ "character_vimcmd_visual", { fg = "yellow", bold = true } },
		{ "cmd_duration", { fg = "orange" } },
		{ "language", { fg = "blue" } },
		{ "docker_context", { fg = "blue" } },
		{ "status", { fg = "red" } },
		{ "jobs", { fg = "yellow" } },
		{ "time", { fg = "comment" } },
		{ "username", { fg = "fg_dark" } },
		{ "hostname", { fg = "fg_dark" } },
	}
end

local base = { "bg", "bg_dark", "bg_light", "fg", "fg_dark", "fg_gutter_ui", "comment" }
local accents = { "yellow", "orange", "red", "green", "cyan", "blue", "purple" }

---@param c table
---@return string
function M.generate(c)
	-- A palette only, never a prompt layout: the user keeps their format
	-- and swaps hexes for names. Redefining `red`, `green`... also retints
	-- any module that still uses the ANSI names.
	local extra = require("eggfriedrice.extra")
	local roles = M.roles(c)
	local function style(name)
		return (extra.role(roles, name).bold and "bold " or "") .. name
	end
	local lines = { 'palette = "eggfriedrice"', "", "[palettes.eggfriedrice]", "# base" }
	for _, k in ipairs(base) do
		lines[#lines + 1] = ('%s = "%s"'):format(k, c[k])
	end
	lines[#lines + 1] = ""
	lines[#lines + 1] = "# accents (these names shadow starship's ANSI names on purpose)"
	for _, k in ipairs(accents) do
		lines[#lines + 1] = ('%s = "%s"'):format(k, c[k])
	end
	lines[#lines + 1] = ""
	lines[#lines + 1] = "# roles, one per module"
	for _, e in ipairs(roles) do
		lines[#lines + 1] = ('%s = "%s"'):format(e[1], extra.hex(c, e[2].fg))
	end
	vim.list_extend(lines, {
		"",
		"# module styles that use them; merge into your own module tables",
		"# [directory]",
		('# style = "%s"'):format(style("directory")),
		('# repo_root_style = "%s"'):format(style("directory_repo_root")),
		('# before_repo_root_style = "%s"'):format(style("directory_before_root")),
		('# read_only_style = "%s"'):format(style("directory_read_only")),
		"#",
		"# [git_branch]",
		('# style = "%s"'):format(style("git_branch")),
		"#",
		"# [git_commit]",
		('# style = "%s"'):format(style("git_commit")),
		"#",
		"# [git_state]",
		('# style = "%s"'):format(style("git_state")),
		"#",
		"# [git_status]",
		('# conflicted = "[$count ](%s)"'):format(style("git_status_conflicted")),
		('# stashed = "[$count ](%s)"'):format(style("git_status_stashed")),
		('# deleted = "[$count ](%s)"'):format(style("git_status_deleted")),
		('# renamed = "[$count ](%s)"'):format(style("git_status_dirty")),
		('# modified = "[$count ](%s)"'):format(style("git_status_dirty")),
		('# staged = "[$count ](%s)"'):format(style("git_status_staged")),
		('# untracked = "[$count ](%s)"'):format(style("git_status_untracked")),
		('# ahead = "[$count ](%s)"'):format(style("git_status_ahead")),
		('# behind = "[$count ](%s)"'):format(style("git_status_behind")),
		('# diverged = "[$ahead_count ](%s)[$behind_count ](%s)"'):format(
			style("git_status_ahead"),
			style("git_status_behind")
		),
		('# up_to_date = "[✓](%s)"'):format(style("git_status_clean")),
		"#",
		"# [git_metrics]",
		('# added_style = "%s"'):format(style("git_metrics_added")),
		('# deleted_style = "%s"'):format(style("git_metrics_deleted")),
		"#",
		"# [nodejs]  # and python, golang, rust, java...",
		('# style = "%s"'):format(style("language")),
		"#",
		"# [docker_context]",
		('# style = "%s"'):format(style("docker_context")),
		"#",
		"# [cmd_duration]",
		('# style = "%s"'):format(style("cmd_duration")),
		"#",
		"# [status]",
		('# style = "%s"'):format(style("status")),
		"#",
		"# [jobs]",
		('# style = "%s"'):format(style("jobs")),
		"#",
		"# [character]",
		('# success_symbol = "[❯](%s)"'):format(style("character_success")),
		('# error_symbol = "[❯](%s)"'):format(style("character_error")),
		('# vimcmd_symbol = "[❮](%s)"'):format(style("character_vimcmd")),
		('# vimcmd_replace_symbol = "[❮](%s)"'):format(style("character_vimcmd_replace")),
		('# vimcmd_replace_one_symbol = "[❮](%s)"'):format(style("character_vimcmd_replace")),
		('# vimcmd_visual_symbol = "[❮](%s)"'):format(style("character_vimcmd_visual")),
		"#",
		"# [time]",
		('# style = "%s"'):format(style("time")),
		"#",
		"# [username]",
		('# style_user = "%s"'):format(style("username")),
		"#",
		"# [hostname]",
		('# style = "%s"'):format(style("hostname")),
		"",
	})
	return extra.header("starship") .. table.concat(lines, "\n")
end

return M
