---@module "eggfriedrice.preview"
---@author eggfriedrice24
---@license MIT

-- Renders assets/preview.svg from the palette, so the picture in the
-- README can never drift from the colors. Run `make preview` (or
-- `nvim -l scripts/preview.lua`) after changing colors.lua; CI fails
-- when the committed image drifts from the palette.
--
-- The picture is an editor window over a terminal window over a strip of
-- palette swatches. Every position is a constant below or derived from
-- one, and every color comes from the palette table, so the output is
-- byte-identical for the same colors.

local M = {}

---Output path, relative to the repository root.
M.path = "assets/preview.svg"

-- Typography. Each font in the stack advances 0.6em per glyph, which is
-- what column positions and highlight bands are computed from.
local FONT = "JetBrains Mono, Fira Code, Menlo, monospace"
local SIZE = 13
local CH = SIZE * 0.6
local LINE = 21
local BASELINE = 15 -- baseline offset inside a row
local SMALL = 10 -- labels

-- Geometry
local WIDTH = 1200
local PAD = 24 -- canvas margin
local GAP = 20 -- between windows
local INSET = 12 -- window body padding
local CHROME = 36 -- title bar height
local STATUS = 22 -- status bar height
local RADIUS = 10
local GUTTER = 48 -- line number column
local SWATCH = 30 -- color square side

-- XML ---------------------------------------------------------------------

---@param s string
---@return string
local function xml_escape(s)
	return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

---Numbers without float noise: 126.60000000000001 becomes 126.6.
---@param v any
---@return any
local function num(v)
	if type(v) ~= "number" then
		return v
	end
	return (("%.2f"):format(v):gsub("%.?0+$", ""))
end

