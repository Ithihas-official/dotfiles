local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end
-- SHELL
config.default_prog = { "/bin/zsh" }
-- THEMES
config.color_scheme = "BlulocoDark"
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0
config.bold_brightens_ansi_colors = true
-- WINDOW DECORATION
config.window_decorations = "NONE"
-- options of window decorations "NONE" ,"RESIZE","TITLE"

-- ADD BACKGROUND IMAGE
-- config.window_background_image = '/path/to/wallpaper.jpg'
--
-- config.window_background_image_hsb = {
--   -- Darken the background image by reducing it to 1/3rd
--   brightness = 0.3,
--
--   -- You can adjust the hue by scaling its value.
--   -- a multiplier of 1.0 leaves the value unchanged.
--   hue = 1.0,
--
--   -- You can adjust the saturation also.
--   saturation = 1.0,
-- }
-- FONT
config.warn_about_missing_glyphs = false
config.font = wezterm.font("ZedMono Nerd Font")
config.font_size = 11.0
-- -- You can specify some parameters to influence the font selection;
-- -- for example, this selects a Bold, Italic font variant.
-- config.font =
--   wezterm.font('JetBrains Mono', { weight = 'Bold', italic = true })
-- CURSOR
config.default_cursor_style = "BlinkingBar"
-- SCROLL-BAR
config.enable_scroll_bar = false
--  TAB-BAR
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.tab_max_width = 10
-- TAB ONLY IF MORE THAN ONE
config.hide_tab_bar_if_only_one_tab = true
-- TAB-BAR-TOP-POSITION
config.tab_bar_at_bottom = true
-- WINDOW PADDING
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	-- bottom = 20,
}
-- TAB TITLE
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = " tab " .. tab.tab_index .. " "
	if tab.is_active then
		return {
			{ Text = " " .. title .. " " },
		}
	end
	return title
end)

return config
