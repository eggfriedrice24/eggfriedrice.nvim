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

---Apply a table of highlight groups.
---@param groups table<string, vim.api.keyset.highlight>
function M.apply(groups)
	for name, spec in pairs(groups) do
		vim.api.nvim_set_hl(0, name, spec)
	end
end

return M
