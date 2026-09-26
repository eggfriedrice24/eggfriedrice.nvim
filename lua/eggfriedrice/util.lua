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

local function srgb_to_linear(c)
	c = c / 255
	return c <= 0.04045 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
end

local function linear_to_srgb(c)
	c = math.max(0, math.min(1, c))
	c = c <= 0.0031308 and c * 12.92 or 1.055 * c ^ (1 / 2.4) - 0.055
	return math.floor(c * 255 + 0.5)
end

---@param hex string
---@return number L, number a, number b
local function to_oklab(hex)
	local r, g, b = rgb(hex)
	r, g, b = srgb_to_linear(r), srgb_to_linear(g), srgb_to_linear(b)
	local l = (0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b) ^ (1 / 3)
	local m = (0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b) ^ (1 / 3)
	local s = (0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b) ^ (1 / 3)
	return 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
		1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
		0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s
end

---@param L number
---@param a number
---@param b number
---@return string hex
local function from_oklab(L, a, b)
	local l = (L + 0.3963377774 * a + 0.2158037573 * b) ^ 3
	local m = (L - 0.1055613458 * a - 0.0638541728 * b) ^ 3
	local s = (L - 0.0894841775 * a - 1.2914855480 * b) ^ 3
	return string.format(
		"#%02x%02x%02x",
		linear_to_srgb(4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s),
		linear_to_srgb(-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s),
		linear_to_srgb(-0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s)
	)
end

---A color at OKLCH lightness `L` and chroma `C` in the hue of `hex`.
---Used for backgrounds that must read as one family across accents:
---same darkness, same intensity, only the hue changes.
---@param hex string
---@param L number 0..1
---@param C number 0..0.4
---@return string
function M.tint(hex, L, C)
	local _, a, b = to_oklab(hex)
	local h = math.atan2(b, a)
	return from_oklab(L, C * math.cos(h), C * math.sin(h))
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

---CSS `rgba(r, g, b, a)` for a hex color at opacity `alpha`.
---@param hex string
---@param alpha number 0..1
---@return string
function M.rgba(hex, alpha)
	local r, g, b = rgb(hex)
	return ("rgba(%d, %d, %d, %s)"):format(r, g, b, alpha)
end

---Apply a table of highlight groups.
---@param groups table<string, vim.api.keyset.highlight>
function M.apply(groups)
	for name, spec in pairs(groups) do
		vim.api.nvim_set_hl(0, name, spec)
	end
end

return M