---Attributes in a fixed key order, so the output never reorders.
---@param t table<string, string|number>
---@return string
local function attrs(t)
	local keys = vim.tbl_keys(t)
	table.sort(keys)
	local out = {}
	for _, k in ipairs(keys) do
		out[#out + 1] = (' %s="%s"'):format(k, num(t[k]))
	end
	return table.concat(out)
end

---@param name string
---@param t table<string, string|number>
---@param body? string
---@return string
local function el(name, t, body)
	if body then
		return "<" .. name .. attrs(t) .. ">" .. body .. "</" .. name .. ">"
	end
	return "<" .. name .. attrs(t) .. "/>"
end

-- Roles -------------------------------------------------------------------

---Text styles keyed by role, so a sample says what a token is and the
---palette decides how it looks. Bands (`bg`) sit behind the text.
---@param c table
---@return table<string, { fill?: string, bg?: string, bold?: boolean, italic?: boolean }>
local function roles(c)
	return {
		-- code, matching lua/eggfriedrice/treesitter.lua
		text = { fill = c.fg },
		keyword = { fill = c.purple },
		fn = { fill = c.yellow },
		type = { fill = c.yellow },
		const = { fill = c.yellow },
		module = { fill = c.yellow },
		string = { fill = c.green },
		var = { fill = c.red },
		op = { fill = c.blue },
		escape = { fill = c.cyan },
		special = { fill = c.purple },
		punct = { fill = c.fg_dark },
		comment = { fill = c.comment, italic = true },
		-- editor UI, matching lua/eggfriedrice/highlights.lua
		search = { bg = c.search },
		cursearch = { bg = c.search_selected, fill = c.bg, bold = true },
		cursor = { bg = c.yellow },
		-- terminal, matching the starship, zsh, eza and git extras
		dir = { fill = c.cyan, bold = true },
		branch = { fill = c.purple },
		dirty = { fill = c.yellow },
		prompt = { fill = c.yellow, bold = true },
		cmd = { fill = c.yellow },
		opt = { fill = c.cyan },
		muted = { fill = c.fg_dark },
		subtle = { fill = c.comment },
		folder = { fill = c.blue, bold = true },
		exec = { fill = c.green },
		link = { fill = c.cyan },
		write = { fill = c.yellow },
		unit = { fill = c.blue },
		hunk = { fill = c.cyan },
		removed = { fill = c.red },
		added = { fill = c.green },
		diff_delete = { bg = c.diff.delete },
		diff_add = { bg = c.diff.add },
	}
end

---@class eggfriedrice.preview.Token
---@field [1] string text
---@field [2] string role
---@field band? string role whose `bg` is painted behind this token only

---@param role string
---@return fun(text: string, band?: string): eggfriedrice.preview.Token
local function tok(role)
	return function(text, band)
		return { text, role, band = band }
	end
end

local kw = tok("keyword")
local fn = tok("fn")
local ty = tok("type")
local const = tok("const")
local mod = tok("module")
local str = tok("string")
local var = tok("var")
local op = tok("op")
local esc = tok("escape")
local special = tok("special")
local punct = tok("punct")
local cmt = tok("comment")

-- Text runs ---------------------------------------------------------------

---One row of tokens: the bands behind them and a <text> with one <tspan>
---per token. A bare string is plain text. `x` is the first glyph's left
---edge, `y` the row top.
---@param st table styles from roles()
---@param x number
---@param y number
---@param tokens (eggfriedrice.preview.Token|string)[]
---@return string bands, string text
local function text_row(st, x, y, tokens)
	local bands, spans, col = {}, {}, 0
	for _, t in ipairs(tokens) do
		if type(t) == "string" then
			t = { t, "text" }
		end
		local style = assert(st[t[2]], t[2])
		local band = t.band and assert(st[t.band], t.band) or {}
		local width = vim.fn.strchars(t[1])
		if band.bg then
			bands[#bands + 1] =
				el("rect", { x = x + col * CH, y = y, width = width * CH, height = LINE, rx = 2, fill = band.bg })
		end
		local a = { fill = band.fill or style.fill }
		if band.bold or style.bold then
			a["font-weight"] = "bold"
		end
		if style.italic then
			a["font-style"] = "italic"
		end
		spans[#spans + 1] = el("tspan", a, xml_escape(t[1]))
		col = col + width
	end
	local text = el("text", { x = x, y = y + BASELINE, ["xml:space"] = "preserve" }, table.concat(spans))
	return table.concat(bands), text
end

---A label in the small size.
---@param x number
---@param y number baseline
---@param fill string
---@param s string
---@param anchor? string
---@return string
local function label(x, y, fill, s, anchor)
	return el("text", { x = x, y = y, fill = fill, ["font-size"] = SMALL, ["text-anchor"] = anchor }, xml_escape(s))
end

-- Window frame ------------------------------------------------------------

---A rounded window: chrome strip on top, the editor background below,
---`body` drawn inside the rounded clip, then a hairline border on top.
---@param c table
---@param id string
---@param x number
---@param y number
---@param w number
---@param h number
---@param body string
---@return string
local function window(c, id, x, y, w, h, body)
	local clip = "clip-" .. id
	return table.concat({
		el("clipPath", { id = clip }, el("rect", { x = x, y = y, width = w, height = h, rx = RADIUS })),
		el(
			"g",
			{ ["clip-path"] = "url(#" .. clip .. ")" },
			table.concat({
				el("rect", { x = x, y = y, width = w, height = h, fill = c.bg }),
				el("rect", { x = x, y = y, width = w, height = CHROME, fill = c.bg_dark }),
				body,
			}, "\n")
		),
		el("rect", {
			x = x + 0.5,
			y = y + 0.5,
			width = w - 1,
			height = h - 1,
			rx = RADIUS,
			fill = "none",
			stroke = c.fg_gutter,
		}),
	}, "\n")
end

---The three window buttons, colored like diagnostics.
---@param c table
---@param x number
---@param y number
---@return string
local function dots(c, x, y)
	local out = {}
	for i, fill in ipairs({ c.red, c.yellow, c.green }) do
		out[#out + 1] = el("circle", { cx = x + 18 * i, cy = y + CHROME / 2, r = 5, fill = fill })
	end
	return table.concat(out, "\n")
end

---Bufferline-style tabs in the chrome: the active one sits on the body
---color under a yellow indicator, the rest read in the comment color.
---@param c table
---@param x number
---@param y number
---@param names string[]
---@param active integer
---@return string
local function tabs(c, x, y, names, active)
	local out, tx = {}, x
	for i, name in ipairs(names) do
		local tw = vim.fn.strchars(name) * CH + 28
		if i == active then
			out[#out + 1] = el("rect", { x = tx, y = y, width = tw, height = CHROME, fill = c.bg })
			out[#out + 1] = el("rect", { x = tx, y = y + 1, width = tw, height = 2, fill = c.yellow })
		end
		local fill = i == active and c.fg or c.comment
		out[#out + 1] = el("text", { x = tx + 14, y = y + CHROME / 2 + 5, fill = fill }, xml_escape(name))
		tx = tx + tw
	end
	return table.concat(out, "\n")
end

---A one-row status bar: `left` segments laid out from the left edge,
---`right` segments from the right edge, each with its own colors.
---@param c table
---@param x number
---@param y number
---@param w number
---@param left { [1]: string, fill: string, bg?: string, bold?: boolean }[]
---@param right { [1]: string, fill: string, bg?: string, bold?: boolean }[]
---@return string
local function bar(c, x, y, w, left, right)
	local out = { el("rect", { x = x, y = y, width = w, height = STATUS, fill = c.bg_dark }) }
	local function segment(s, sx)
		local sw = vim.fn.strchars(s[1]) * CH
		if s.bg then
			out[#out + 1] = el("rect", { x = sx, y = y, width = sw, height = STATUS, fill = s.bg })
		end
		out[#out + 1] = el("text", {
			x = sx,
			y = y + BASELINE,
			fill = s.fill,
			["font-weight"] = s.bold and "bold" or nil,
			["xml:space"] = "preserve",
		}, xml_escape(s[1]))
		return sw
	end
	local sx = x
	for _, s in ipairs(left) do
		sx = sx + segment(s, sx)
	end
	sx = x + w
	for i = #right, 1, -1 do
		sx = sx - vim.fn.strchars(right[i][1]) * CH
		segment(right[i], sx)
	end
	return table.concat(out, "\n")
end

-- Code pane ---------------------------------------------------------------

-- The samples, one Lua line per source line so they read as code.
-- stylua: ignore
local TYPESCRIPT = {
	{ kw("import"), " ", punct("{"), " ", fn("serve", "search"), " ", punct("}"), " ", kw("from"), " ", str('"./http"') },
	{ cmt("// retry until the api answers") },
	{ kw("interface"), " ", ty("Config"), " ", punct("{") },
	{ "  ", var("host"), punct(":"), " ", ty("string") },
	{ "  ", var("port"), punct(":"), " ", ty("number") },
	{ "  ", var("secure"), punct(":"), " ", ty("boolean") },
	{ punct("}") },
	{ kw("const"), " ", const("MAX_RETRIES"), " ", op("="), " ", const("3") },
	{ kw("export"), " ", kw("const"), " ", fn("boot"), " ", op("="), " ", kw("async"), " ", punct("("), var("cfg"), punct(":"), " ", ty("Config"), punct(")"), " ", op("=>"), " ", punct("{") },
	{ "  ", kw("const"), " ", var("url"), " ", op("="), " ", str("`https://"), special("${"), var("cfg"), punct("."), var("host"), special("}"), str(":"), special("${"), var("cfg"), punct("."), var("port"), special("}"), str("`") },
	{ "  ", kw("return"), " ", fn("serve", "cursearch"), punct("("), var("url"), punct(","), " ", punct("{"), " ", var("retries"), punct(":"), " ", const("MAX_RETRIES"), punct(","), " ", var("tls"), punct(":"), " ", const("true"), " ", punct("})") },
	{ punct("}") },
}

-- stylua: ignore
local GO = {
	{ kw("package"), " ", mod("main") },
	{},
	{ cmt("// Server owns one listener") },
	{ kw("type"), " ", ty("Server"), " ", kw("struct"), " ", punct("{") },
	{ "    ", var("Addr"), "    ", ty("string") },
	{ "    ", var("Retries"), " ", ty("int") },
	{ punct("}") },
	{},
	{ kw("func"), " ", punct("("), var("s"), " ", op("*"), ty("Server"), punct(")"), " ", fn("Start"), punct("()"), " ", ty("error"), " ", punct("{") },
	{ "    ", mod("log"), punct("."), fn("Printf"), punct("("), str('"listening on %s'), esc("\\n"), str('"'), punct(","), " ", var("s"), punct("."), var("Addr"), punct(")") },
	{ "    ", kw("return"), " ", mod("http"), punct("."), fn("ListenAndServe"), punct("("), var("s"), punct("."), var("Addr"), punct(","), " ", const("nil"), punct(")") },
	{ punct("}") },
}

---A buffer: line numbers in the gutter, the cursor line banded, tokens
---colored by role. `current` is the 1-based cursor line, 0 for none.
---@param c table
---@param st table
---@param x number
---@param y number
---@param w number
---@param lines (eggfriedrice.preview.Token|string)[][]
---@param current integer
---@return string
local function code_pane(c, st, x, y, w, lines, current)
	local out = {}
	for i, tokens in ipairs(lines) do
		local ry = y + (i - 1) * LINE
		local cursor = i == current
		if cursor then
			out[#out + 1] = el("rect", { x = x, y = ry, width = w, height = LINE, fill = c.bg_light })
		end
		out[#out + 1] = el("text", {
			x = x + GUTTER - 16,
			y = ry + BASELINE,
			["text-anchor"] = "end",
			fill = cursor and c.yellow or c.fg_gutter_ui,
			["font-weight"] = cursor and "bold" or nil,
		}, tostring(i))
		if #tokens > 0 then
			local bands, text = text_row(st, x + GUTTER, ry, tokens)
			out[#out + 1] = bands .. text
		end
	end
	return table.concat(out, "\n")
end

---A lualine bar in normal mode, from lua/lualine/themes/eggfriedrice.lua.
---@param c table
---@param x number
---@param y number
---@param w number
---@return string
local function statusline(c, x, y, w)
	return bar(c, x, y, w, {
		{ " NORMAL ", bg = c.yellow, fill = c.bg, bold = true },
		{ " master ", bg = c.bg_light, fill = c.fg },
		{ " app.ts [+] ", fill = c.fg_dark },
	}, {
		{ " typescript  utf-8 ", fill = c.fg_dark },
		{ " 83% ", bg = c.bg_light, fill = c.fg },
		{ " 10:23 ", bg = c.yellow, fill = c.bg, bold = true },
	})
end

---The editor window: tabs, two buffers side by side, a statusline.
---@param c table
---@param st table
---@param x number
---@param y number
---@param w number
---@return string svg, number height
local function editor(c, st, x, y, w)
	local pane_w = w / 2
	local rows = math.max(#TYPESCRIPT, #GO)
	local h = CHROME + INSET + rows * LINE + INSET + STATUS
	local body_y = y + CHROME + INSET
	local body = table.concat({
		dots(c, x, y),
		tabs(c, x + 76, y, { "app.ts", "main.go" }, 1),
		code_pane(c, st, x, body_y, pane_w, TYPESCRIPT, 10),
		el("line", {
			x1 = x + pane_w + 0.5,
			y1 = y + CHROME,
			x2 = x + pane_w + 0.5,
			y2 = y + h - STATUS,
			stroke = c.fg_gutter_ui,
		}),
		code_pane(c, st, x + pane_w + 1, body_y, pane_w - 1, GO, 0),
		statusline(c, x, y + h - STATUS, w),
	}, "\n")
	return window(c, "editor", x, y, w, h, body), h
end

-- Terminal pane -----------------------------------------------------------

---A starship prompt in its palette roles, followed by `cmd` tokens.
---@param cmd (eggfriedrice.preview.Token|string)[]
---@return (eggfriedrice.preview.Token|string)[]
local function prompt(cmd)
	local tokens = {
		{ "~/p/eggfriedrice.nvim", "dir" },
		" ",
		{ "[master]", "branch" },
		" ",
		{ "[!]", "dirty" },
		" ",
		{ "❯", "prompt" },
		" ",
	}
	return vim.list_extend(tokens, cmd)
end

---An eza permission column, one token per bit: read in the owner tiers,
---write yellow, execute green, the type character in its file kind.
---@param s string like "drwxr-xr-x"
---@return eggfriedrice.preview.Token[]
local function perms(s)
	local kind = { d = "folder", l = "link", ["."] = "muted" }
	local read = { "text", "muted", "subtle" } -- user, group, other
	local tokens = { { s:sub(1, 1), kind[s:sub(1, 1)] } }
	for i = 2, 10 do
		local bit = s:sub(i, i)
		local role = "exec"
		if bit == "-" then
			role = "muted"
		elseif bit == "r" then
			role = read[math.floor((i - 2) / 3) + 1]
		elseif bit == "w" then
			role = "write"
		end
		tokens[#tokens + 1] = { bit, role }
	end
	return tokens
end

---An eza size column, right-aligned to five cells, the unit in blue.
---@param s string like "1.1k" or "-"
---@return (eggfriedrice.preview.Token|string)[]
local function size(s)
	local pad = (" "):rep(5 - #s)
	if s == "-" then
		return { { pad .. s, "muted" } }
	end
	local n, unit = s:match("^([%d%.]+)(%a?)$")
	local tokens = { pad .. n }
	if unit ~= "" then
		tokens[#tokens + 1] = { unit, "unit" }
	end
	return tokens
end

-- stylua: ignore
local FILES = {
	{ ".rwxr-xr-x", "1.1k", { "build.sh", "exec" } },
	{ "drwxr-xr-x", "-", { "extras", "folder" } },
	{ "drwxr-xr-x", "-", { "lua", "folder" } },
	{ ".rw-r--r--", "371", "Makefile" },
	{ "lrwxrwxrwx", "-", { "theme.yml", "link" }, { " -> ", "muted" }, { "extras/eza/eggfriedrice.yml", "link" } },
}

---The shell pane: a listing, then an empty prompt with the block cursor.
---@return (eggfriedrice.preview.Token|string)[][]
local function shell_lines()
	local lines = { prompt({ { "eza", "cmd" }, " ", { "-l", "opt" }, " ", { "--no-time", "opt" } }) }
	for _, f in ipairs(FILES) do
		local row = perms(f[1])
		row[#row + 1] = " "
		vim.list_extend(row, size(f[2]))
		row[#row + 1] = " egg "
		vim.list_extend(row, vim.list_slice(f, 3))
		lines[#lines + 1] = row
	end
	lines[#lines + 1] = {}
	lines[#lines + 1] = prompt({ { " ", "text", band = "cursor" } })
	return lines
end

---The diff pane: the hunk that made the prompt dirty.
---@return (eggfriedrice.preview.Token|string)[][]
local function diff_lines()
	return {
		prompt({ { "git", "cmd" }, " ", "diff" }),
		{ { "@@ -7,2 +7,2 @@", "hunk" }, " interface Config {" },
		{ " }" },
		{ { "-const MAX_RETRIES = 5", "removed" }, bg = "diff_delete" },
		{ { "+const MAX_RETRIES = 3", "added" }, bg = "diff_add" },
	}
end

---Rows of terminal output; a row with `bg` gets a pane-wide band.
---@param st table
---@param x number
---@param y number
---@param w number
---@param lines (eggfriedrice.preview.Token|string)[][]
---@return string
local function term_pane(st, x, y, w, lines)
	local out = {}
	for i, tokens in ipairs(lines) do
		local ry = y + (i - 1) * LINE
		if tokens.bg then
			out[#out + 1] = el("rect", { x = x, y = ry, width = w, height = LINE, fill = st[tokens.bg].bg })
		end
		if #tokens > 0 then
			local bands, text = text_row(st, x + INSET, ry, tokens)
			out[#out + 1] = bands .. text
		end
	end
	return table.concat(out, "\n")
end

---The 16 terminal slots as two rows of eight, in the palette JSON's order.
---@param c table
---@param x number
---@param y number
---@return string svg, number height
local function ansi_grid(c, x, y)
	local order = require("eggfriedrice.extra.palette").ansi
	local pitch = SWATCH + 8
	local row_h = SWATCH + SMALL + 12
	local out = {}
	for row, name in ipairs({ "normal", "bright" }) do
		local ry = y + (row - 1) * row_h
		out[#out + 1] = label(x, ry + SWATCH / 2 + 4, c.comment, name)
		for i = 1, 8 do
			local slot = (row - 1) * 8 + i
			local sx = x + 60 + (i - 1) * pitch
			out[#out + 1] = el("rect", {
				x = sx,
				y = ry,
				width = SWATCH,
				height = SWATCH,
				rx = 5,
				fill = c[order[slot]],
				stroke = c.fg_gutter,
			})
			out[#out + 1] =
				label(sx + SWATCH / 2, ry + SWATCH + SMALL + 2, c.fg_gutter_ui, tostring(slot - 1), "middle")
		end
	end
	return table.concat(out, "\n"), 2 * row_h
end

---A tmux status line, from the tmux extra's status styles.
---@param c table
---@param x number
---@param y number
---@param w number
---@return string
local function tmux_bar(c, x, y, w)
	return bar(c, x, y, w, {
		{ " eggfriedrice ", bg = c.yellow, fill = c.bg, bold = true },
		{ " 1:zsh* ", bg = c.bg, fill = c.fg, bold = true },
		{ " 2:nvim ", fill = c.comment },
	}, {
		{ " rice ", fill = c.comment },
	})
end

---The terminal window: a shell pane and a diff pane split like tmux,
---the ANSI grid under the diff, a tmux status line.
---@param c table
---@param st table
---@param x number
---@param y number
---@param w number
---@return string svg, number height
local function terminal(c, st, x, y, w)
	local pane_w = w / 2
	local shell, diff = shell_lines(), diff_lines()
	local body_y = y + CHROME + INSET
	local grid_y = body_y + #diff * LINE + INSET
	local grid, grid_h = ansi_grid(c, x + pane_w + INSET, grid_y)
	local content = math.max(#shell * LINE, grid_y - body_y + grid_h)
	local h = CHROME + INSET + content + INSET + STATUS
	local body = table.concat({
		dots(c, x, y),
		el("text", { x = x + w / 2, y = y + CHROME / 2 + 5, fill = c.comment, ["text-anchor"] = "middle" }, "tmux"),
		term_pane(st, x, body_y, pane_w, shell),
		el("line", {
			x1 = x + pane_w + 0.5,
			y1 = y + CHROME,
			x2 = x + pane_w + 0.5,
			y2 = y + h - STATUS,
			stroke = c.border,
		}),
		term_pane(st, x + pane_w + 1, body_y, pane_w - 1, diff),
		grid,
		tmux_bar(c, x, y + h - STATUS, w),
	}, "\n")
	return window(c, "terminal", x, y, w, h, body), h
end

-- Swatch strip ------------------------------------------------------------

---Every primitive, in the order the extras export them.
local PRIMITIVES = {
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

---One square per primitive, its name above and hex below.
---@param c table
---@param x number
---@param y number
---@param w number
---@return string svg, number height
local function swatches(c, x, y, w)
	local per_row = 12
	local cell = w / per_row
	local row_h = SMALL + 5 + SWATCH + 5 + SMALL + 12
	local out = {}
	for i, name in ipairs(PRIMITIVES) do
		local cx = x + ((i - 1) % per_row) * cell + cell / 2
		local ry = y + math.floor((i - 1) / per_row) * row_h
		out[#out + 1] = label(cx, ry + SMALL, c.comment, name, "middle")
		out[#out + 1] = el("rect", {
			x = cx - SWATCH / 2,
			y = ry + SMALL + 5,
			width = SWATCH,
			height = SWATCH,
			rx = 5,
			fill = c[name],
			stroke = c.fg_gutter,
		})
		out[#out + 1] = label(cx, ry + SMALL + 5 + SWATCH + 5 + SMALL, c.comment, c[name], "middle")
	end
	return table.concat(out, "\n"), 2 * row_h
end

-- Entry -------------------------------------------------------------------

---The whole preview as an SVG document.
---@param c table palette from require("eggfriedrice.colors").get()
---@return string
function M.generate(c)
	local st = roles(c)
	local x, w = PAD, WIDTH - 2 * PAD
	local y = PAD
	local ed, ed_h = editor(c, st, x, y, w)
	y = y + ed_h + GAP
	local term, term_h = terminal(c, st, x, y, w)
	y = y + term_h + GAP
	local strip, strip_h = swatches(c, x, y, w)
	local height = y + strip_h + PAD
	return el(
		"svg",
		{
			xmlns = "http://www.w3.org/2000/svg",
			width = WIDTH,
			height = height,
			viewBox = ("0 0 %d %d"):format(WIDTH, height),
			["font-family"] = FONT,
			["font-size"] = SIZE,
		},
		table.concat({
			"",
			"<!-- generated from lua/eggfriedrice/colors.lua by `make preview`; do not edit by hand -->",
			el("rect", { width = WIDTH, height = height, rx = RADIUS, fill = c.bg }),
			ed,
			term,
			strip,
			"",
		}, "\n")
	) .. "\n"
end

---Render the preview into `<root>/assets/preview.svg`.
---@param root string repository root
---@return string written path, relative to root
function M.write(root)
	local c = require("eggfriedrice.colors").get()
	local f = assert(io.open(root .. "/" .. M.path, "w"))
	f:write(M.generate(c))
	f:close()
	return M.path
end

return M
