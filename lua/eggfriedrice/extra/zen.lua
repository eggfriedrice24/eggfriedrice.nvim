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
	-- A userChrome.css that sets Zen's own variables and the Firefox
	-- theme variables underneath them, so toolbars, tabs, the url bar,
	-- sidebar, panels and buttons all take the palette.
	local extra = require("eggfriedrice.extra")
	return util.template(
		[[
/*
 * eggfriedrice for ${label}
 * generated from lua/eggfriedrice/colors.lua by `make extras`; do not edit by hand
 * install: ${install}
 */

:root {
  /* zen */
  --zen-primary-color: ${accent} !important;
  --zen-colors-primary: ${toolbar} !important;
  --zen-colors-secondary: ${frame} !important;
  --zen-colors-tertiary: ${sidebar} !important;
  --zen-colors-border: ${border} !important;
  --zen-dialog-background: ${popup} !important;
  --zen-themed-toolbar-bg: ${toolbar} !important;
  --zen-themed-toolbar-bg-transparent: ${toolbar} !important;
  --zen-main-browser-background: ${frame} !important;
  --zen-main-browser-background-toolbar: ${toolbar} !important;
  --zen-toolbar-element-bg: ${tab_active} !important;
  --zen-urlbar-background: ${urlbar} !important;
  --zen-browser-gradient-base: ${frame} !important;
  --zen-branding-bg: ${accent} !important;

  /* window and toolbars */
  --lwt-accent-color: ${frame} !important;
  --lwt-text-color: ${toolbar_text} !important;
  --toolbar-bgcolor: ${toolbar} !important;
  --toolbar-color: ${toolbar_text} !important;
  --toolbarbutton-icon-fill: ${toolbar_icon} !important;
  --toolbarbutton-hover-background: ${hover} !important;
  --toolbarbutton-active-background: ${hover} !important;
  --chrome-content-separator-color: ${border} !important;

  /* tabs */
  --tab-selected-bgcolor: ${tab_active} !important;
  --tab-selected-textcolor: ${tab_active_text} !important;
  --lwt-tab-text: ${tab_inactive_text} !important;

  /* url bar */
  --toolbar-field-background-color: ${urlbar} !important;
  --toolbar-field-color: ${urlbar_text} !important;
  --toolbar-field-focus-background-color: ${urlbar} !important;
  --toolbar-field-focus-color: ${urlbar_text} !important;
  --toolbar-field-focus-border-color: ${accent} !important;
  --urlbar-box-bgcolor: ${urlbar} !important;
  --urlbar-box-hover-bgcolor: ${hover} !important;
  --urlbar-box-active-bgcolor: ${hover} !important;
  --urlbar-box-text-color: ${urlbar_text} !important;
  --urlbar-box-hover-text-color: ${urlbar_text} !important;
  --urlbar-box-focus-bgcolor: ${urlbar} !important;
  --urlbarView-highlight-background: ${hover} !important;
  --urlbarView-highlight-color: ${urlbar_text} !important;
  --urlbar-popup-url-color: ${link} !important;

  /* panels and sidebar */
  --arrowpanel-background: ${popup} !important;
  --arrowpanel-color: ${popup_text} !important;
  --arrowpanel-border-color: ${border} !important;
  --panel-separator-color: ${border} !important;
  --sidebar-background-color: ${sidebar} !important;
  --sidebar-text-color: ${sidebar_text} !important;
  --lwt-sidebar-background-color: ${sidebar} !important;
  --lwt-sidebar-text-color: ${sidebar_text} !important;

  /* new tab and controls */
  --newtab-background-color: ${newtab} !important;
  --newtab-text-primary-color: ${newtab_text} !important;
  --button-primary-bgcolor: ${accent} !important;
  --button-primary-hover-bgcolor: ${accent_hover} !important;
  --button-primary-active-bgcolor: ${accent_hover} !important;
  --button-primary-color: ${accent_text} !important;
  --button-bgcolor: ${tab_active} !important;
  --button-hover-bgcolor: ${hover} !important;
  --button-color: ${toolbar_text} !important;
  --input-bgcolor: ${urlbar} !important;
  --input-color: ${urlbar_text} !important;
  --input-border-color: ${border} !important;
  --focus-outline-color: ${accent} !important;
  --link-color: ${link} !important;
  --text-color-deemphasized: ${muted} !important;
}
]],
		vim.tbl_extend("error", extra.vars(c, M.roles(c)), {
			label = extra.extras.zen.label,
			install = extra.extras.zen.install,
		})
	)
end

return M
