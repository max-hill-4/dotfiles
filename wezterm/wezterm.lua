local wezterm = require 'wezterm'
local act = wezterm.action
local tabline = wezterm.plugin.require 'https://github.com/michaelbrusegard/tabline.wez'

local config = wezterm.config_builder()

-- Theme
config.color_scheme = 'Catppuccin Mocha'

-- Font (Nerd Font for tabline icons)
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 12

-- Window
config.window_background_opacity = 1.0
config.enable_scroll_bar = false

-- Tabline plugin
tabline.setup {
  options = {
    icons_enabled = true,
    theme = 'Catppuccin Mocha',
  },
}
tabline.apply_to_config(config)

-- These must come after tabline.apply_to_config to avoid being overridden
config.window_decorations = 'TITLE | RESIZE'
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}
config.window_close_confirmation = 'NeverPrompt'
config.skip_close_confirmation_for_processes_named = {}
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true

-- Cursor
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500

-- Copy/paste: Ctrl+C/V instead of Ctrl+Shift+C/V
config.keys = {
  {
    key = 'c',
    mods = 'CTRL',
    action = act.Multiple {
      act.CopyTo 'Clipboard',
      act.ClearSelection,
    },
  },
  {
    key = 'v',
    mods = 'CTRL',
    action = act.PasteFrom 'Clipboard',
  },
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = act.CopyTo 'Clipboard',
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = act.PasteFrom 'Clipboard',
  },
  -- Ctrl+1-9 to jump to tabs
  { key = '1', mods = 'CTRL', action = act.ActivateTab(0) },
  { key = '2', mods = 'CTRL', action = act.ActivateTab(1) },
  { key = '3', mods = 'CTRL', action = act.ActivateTab(2) },
  { key = '4', mods = 'CTRL', action = act.ActivateTab(3) },
  { key = '5', mods = 'CTRL', action = act.ActivateTab(4) },
  { key = '6', mods = 'CTRL', action = act.ActivateTab(5) },
  { key = '7', mods = 'CTRL', action = act.ActivateTab(6) },
  { key = '8', mods = 'CTRL', action = act.ActivateTab(7) },
  { key = '9', mods = 'CTRL', action = act.ActivateTab(-1) },
}

-- Hyperlinks: click to open in browser
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Disable auto-copy on highlight (selection)
-- Override mouse-up bindings to not copy to clipboard on selection
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelectionOrOpenLinkAtMouseCursor 'PrimarySelection',
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SHIFT',
    action = act.CompleteSelectionOrOpenLinkAtMouseCursor 'PrimarySelection',
  },
  {
    event = { Up = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'PrimarySelection',
  },
  {
    event = { Up = { streak = 3, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'PrimarySelection',
  },
}

-- Default shell
config.default_prog = { 'wsl.exe', '--cd', '~' }

return config