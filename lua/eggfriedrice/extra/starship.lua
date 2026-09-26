---@module "eggfriedrice.extra.starship"
---@license MIT

local M = {}

---One role per prompt module. The directory carries the signature
---yellow; the prompt character and dirty marker answer in cyan.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "directory", { fg = "yellow", bold = true } },
		{ "git_branch", { fg = "purple" } },
		{ "git_status_clean", { fg = "green" } },
		{ "git_status_dirty", { fg = "cyan" } },
		{ "git_status_ahead", { fg = "yellow" } },
		{ "git_status_behind", { fg = "orange" } },
		{ "git_status_conflicted", { fg = "red", bold = true } },
		{ "character_success", { fg = "cyan", bold = true } },
		{ "character_error", { fg = "red", bold = true } },
		{ "character_vimcmd", { fg = "purple", bold = true } },
		{ "cmd_duration", { fg = "orange" } },
		{ "language", { fg = "blue" } },
		{ "status", { fg = "red" } },
		{ "jobs", { fg = "yellow" } },
		{ "time", { fg = "comment" } },
		{ "username", { fg = "fg_dark" } },
		{ "hostname", { fg = "fg_dark" } },
	}
end

local base = { "bg", "bg_dark", "bg_light", "fg", "fg_dark", "comment" }
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
		"# [character]",
		('# success_symbol = "[❯](%s)"'):format(style("character_success")),
		('# error_symbol = "[❯](%s)"'):format(style("character_error")),
		('# vimcmd_symbol = "[❮](%s)"'):format(style("character_vimcmd")),
		"#",
		"# [directory]",
		('# style = "%s"'):format(style("directory")),
		"#",
		"# [git_branch]",
		('# style = "%s"'):format(style("git_branch")),
		"#",
		"# [git_status]",
		('# style = "%s"'):format(style("git_status_dirty")),
		('# up_to_date = "[✓](%s)"'):format(style("git_status_clean")),
		('# ahead = "[↑$count](%s)"'):format(style("git_status_ahead")),
		('# behind = "[↓$count](%s)"'):format(style("git_status_behind")),
		('# diverged = "[↕↑$ahead_count↓$behind_count](%s)"'):format(style("git_status_behind")),
		('# conflicted = "[=](%s)"'):format(style("git_status_conflicted")),
		"#",
		"# [cmd_duration]",
		('# style = "%s"'):format(style("cmd_duration")),
		"#",
		"# [nodejs]  # and python, golang, java, rust...",
		('# style = "%s"'):format(style("language")),
		"#",
		"# [status]",
		('# style = "%s"'):format(style("status")),
		"#",
		"# [jobs]",
		('# style = "%s"'):format(style("jobs")),
		"#",
		"# [time]",
		('# style = "%s"'):format(style("time")),
		"#",
		"# [username]",
		('# style = "%s"'):format(style("username")),
		"#",
		"# [hostname]",
		('# style = "%s"'):format(style("hostname")),
		"",
	})
	return extra.header("starship") .. table.concat(lines, "\n")
end

return M
