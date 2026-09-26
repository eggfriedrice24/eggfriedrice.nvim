---@module "eggfriedrice.extra.discord"
---@license MIT

local util = require("eggfriedrice.util")

local M = {}

---Design roles for a chat client. The renderer expands these into
---Discord's "visual refresh" tokens (2025 layout) plus the legacy names
---older builds and BetterDiscord still read.
---@param c table
---@return eggfriedrice.Entry[]
function M.roles(c)
	local _ = c
	return {
		{ "surface_lowest", "bg_dark" },
		{ "surface_lower", "bg" },
		{ "surface_low", "bg_light" },
		{ "chat", "bg" },
		{ "surface_raised", "bg_light" },
		{ "surface_overlay", "selection" },
		{ "modal", "bg_dark" },
		{ "input", "bg_dark" },
		{ "code", "bg_dark" },
		{ "accent_surface", "selection" },
		{ "hover", "selection" },
		{ "border", "fg_gutter" },
		{ "text", "fg" },
		{ "text_muted", "comment" },
		{ "text_subtle", "fg_dark" },
		{ "text_strong", "fg_bright" },
		{ "link", "purple" },
		{ "brand", "yellow" },
		{ "brand_text", "bg" },
		{ "interactive", "fg_dark" },
		{ "interactive_hover", "fg" },
		{ "interactive_active", "fg_bright" },
		{ "icon_muted", "fg_gutter_ui" },
		{ "mention", "yellow" },
		{ "positive", "green" },
		{ "warning", "orange" },
		{ "critical", "red" },
		{ "info", "blue" },
		{ "notification", "red" },
		{ "status_online", "green" },
		{ "status_idle", "orange" },
		{ "status_dnd", "red" },
		{ "status_offline", "fg_gutter_ui" },
		{ "scrollbar_thumb", "fg_gutter" },
		{ "scrollbar_track", "bg_dark" },
		{ "spoiler", "fg_gutter" },
	}
end

-- Brand scale: Discord reads --brand-100 (lightest) to --brand-900
-- (darkest) and --brand-05a to --brand-95a (alpha). Lightness per step,
-- chroma tapering at the ends so the extremes stay clean.
local brand_steps = {
	{ 100, 0.96, 0.05 },
	{ 130, 0.95, 0.06 },
	{ 160, 0.94, 0.07 },
	{ 200, 0.93, 0.08 },
	{ 230, 0.92, 0.09 },
	{ 260, 0.91, 0.10 },
	{ 300, 0.90, 0.11 },
	{ 330, 0.89, 0.12 },
	{ 360, 0.88, 0.13 },
	{ 400, 0.87, 0.14 },
	{ 430, 0.865, 0.15 },
	{ 460, 0.863, 0.155 },
	{ 500, 0.862, 0.157 },
	{ 530, 0.83, 0.155 },
	{ 560, 0.79, 0.15 },
	{ 600, 0.75, 0.145 },
	{ 630, 0.71, 0.14 },
	{ 660, 0.67, 0.13 },
	{ 700, 0.62, 0.12 },
	{ 730, 0.57, 0.11 },
	{ 760, 0.52, 0.10 },
	{ 800, 0.47, 0.09 },
	{ 830, 0.42, 0.08 },
	{ 860, 0.37, 0.07 },
	{ 900, 0.32, 0.06 },
}

