# eggfriedrice

A dark, warm Neovim colorscheme that leans into its name: yolk-yellow keywords, rice-cream text, scallion-green strings, and one cool teal accent for types. Yellow is the signature and it is used for exactly one thing - keywords - so everything else stays readable.

![preview](assets/preview.svg)

## Palette

| Role | Color | Hex |
| ------------------------------ | ------------ | --------- |
| Keywords (the signature) | Yolk yellow | `#f2c94c` |
| Functions, annotations | Orange | `#ffae57` |
| Strings | Scallion | `#a5d65f` |
| Types, classes, tags | Teal | `#7fd8ce` |
| Numbers, constants, escapes | Rose | `#ffa1ad` |
| Errors, deletions | Red | `#eb5757` |
| Text | Rice cream | `#d8d3c3` |
| Punctuation, operators | Muted | `#a8a396` |
| Comments | Warm gray | `#7a7568` |
| Background | Near black | `#1a1a1a` |

Diff, search, and diagnostic backgrounds are blended from these at load time, so overriding a palette color carries through everywhere.

## Features

- Consistent token roles across legacy syntax, treesitter, and LSP semantic tokens - tuned against TypeScript, JavaScript, Go, Rust, Java, and Python
- Terminal colors (`:terminal` matches the theme)
- Bundled lualine theme
- `on_colors` / `on_highlights` hooks for overriding anything
- Popular plugin support (Telescope, neo-tree, gitsigns, nvim-cmp, and more)

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

Call `setup()` before `colorscheme` (only needed if you change defaults):

```lua
require("eggfriedrice").setup({
  transparent = false,    -- transparent background
  italic_comments = true, -- italic comments
  dim_inactive = false,   -- dim inactive windows

  -- Tweak palette colors before highlights are built
  on_colors = function(colors)
    -- colors.green = "#b0e070"
  end,

  -- Tweak or add highlight groups after they are built
  on_highlights = function(highlights, colors)
    -- highlights.CursorLineNr = { fg = colors.yellow, bold = true }
  end,
})

vim.cmd.colorscheme("eggfriedrice")
```

### lualine

```lua
require("lualine").setup({
  options = { theme = "eggfriedrice" },
})
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
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

## License

MIT
