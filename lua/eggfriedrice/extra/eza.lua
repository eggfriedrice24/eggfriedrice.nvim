---@module "eggfriedrice.extra.eza"
---@license MIT

local M = {}

---Every key of eza's theme.yml. Directories are blue like operators,
---executables green, write bits yellow, anything broken red. The date
---column stays in the comment color so the signature yellow is not a
---whole column.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{
			"filekinds",
			{
				{ "normal", { fg = "fg" } },
				{ "directory", { fg = "blue", bold = true } },
				{ "symlink", { fg = "cyan" } },
				{ "pipe", { fg = "fg_dark" } },
				{ "block_device", { fg = "orange" } },
				{ "char_device", { fg = "orange" } },
				{ "socket", { fg = "purple" } },
				{ "special", { fg = "purple" } },
				{ "executable", { fg = "green" } },
				{ "mount_point", { fg = "cyan" } },
			},
		},
		{
			"perms",
			{
				{ "user_read", { fg = "fg" } },
				{ "user_write", { fg = "yellow" } },
				{ "user_execute_file", { fg = "green" } },
				{ "user_execute_other", { fg = "green" } },
				{ "group_read", { fg = "fg_dark" } },
				{ "group_write", { fg = "yellow" } },
				{ "group_execute", { fg = "green" } },
				{ "other_read", { fg = "comment" } },
				{ "other_write", { fg = "yellow" } },
				{ "other_execute", { fg = "green" } },
				{ "special_user_file", { fg = "purple" } },
				{ "special_other", { fg = "fg_gutter_ui" } },
				{ "attribute", { fg = "comment" } },
			},
		},
		{
			"size",
			{
				{ "major", { fg = "comment" } },
				{ "minor", { fg = "cyan" } },
				{ "number_byte", { fg = "fg" } },
				{ "number_kilo", { fg = "fg" } },
				{ "number_mega", { fg = "blue" } },
				{ "number_giga", { fg = "purple" } },
				{ "number_huge", { fg = "purple" } },
				{ "unit_byte", { fg = "comment" } },
				{ "unit_kilo", { fg = "blue" } },
				{ "unit_mega", { fg = "purple" } },
				{ "unit_giga", { fg = "purple" } },
				{ "unit_huge", { fg = "red" } },
			},
		},
		{
			"users",
			{
				{ "user_you", { fg = "fg" } },
				{ "user_root", { fg = "red" } },
				{ "user_other", { fg = "purple" } },
				{ "group_yours", { fg = "fg_dark" } },
				{ "group_other", { fg = "comment" } },
				{ "group_root", { fg = "red" } },
			},
		},
		{ "links", { { "normal", { fg = "cyan" } }, { "multi_link_file", { fg = "cyan_bright" } } } },
		{
			"git",
			{
				{ "new", { fg = "green" } },
				{ "modified", { fg = "yellow" } },
				{ "deleted", { fg = "red" } },
				{ "renamed", { fg = "cyan" } },
				{ "typechange", { fg = "purple" } },
				{ "ignored", { fg = "comment" } },
				{ "conflicted", { fg = "red_bright" } },
			},
		},
		{
			"git_repo",
			{
				{ "branch_main", { fg = "fg" } },
				{ "branch_other", { fg = "purple" } },
				{ "git_clean", { fg = "green" } },
				{ "git_dirty", { fg = "yellow" } },
			},
		},
		{
			"security_context",
			{
				{ "colon", { fg = "comment" } },
				{ "user", { fg = "fg_dark" } },
				{ "role", { fg = "purple" } },
				{ "typ", { fg = "fg_gutter_ui" } },
				{ "range", { fg = "purple" } },
			},
		},
		{
			"file_type",
			{
				{ "image", { fg = "yellow" } },
				{ "video", { fg = "red" } },
				{ "music", { fg = "green" } },
				{ "lossless", { fg = "cyan" } },
				{ "crypto", { fg = "fg_gutter_ui" } },
				{ "document", { fg = "fg" } },
				{ "compressed", { fg = "purple" } },
				{ "temp", { fg = "comment" } },
				{ "compiled", { fg = "blue" } },
				{ "build", { fg = "fg_gutter_ui" } },
				{ "source", { fg = "blue" } },
			},
		},
		{ "" },
		{ "punctuation", { fg = "fg_dark" } },
		{ "date", { fg = "comment" } },
		{ "inode", { fg = "comment" } },
		{ "blocks", { fg = "comment" } },
		{ "header", { fg = "fg_bright", bold = true } },
		{ "octal", { fg = "cyan" } },
		{ "flags", { fg = "purple" } },
		{ "" },
		{ "symlink_path", { fg = "cyan" } },
		{ "control_char", { fg = "red" } },
		{ "broken_symlink", { fg = "red" } },
		{ "broken_path_overlay", { fg = "fg_gutter_ui" } },
	}
end

---eza style map: {foreground: "#hex", is_bold: true}
---@param c table
---@param style table
---@return string
local function spec(c, style)
	local extra = require("eggfriedrice.extra")
	local parts = { ('foreground: "%s"'):format(extra.hex(c, style.fg)) }
	for _, flag in ipairs({ "bold", "italic", "underline" }) do
		if style[flag] then
			parts[#parts + 1] = "is_" .. flag .. ": true"
		end
	end
	return "{" .. table.concat(parts, ", ") .. "}"
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local lines = { "colourful: true", "" }
	for _, e in ipairs(M.roles(c)) do
		if e[1] == "" then
			lines[#lines + 1] = ""
		elseif extra.is_entries(e[2]) then
			lines[#lines + 1] = e[1] .. ":"
			for _, sub in ipairs(e[2]) do
				lines[#lines + 1] = ("  %s: %s"):format(sub[1], spec(c, sub[2]))
			end
			lines[#lines + 1] = ""
		else
			lines[#lines + 1] = ("%s: %s"):format(e[1], spec(c, e[2]))
		end
	end
	-- the section loop already leaves one blank line before the separator
	local out = table.concat(lines, "\n"):gsub("\n\n\n", "\n\n")
	return extra.header("eza") .. out .. "\n"
end

return M