---Token to role map for the visual-refresh layout. A value is a role
---name, or `{ role, alpha }` for a translucent token.
local refresh = {
	-- surfaces
	{ "app-frame-background", "surface_lowest" },
	{ "background-base-lowest", "surface_lowest" },
	{ "background-base-lower", "surface_lower" },
	{ "background-base-low", "surface_low" },
	{ "background-secondary-alt", "surface_lower" },
	{ "background-surface-high", "surface_raised" },
	{ "background-surface-higher", "surface_overlay" },
	{ "background-surface-highest", "surface_overlay" },
	{ "bg-surface-raised", "surface_raised" },
	{ "background-gradient-highest", "surface_lowest" },
	{ "home-background", "surface_lower" },
	{ "chat-background", "chat" },
	{ "chat-background-default", "chat" },
	{ "chat-border", "border" },
	{ "background-accent", "accent_surface" },
	{ "card-background-default", "surface_raised" },
	{ "modal-background", "modal" },
	{ "modal-footer-background", "surface_lowest" },
	{ "custom-channel-members-bg", "surface_lower" },
	{ "user-profile-overlay-background", { "surface_lowest", 0.6 } },
	{ "user-profile-overlay-background-hover", { "surface_lowest", 0.8 } },
	{ "background-mod-subtle", { "hover", 0.25 } },
	{ "background-mod-normal", { "hover", 0.4 } },
	{ "background-mod-strong", { "hover", 0.6 } },
	{ "background-mod-muted", { "hover", 0.15 } },
	{ "border-subtle", { "border", 0.3 } },
	{ "border-muted", { "border", 0.45 } },
	{ "border-normal", { "border", 0.6 } },
	{ "border-strong", "border" },
	-- text
	{ "text-default", "text" },
	{ "text-strong", "text_strong" },
	{ "text-muted", "text_muted" },
	{ "text-subtle", "text_subtle" },
	{ "text-link", "link" },
	{ "text-brand", "brand" },
	{ "chat-text-muted", "text_muted" },
	{ "text-feedback-positive", "positive" },
	{ "text-feedback-warning", "warning" },
	{ "text-feedback-critical", "critical" },
	{ "text-feedback-info", "info" },
	{ "textbox-markdown-syntax", "text_muted" },
	{ "channels-default", "text_subtle" },
	{ "channel-icon", "icon_muted" },
	{ "channel-text-area-placeholder", "text_muted" },
	-- icons and interactives
	{ "icon-default", "interactive" },
	{ "icon-strong", "text_strong" },
	{ "icon-subtle", "text_muted" },
	{ "icon-muted", "icon_muted" },
	{ "icon-voice-muted", "critical" },
	{ "icon-feedback-positive", "positive" },
	{ "icon-feedback-warning", "warning" },
	{ "icon-feedback-critical", "critical" },
	{ "icon-feedback-info", "info" },
	{ "icon-feedback-notification", "notification" },
	{ "interactive-text-default", "interactive" },
	{ "interactive-text-hover", "interactive_hover" },
	{ "interactive-text-active", "interactive_active" },
	{ "interactive-icon-default", "interactive" },
	{ "interactive-icon-hover", "interactive_hover" },
	{ "interactive-icon-active", "interactive_active" },
	{ "interactive-muted", "icon_muted" },
	{ "interactive-background-hover", { "hover", 0.4 } },
	{ "interactive-background-selected", { "hover", 0.6 } },
	{ "interactive-background-active", { "hover", 0.8 } },
	-- inputs and messages
	{ "input-background-default", "input" },
	{ "input-text-default", "text" },
	{ "input-placeholder-text-default", "text_muted" },
	{ "input-border-default", { "border", 0.6 } },
	{ "channeltextarea-background", "input" },
	{ "background-code", "code" },
	{ "message-background-hover", { "hover", 0.2 } },
	{ "message-mentioned-background-default", { "mention", 0.1 } },
	{ "message-mentioned-background-hover", { "mention", 0.15 } },
	{ "message-highlight-background-default", { "mention", 0.1 } },
	{ "message-highlight-background-hover", { "mention", 0.15 } },
	{ "message-automod-background-default", { "critical", 0.1 } },
	{ "message-automod-background-hover", { "critical", 0.15 } },
	{ "message-reacted-background-default", { "brand", 0.15 } },
	{ "message-reacted-text-default", "brand" },
	{ "mention-foreground", "mention" },
	{ "mention-background", { "mention", 0.2 } },
	{ "spoiler-hidden-background", "spoiler" },
	{ "spoiler-revealed-background", { "spoiler", 0.3 } },
	-- brand and controls
	{ "control-brand-foreground", "brand" },
	{ "control-brand-foreground-new", "brand" },
	{ "logo-primary", "brand" },
	{ "badge-text-brand", "brand_text" },
	{ "control-primary-background-default", "brand" },
	{ "control-primary-background-hover", "brand" },
	{ "control-primary-background-active", "brand" },
	{ "control-secondary-background-default", "surface_raised" },
	{ "control-secondary-background-hover", "surface_overlay" },
	{ "control-secondary-background-active", "surface_overlay" },
	{ "control-secondary-border-default", { "border", 0.6 } },
	{ "control-secondary-text-default", "text" },
	{ "control-secondary-text-hover", "text_strong" },
	{ "control-critical-primary-background-default", "critical" },
	{ "control-critical-primary-background-hover", "critical" },
	{ "control-critical-primary-background-active", "critical" },
	{ "control-critical-primary-text-default", "text_strong" },
	{ "control-critical-primary-text-hover", "text_strong" },
	{ "control-critical-secondary-background-default", { "critical", 0.1 } },
	{ "control-critical-secondary-background-hover", { "critical", 0.2 } },
	{ "control-critical-secondary-background-active", { "critical", 0.3 } },
	{ "control-critical-secondary-border-default", { "critical", 0.5 } },
	{ "control-critical-secondary-border-hover", "critical" },
	{ "control-critical-secondary-border-active", "critical" },
	{ "control-critical-secondary-text-default", "critical" },
	{ "control-critical-secondary-text-hover", "critical" },
	{ "control-critical-secondary-text-active", "critical" },
	{ "control-connected-background-default", "positive" },
	{ "control-connected-background-hover", "positive" },
	{ "control-connected-background-active", "positive" },
	{ "control-connected-border-default", "positive" },
	{ "control-connected-border-hover", "positive" },
	{ "control-connected-border-active", "positive" },
	{ "button-outline-primary-text", "text" },
	{ "button-outline-brand-text", "brand" },
	{ "button-outline-brand-background-hover", { "brand", 0.15 } },
	{ "button-outline-brand-border-active", "brand" },
	{ "checkbox-icon-active", "brand" },
	{ "checkbox-border-default", "icon_muted" },
	{ "radio-thumb-background-active", "brand" },
	-- status and feedback
	{ "status-positive", "positive" },
	{ "status-positive-background", "positive" },
	{ "status-positive-text", "brand_text" },
	{ "status-warning", "warning" },
	{ "status-warning-background", "warning" },
	{ "status-warning-text", "brand_text" },
	{ "status-danger", "critical" },
	{ "background-feedback-positive", { "positive", 0.15 } },
	{ "background-feedback-warning", { "warning", 0.15 } },
	{ "background-feedback-critical", { "critical", 0.15 } },
	{ "background-feedback-info", { "info", 0.15 } },
	{ "background-feedback-notification", "notification" },
	{ "badge-notification-background", "notification" },
	{ "icon-status-online", "status_online" },
	{ "icon-status-idle", "status_idle" },
	{ "icon-status-dnd", "status_dnd" },
	{ "icon-status-offline", "status_offline" },
	{ "text-status-online", "status_online" },
	{ "text-status-idle", "status_idle" },
	{ "text-status-dnd", "status_dnd" },
	{ "text-status-offline", "status_offline" },
	{ "notice-background-positive", { "positive", 0.2 } },
	{ "notice-background-warning", { "warning", 0.2 } },
	{ "notice-background-critical", { "critical", 0.2 } },
	{ "notice-background-info", { "info", 0.2 } },
	{ "notice-text-positive", "positive" },
	{ "notice-text-warning", "warning" },
	{ "notice-text-critical", "critical" },
	{ "notice-text-info", "info" },
	-- scrollbars and named colors Discord still reads directly
	{ "scrollbar-thin-thumb", "scrollbar_thumb" },
	{ "scrollbar-thin-track", "scrollbar_track" },
	{ "scrollbar-auto-thumb", "scrollbar_thumb" },
	{ "scrollbar-auto-track", "scrollbar_track" },
	{ "scrollbar-auto-scrollbar-color-thumb", "scrollbar_thumb" },
	{ "scrollbar-auto-scrollbar-color-track", "scrollbar_track" },
	{ "green-300", "positive" },
	{ "green-360", "positive" },
	{ "yellow-300", "brand" },
	{ "yellow-360", "brand" },
	{ "red-400", "critical" },
	{ "red-430", "critical" },
	{ "red-500", "critical" },
	{ "blue-500", "info" },
	{ "blue-530", "info" },
	{ "white", "text_strong" },
	{ "white-500", "text_strong" },
	{ "black-500", "surface_lowest" },
	{ "primary-100", "text_strong" },
	{ "primary-200", "text" },
	{ "primary-300", "text_subtle" },
	{ "primary-400", "text_muted" },
	{ "primary-630", "surface_low" },
	{ "primary-700", "surface_lower" },
	{ "primary-800", "surface_lowest" },
}

