-- Regenerate assets/preview.svg from the palette. Run from anywhere:
--   nvim -l scripts/preview.lua
local script = debug.getinfo(1, "S").source:sub(2)
local root = vim.fn.fnamemodify(script, ":p:h:h")
vim.opt.runtimepath:prepend(root)

io.stdout:write(require("eggfriedrice.preview").write(root) .. "\n")
