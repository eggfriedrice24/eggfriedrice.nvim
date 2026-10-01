---@module "eggfriedrice.extra.frameit"
---@license MIT

local M = {}

---The selection rectangle: a translucent yolk fill under a solid yolk
---border, so the highlight reads as the signature color on any content.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "fill", "yellow" },
		{ "fill_alpha", 0.2 },
		{ "border", "yellow" },
	}
end

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local roles = M.roles(c)
	local fill = extra.hex(c, extra.role(roles, "fill"))
	local alpha = ("%02x"):format(math.floor(extra.role(roles, "fill_alpha") * 255 + 0.5))
	return extra.header("frameit")
		.. ('fill = "%s%s"\n'):format(fill, alpha)
		.. ('border = "%s"\n'):format(extra.hex(c, extra.role(roles, "border")))
end

return M