---Legacy tokens for older builds and BetterDiscord.
local legacy = {
	{ "background-primary", "chat" },
	{ "background-secondary", "surface_lower" },
	{ "background-secondary-alt", "surface_lower" },
	{ "background-tertiary", "surface_lowest" },
	{ "background-floating", "modal" },
	{ "background-mobile-primary", "chat" },
	{ "background-mobile-secondary", "surface_lower" },
	{ "background-modifier-hover", { "hover", 0.4 } },
	{ "background-modifier-active", { "hover", 0.6 } },
	{ "background-modifier-selected", { "hover", 0.6 } },
	{ "background-modifier-accent", { "border", 0.5 } },
	{ "text-normal", "text" },
	{ "text-muted", "text_muted" },
	{ "text-link", "link" },
	{ "header-primary", "text_strong" },
	{ "header-secondary", "text_subtle" },
	{ "interactive-normal", "interactive" },
	{ "interactive-hover", "interactive_hover" },
	{ "interactive-active", "interactive_active" },
	{ "interactive-muted", "icon_muted" },
	{ "channeltextarea-background", "input" },
	{ "brand-experiment", "brand" },
	{ "brand-experiment-560", "brand" },
	{ "scrollbar-thin-thumb", "scrollbar_thumb" },
	{ "scrollbar-auto-thumb", "scrollbar_thumb" },
	{ "scrollbar-auto-track", "scrollbar_track" },
}

