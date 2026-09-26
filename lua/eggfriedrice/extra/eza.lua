---@module "eggfriedrice.extra.eza"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return string
function M.generate(c)
	-- Every key of eza's theme.yml. Directories are blue like operators,
	-- executables green, write bits yellow, anything broken red. The date
	-- column stays in the comment color so the signature yellow is not a
	-- whole column.
	return require("eggfriedrice.extra").header("eza")
		.. util.template(
			[[
colourful: true

filekinds:
  normal: {foreground: "${fg}"}
  directory: {foreground: "${blue}", is_bold: true}
  symlink: {foreground: "${cyan}"}
  pipe: {foreground: "${fg_dark}"}
  block_device: {foreground: "${orange}"}
  char_device: {foreground: "${orange}"}
  socket: {foreground: "${purple}"}
  special: {foreground: "${purple}"}
  executable: {foreground: "${green}"}
  mount_point: {foreground: "${cyan}"}

perms:
  user_read: {foreground: "${fg}"}
  user_write: {foreground: "${yellow}"}
  user_execute_file: {foreground: "${green}"}
  user_execute_other: {foreground: "${green}"}
  group_read: {foreground: "${fg_dark}"}
  group_write: {foreground: "${yellow}"}
  group_execute: {foreground: "${green}"}
  other_read: {foreground: "${comment}"}
  other_write: {foreground: "${yellow}"}
  other_execute: {foreground: "${green}"}
  special_user_file: {foreground: "${purple}"}
  special_other: {foreground: "${fg_gutter_ui}"}
  attribute: {foreground: "${comment}"}

size:
  major: {foreground: "${comment}"}
  minor: {foreground: "${cyan}"}
  number_byte: {foreground: "${fg}"}
  number_kilo: {foreground: "${fg}"}
  number_mega: {foreground: "${blue}"}
  number_giga: {foreground: "${purple}"}
  number_huge: {foreground: "${purple}"}
  unit_byte: {foreground: "${comment}"}
  unit_kilo: {foreground: "${blue}"}
  unit_mega: {foreground: "${purple}"}
  unit_giga: {foreground: "${purple}"}
  unit_huge: {foreground: "${red}"}

users:
  user_you: {foreground: "${fg}"}
  user_root: {foreground: "${red}"}
  user_other: {foreground: "${purple}"}
  group_yours: {foreground: "${fg_dark}"}
  group_other: {foreground: "${comment}"}
  group_root: {foreground: "${red}"}

links:
  normal: {foreground: "${cyan}"}
  multi_link_file: {foreground: "${cyan_bright}"}

git:
  new: {foreground: "${green}"}
  modified: {foreground: "${yellow}"}
  deleted: {foreground: "${red}"}
  renamed: {foreground: "${cyan}"}
  typechange: {foreground: "${purple}"}
  ignored: {foreground: "${comment}"}
  conflicted: {foreground: "${red_bright}"}

git_repo:
  branch_main: {foreground: "${fg}"}
  branch_other: {foreground: "${purple}"}
  git_clean: {foreground: "${green}"}
  git_dirty: {foreground: "${yellow}"}

security_context:
  colon: {foreground: "${comment}"}
  user: {foreground: "${fg_dark}"}
  role: {foreground: "${purple}"}
  typ: {foreground: "${fg_gutter_ui}"}
  range: {foreground: "${purple}"}

file_type:
  image: {foreground: "${yellow}"}
  video: {foreground: "${red}"}
  music: {foreground: "${green}"}
  lossless: {foreground: "${cyan}"}
  crypto: {foreground: "${fg_gutter_ui}"}
  document: {foreground: "${fg}"}
  compressed: {foreground: "${purple}"}
  temp: {foreground: "${comment}"}
  compiled: {foreground: "${blue}"}
  build: {foreground: "${fg_gutter_ui}"}
  source: {foreground: "${blue}"}

punctuation: {foreground: "${fg_dark}"}
date: {foreground: "${comment}"}
inode: {foreground: "${comment}"}
blocks: {foreground: "${comment}"}
header: {foreground: "${fg_bright}", is_bold: true}
octal: {foreground: "${cyan}"}
flags: {foreground: "${purple}"}

symlink_path: {foreground: "${cyan}"}
control_char: {foreground: "${red}"}
broken_symlink: {foreground: "${red}"}
broken_path_overlay: {foreground: "${fg_gutter_ui}"}
]],
			c
		)
end

return M
