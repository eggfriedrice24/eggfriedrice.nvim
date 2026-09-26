-- Regenerate extras/ from the palette. Run from anywhere:
--   nvim -l scripts/extras.lua
local script = debug.getinfo(1, "S").source:sub(2)
local root = vim.fn.fnamemodify(script, ":p:h:h")
vim.opt.runtimepath:prepend(root)

for _, path in ipairs(require("eggfriedrice.extra").generate(root)) do
	io.stdout:write(path .. "\n")
end