---@param c table
---@return string
function M.generate(c)
	local extra = require("eggfriedrice.extra")
	local roles = M.roles(c)
	local function color(spec)
		if type(spec) == "table" then
			return util.rgba(extra.hex(c, extra.role(roles, spec[1])), spec[2])
		end
		return extra.hex(c, extra.role(roles, spec))
	end
	local function block(selector, tokens, important)
		local lines = { selector .. " {" }
		for _, t in ipairs(tokens) do
			lines[#lines + 1] = ("  --%s: %s%s;"):format(t[1], color(t[2]), important and " !important" or "")
		end
		lines[#lines + 1] = "}"
		return table.concat(lines, "\n")
	end
	local brand = {}
	local yellow = extra.hex(c, extra.role(roles, "brand"))
	for _, step in ipairs(brand_steps) do
		brand[#brand + 1] = ("  --brand-%d: %s;"):format(step[1], util.tint(yellow, step[2], step[3]))
	end
	for a = 5, 95, 5 do
		brand[#brand + 1] = ("  --brand-%02da: %s;"):format(a, util.rgba(yellow, a / 100))
	end
	return table.concat({
		"/**",
		" * @name eggfriedrice",
		" * @author eggfriedrice24",
		" * @version 1.0.0",
		" * @description Yolk-yellow accents, rice-cream text and navy surfaces for Discord.",
		" * @source https://github.com/eggfriedrice24/eggfriedrice.nvim",
		" */",
		"",
		"/*",
		" * eggfriedrice for " .. extra.extras.discord.label,
		" * generated from lua/eggfriedrice/colors.lua by `make extras`; do not edit by hand",
		" * install: " .. extra.extras.discord.install,
		" */",
		"",
		"/* brand scale derived from the signature yellow */",
		".visual-refresh.theme-dark,\n.visual-refresh .theme-dark,\n.theme-dark {\n"
			.. table.concat(brand, "\n")
			.. "\n}",
		"",
		"/* visual refresh tokens (current layout) */",
		block(".visual-refresh.theme-dark,\n.visual-refresh .theme-dark", refresh, true),
		"",
		"/* legacy tokens (older builds, BetterDiscord) */",
		block(".theme-dark", legacy, false),
		"",
	}, "\n")
end

return M
