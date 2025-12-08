# eggfriedrice

A dark Neovim colorscheme inspired by [Syntax FM](https://github.com/syntaxfm/vscode-theme) with warm orange accents and vibrant syntax highlighting.

## Features

- Dark theme with comfortable `#1a1a1a` background
- Treesitter support
- LSP semantic highlighting
- Popular plugin support (Telescope, nvim-tree, gitsigns, nvim-cmp, and more)

## Palette

| Color   | Hex       | Usage                        |
|---------|-----------|------------------------------|
| Orange  | `#fabf46` | Functions, accents           |
| Green   | `#cdff5c` | Strings                      |
| Cyan    | `#6dfff8` | Keywords, types, operators   |
| Red     | `#eb5757` | Control flow, errors         |
| Magenta | `#cf256d` | Constants, numbers, booleans |
| Rose    | `#fb7185` | Brackets, delimiters         |

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "eggfriedrice24/eggfriedrice.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("eggfriedrice")
  end,
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "eggfriedrice24/eggfriedrice.nvim",
  config = function()
    vim.cmd.colorscheme("eggfriedrice")
  end,
}
```

## Configuration

```lua
require("eggfriedrice").setup({
  transparent = false,    -- Enable transparent background
  italic_comments = true, -- Use italic for comments
  dim_inactive = false,   -- Dim inactive windows
})

vim.cmd.colorscheme("eggfriedrice")
```

## Supported Plugins

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [which-key.nvim](https://github.com/folke/which-key.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [noice.nvim](https://github.com/folke/noice.nvim)
- [flash.nvim](https://github.com/folke/flash.nvim)
- [mini.nvim](https://github.com/echasnovski/mini.nvim)

## License

MIT
