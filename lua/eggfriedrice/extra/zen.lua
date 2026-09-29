---@module "eggfriedrice.extra.zen"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	return require("eggfriedrice.extra.browser").roles(c)
end

---@param c table
---@return string
function M.generate(c)
	-- Written against Zen 1.22 (zen-styles/zen-theme.css, zen-omnibox.css,
	-- zen-browser-ui.css, ZenGradientGenerator.mjs) and its Firefox base's
	-- tab, urlbar and toolbar tokens. Every variable below is one that
	-- build reads. Zen derives almost every surface from
	-- --zen-primary-color and --zen-branding-bg, and its workspace gradient
	-- writes the browser backgrounds inline on #zen-browser-background and
	-- #zen-toolbar-background, and the accent and toolbar text inline on
	-- :root and each zen-workspace. Inline styles lose to important
	-- declarations on the same element, so those are set exactly there.
	local extra = require("eggfriedrice.extra")
	return util.template(
		[[
/*
 * eggfriedrice for ${label}
 * generated from lua/eggfriedrice/colors.lua by `make extras`; do not edit by hand
 * install: ${install}
 *
 * Written for Zen 1.22. The workspace gradient is overridden on purpose:
 * the sidebar and toolbar always wear the palette, whatever theme a
 * workspace picked.
 */

/* the browser and toolbar backgrounds the workspace gradient paints */
#zen-browser-background,
#zen-toolbar-background {
  --zen-main-browser-background: ${frame} !important;
  --zen-main-browser-background-old: ${frame} !important;
  --zen-main-browser-background-toolbar: ${toolbar} !important;
  --zen-main-browser-background-toolbar-old: ${toolbar} !important;
}

/* the accent and toolbar text the gradient derives, pinned where Zen writes them */
:root,
zen-workspace {
  --zen-primary-color: ${accent} !important;
  --toolbox-textcolor: ${toolbar_text} !important;
  --toolbar-color-scheme: dark !important;
  color-scheme: dark !important;
}

/* the url bar surface, defined on the element itself */
.urlbar-background {
  --zen-urlbar-background-base: ${urlbar} !important;
  --zen-urlbar-background-transparent: ${urlbar} !important;
}

:root {
  /* branding surfaces every derived color mixes from */
  --zen-branding-dark: ${frame} !important;
  --zen-branding-paper: ${toolbar_text} !important;

  /* derived surfaces, pinned so they stay navy instead of tinting toward the accent */
  --zen-colors-primary: ${toolbar} !important;
  --zen-colors-secondary: ${tab_active} !important;
  --zen-colors-tertiary: ${frame} !important;
  --zen-colors-hover-bg: ${hover} !important;
  --zen-colors-primary-foreground: ${toolbar_text} !important;
  --zen-colors-border: ${border} !important;
  --zen-colors-border-contrast: ${border} !important;
  --zen-colors-input-bg: ${urlbar} !important;
  --zen-themed-toolbar-bg-transparent: ${toolbar} !important;
  --zen-toolbar-element-bg: ${tab_active} !important;
  --zen-toolbar-element-bg-hover: ${hover} !important;
  --zen-dialog-background: ${popup} !important;
  --zen-input-border-color: ${border} !important;

  /* toolbars */
  --toolbar-background-color: ${toolbar} !important;
  --toolbar-color: ${toolbar_text} !important;
  --toolbar-text-color: ${toolbar_text} !important;
  --toolbarbutton-icon-fill: ${toolbar_icon} !important;
  --toolbarbutton-background-color-hover: ${hover} !important;
  --toolbarbutton-background-color-active: ${hover} !important;
  --chrome-content-separator-color: ${border} !important;

  /* tabs */
  --tab-background-color-selected: ${tab_active} !important;
  --tab-background-color-hover: ${hover} !important;
  --tab-selected-textcolor: ${tab_active_text} !important;

  /* url bar and its results */
  --toolbar-field-background-color: ${urlbar} !important;
  --urlbar-box-background-color-focus: ${hover} !important;
  --urlbar-box-background-color-active: ${hover} !important;
  --urlbar-box-text-color: ${urlbar_text} !important;
  --urlbar-box-text-color-hover: ${urlbar_text} !important;
  --urlbarView-result-button-selected-background-color: ${hover} !important;
  --urlbarView-result-button-selected-color: ${urlbar_text} !important;
  --urlbarview-background-color-hover: ${hover} !important;
  --urlbarview-text-color-secondary: ${muted} !important;
  --text-color-deemphasized: ${muted} !important;
  --link-color: ${link} !important;

  /* panels and sidebar */
  --arrowpanel-background: ${popup} !important;
  --arrowpanel-border-color: ${border} !important;
  --panel-separator-color: ${border} !important;
  --sidebar-background-color: ${sidebar} !important;
  --sidebar-text-color: ${sidebar_text} !important;
  --lwt-sidebar-highlight-background-color: ${hover} !important;
  --lwt-sidebar-highlight-text-color: ${sidebar_text} !important;

  /* new tab, primary buttons and inputs */
  --newtab-background-color: ${newtab} !important;
  --newtab-text-primary-color: ${newtab_text} !important;
  --in-content-primary-button-background: ${accent} !important;
  --in-content-primary-button-background-hover: ${accent_hover} !important;
  --in-content-primary-button-background-active: ${accent_hover} !important;
  --in-content-primary-button-text-color: ${accent_text} !important;
  --input-color: ${urlbar_text} !important;
  --input-border-color: ${border} !important;
  --focus-outline-color: ${accent} !important;
}
]],
		vim.tbl_extend("error", extra.vars(c, M.roles(c)), {
			label = extra.extras.zen.label,
			install = extra.extras.zen.install,
		})
	)
end

return M
