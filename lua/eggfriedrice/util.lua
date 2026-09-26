---@module "eggfriedrice.util"
---@author eggfriedrice24
---@license MIT

local M = {}

---@param hex string "#rrggbb"
---@return integer r, integer g, integer b
local function rgb(hex)
	return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
end

---Blend `fg` over `bg` with opacity `alpha` (0 = pure bg, 1 = pure fg).
---@param fg string
---@param bg string
---@param alpha number
---@return string
function M.blend(fg, bg, alpha)
	local fr, fg_, fb = rgb(fg)
	local br, bg_, bb = rgb(bg)
	local function channel(f, b)
		return string.format("%02x", math.floor(f * alpha + b * (1 - alpha) + 0.5))
	end
	return "#" .. channel(fr, br) .. channel(fg_, bg_) .. channel(fb, bb)
end

---Substitute `${key}` and `${key.sub}` placeholders from a nested table.
---Unknown keys raise, so a template can never silently emit a literal
---placeholder into a generated file.
---@param str string
---@param values table
---@return string
function M.template(str, values)
	return (
		str:gsub("%${([%w_%.]+)}", function(path)
			local v = values
			for part in path:gmatch("[^%.]+") do
				v = type(v) == "table" and v[part] or nil
			end
			if v == nil then
				error(("template: unknown key '%s'"):format(path))
			end
			return tostring(v)
		end)
	)
end

---Apply a table of highlight groups.
---@param groups table<string, vim.api.keyset.highlight>
function M.apply(groups)
	for name, spec in pairs(groups) do
		vim.api.nvim_set_hl(0, name, spec)
	end
end

return M
