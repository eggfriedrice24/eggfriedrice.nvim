---@module "eggfriedrice.extra.palette"
---@license MIT

local M = {}

-- Fixed key order so regenerating never reorders the file.
local primitives = {
	"bg_dark",
	"bg",
	"bg_light",
	"selection",
	"fg_gutter",
	"fg_gutter_ui",
	"border",
	"fg",
	"fg_dark",
	"fg_bright",
	"comment",
	"yellow",
	"orange",
	"green",
	"cyan",
	"blue",
	"purple",
	"red",
	"red_bright",
	"green_bright",
	"yellow_bright",
	"blue_bright",
	"purple_bright",
	"cyan_bright",
}

local semantic = {
	"error",
	"warning",
	"info",
	"hint",
	"git_add",
	"git_change",
	"git_delete",
	"search",
	"search_selected",
	"scope",
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

---@param keys string[]
---@param c table
---@param indent string
---@return string
local function object(keys, c, indent)
	local lines = {}
	for _, k in ipairs(keys) do
		lines[#lines + 1] = ('%s"%s": "%s"'):format(indent, k, assert(c[k], k))
	end
	return table.concat(lines, ",\n")
end

---Machine-readable palette for consumers outside Neovim, in the shape of
---the design-system export: primitives, semantic aliases, ANSI slots.
---@param c table
---@return string
function M.generate(c)
	local diff = {}
	for _, k in ipairs({ "add", "change", "delete", "text" }) do
		diff[#diff + 1] = ('      "%s": "%s"'):format(k, c.diff[k])
	end
	local slots = {}
	for _, k in ipairs(ansi) do
		slots[#slots + 1] = '    "' .. c[k] .. '"'
	end
	return table.concat({
		"{",
		'  "name": "eggfriedrice",',
		'  "primitives": {',
		object(primitives, c, "    "),
		"  },",
		'  "semantic": {',
		object(semantic, c, "    ") .. ",",
		'    "diff": {',
		table.concat(diff, ",\n"),
		"    }",
		"  },",
		'  "ansi": [',
		table.concat(slots, ",\n"),
		"  ]",
		"}",
		"",
	}, "\n")
end

return M
