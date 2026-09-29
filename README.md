# eggfriedrice

A dark, warm Neovim colorscheme that leans into its name: yolk-yellow literals, rice-cream text, and scallion-green strings on a navy background inspired by [halcyon](https://github.com/bchiang7/halcyon-vscode). Token roles follow [One Dark Pro](https://github.com/Binaryify/OneDark-Pro): red identifiers, purple keywords, green strings. Yellow is the signature and carries functions, types and builtins plus everything One Dark Pro paints orange: numbers, booleans, constants, attributes. Operators are blue where One Dark Pro uses cyan.

![preview](assets/preview.svg)

The preview is generated from the palette by `make preview`, so it never drifts from the colors.

## Palette

| Role | Color | Hex |
| ------------------------------------------ | ----------- | --------- |
| Variables, fields, keys, tags, errors | Red | `#e06c75` |
| Keywords, decorators | Purple | `#c084fc` |
| Functions, types, builtins, numbers, booleans, constants | Yolk yellow | `#ffc940` |
| Operators | Blue | `#6cb8ff` |
| Strings | Scallion | `#60e654` |
| Escapes, enum members, accents | Teal | `#78e2d6` |
| Text | Rice cream | `#d8d3c3` |
| Punctuation | Muted | `#a8a396` |
| Comments | Blue gray | `#8695b7` |
| Background | Navy | `#0d111a` |
| Line numbers, dividers | Gutter | `#586480` |
| Dormant, not assigned to any group | Orange | `#fc9a2c` |

Fields and properties are red on both declaration and access, like One Dark Pro. Diff backgrounds are tints at one OKLCH lightness and chroma in each accent's hue, and search backgrounds are blends. Both are computed at load time, so overriding a palette color carries through everywhere.

A bright tier (`red_bright`, `green_bright`, `yellow_bright`, `blue_bright`, `purple_bright`, `cyan_bright`, `fg_bright`) lifts each accent 0.04 OKLCH lightness with its hue held. It fills ANSI slots 9 to 15 in `:terminal` and in the extras, so bold terminal text reads as the same color, only lit.

## Features

- Consistent token roles across legacy syntax, treesitter, and LSP semantic tokens - tuned against TypeScript, JavaScript, Go, Rust, Java, Python, Lua, CSS, HTML, YAML, JSON, TOML, and Markdown
- Terminal colors (`:terminal` matches the theme)
- Bundled lualine theme
- Extras for Ghostty, Hyprland, waybar, rofi, dunst, fzf, zsh, Starship, tmux, lazygit, bat, btop, eza, opencode, Slack, Discord, Zen and Chromium browsers, generated from the same palette (see [Extras](#extras))
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

### vim.pack (Neovim 0.12+)

```lua
vim.pack.add({ "https://github.com/eggfriedrice24/eggfriedrice.nvim" })
vim.cmd.colorscheme("eggfriedrice")
```

## Configuration

`setup()` is optional and only needed to change defaults. Call it before `colorscheme`. Full docs: `:h eggfriedrice`.

```lua
-- defaults
require("eggfriedrice").setup({
  transparent = false,    -- no background; let the terminal show through
  italic_comments = true, -- italic comments
  dim_inactive = false,   -- darker background in inactive windows
  on_colors = nil,        -- fun(colors): tweak the palette
  on_highlights = nil,    -- fun(highlights, colors): tweak highlight groups
})

vim.cmd.colorscheme("eggfriedrice")
```

### Transparent background

Removes editor, float, and sidebar backgrounds so your terminal's background (and its opacity or blur) shows through:

```lua
{
  "eggfriedrice24/eggfriedrice.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("eggfriedrice").setup({
      transparent = true,
    })
    vim.cmd.colorscheme("eggfriedrice")
  end,
}
```

### Upright comments

```lua
require("eggfriedrice").setup({
  italic_comments = false,
})
```

### Dim inactive windows

Inactive windows get the darker background shade (ignored while `transparent` is set):

```lua
require("eggfriedrice").setup({
  dim_inactive = true,
})
```

### Overriding the palette

`on_colors` runs before highlights are built and receives the complete palette, including semantic aliases (`error`, `git_add`, ...) and derived backgrounds (`diff`, `search`, ...). Changes carry through everywhere:

```lua
require("eggfriedrice").setup({
  on_colors = function(c)
    c.green = "#b0e070"   -- brighter strings
    c.comment = "#8a8578" -- brighter comments
  end,
})
```

### Overriding highlight groups

`on_highlights` runs after all groups are built and can change or add any group. The dormant orange is in the palette for exactly this:

```lua
require("eggfriedrice").setup({
  on_highlights = function(hl, c)
    hl.CursorLineNr = { fg = c.red, bold = true }
    hl["@punctuation.special"] = { fg = c.orange }
    hl.TelescopeBorder = { fg = c.fg_gutter }
  end,
})
```

### lualine

A matching lualine theme is bundled (normal is yellow, insert green, visual purple, replace red, command cyan):

```lua
require("lualine").setup({
  options = { theme = "eggfriedrice" },
})
```

## Extras

The same palette, rendered for the rest of the terminal. Every file under [`extras/`](extras) is generated from `lua/eggfriedrice/colors.lua` by `make extras`, and CI fails when they drift, so they never lag behind the editor.

| App | File | Install |
| --- | --- | --- |
| [Ghostty](https://ghostty.org) | `extras/ghostty/eggfriedrice` | copy to `~/.config/ghostty/themes/eggfriedrice`, set `theme = eggfriedrice` |
| [fzf](https://github.com/junegunn/fzf) 0.36+ | `extras/fzf/eggfriedrice.sh` | `source` it from your shell rc |
| zsh with [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | `extras/zsh/eggfriedrice.zsh` | `source` it from `.zshrc` |
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | `extras/fsh/eggfriedrice.ini` | copy to `~/.config/fsh/`, run `fast-theme XDG:eggfriedrice` |
| [Starship](https://starship.rs) | `extras/starship/eggfriedrice.toml` | paste into `starship.toml`, use the names in `style` |
| [tmux](https://github.com/tmux/tmux) 3.3+ | `extras/tmux/eggfriedrice.tmux` | `source-file` it from `tmux.conf`; the palette is also set as `@eggfriedrice_*` user options for your own formats |
| [lazygit](https://github.com/jesseduffield/lazygit) | `extras/lazygit/eggfriedrice.yml` | append to `LG_CONFIG_FILE` after your own config |
| [bat](https://github.com/sharkdp/bat), Sublime Text | `extras/bat/eggfriedrice.tmTheme` | copy to `~/.config/bat/themes/`, run `bat cache --build`, set `BAT_THEME=eggfriedrice` |
| [Hyprland](https://hyprland.org) and hyprlock | `extras/hyprland/eggfriedrice.conf` | `source =` it, then use `$yellow` or `rgba($yellowAlphaee)` |
| Lua (Hyprland's Lua config, wezterm, ...) | `extras/lua/eggfriedrice.lua` | put it on your Lua path and `require("eggfriedrice")` |
| GTK CSS: [waybar](https://github.com/Alexays/Waybar), ghostty `gtk-custom-css` | `extras/gtk/eggfriedrice.css` | `@import url(...)` it, then use `@yellow` or `alpha(@bg, 0.7)` |
| [rofi](https://github.com/davatorium/rofi) | `extras/rofi/eggfriedrice.rasi` | `@import` it, then use `@yellow` |
| [dunst](https://dunst-project.org) | `extras/dunst/eggfriedrice.conf` | copy or symlink into `~/.config/dunst/dunstrc.d/` |
| [btop](https://github.com/aristocratos/btop) | `extras/btop/eggfriedrice.theme` | copy into `~/.config/btop/themes/`, set `color_theme = "eggfriedrice"` |
| [eza](https://github.com/eza-community/eza) | `extras/eza/eggfriedrice.yml` | copy or symlink to `~/.config/eza/theme.yml`, unset `LS_COLORS` and `EZA_COLORS` |
| [opencode](https://opencode.ai) | `extras/opencode/eggfriedrice.json` | copy or symlink into `~/.config/opencode/themes/`, then set `theme.name` in `cli.json` (opencode 2) or `theme` in `tui.json` (opencode 1) |
| [Slack](https://slack.com) | `extras/slack/eggfriedrice.txt` | Preferences, Appearance, Custom theme, Import: paste the four-color line (classic client: the ten-color one) |
| [Discord](https://discord.com) via [Vencord](https://vencord.dev), Vesktop or BetterDiscord | `extras/discord/eggfriedrice.theme.css` | copy or symlink into the client mod's `themes/` dir and enable it; the stock client cannot load themes |
| [Zen Browser](https://zen-browser.app) | `extras/zen/userChrome.css` | copy or symlink to `<profile>/chrome/userChrome.css`, set `toolkit.legacyUserProfileCustomizations.stylesheets` to true in `about:config`, restart |
| [Helium](https://helium.computer) and other Chromium browsers | `extras/chromium/manifest.json` | `chrome://extensions`, Developer mode, Load unpacked, pick the `extras/chromium` folder |
| anything else | `extras/palette/eggfriedrice.json` | primitives, semantic tokens, the 16 ANSI slots and every app's role map as JSON |

Shell roles match the editor: commands are yellow like functions, quoted words green like strings, `$vars` red like variables, redirections blue like operators. The palette JSON carries the full token set of the design system, including the semantic names each extra maps from.

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
