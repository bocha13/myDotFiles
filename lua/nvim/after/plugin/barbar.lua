local status_ok, barBar = pcall(require, "bufferline")
if not status_ok then
	return
end

local options = {
  animation = false,
  auto_hide = false,
  tabpages = true,
  closable = true,
  clickable = false,
  diagnostics = {
    {enabled = true}
  },
  highlight_visible = true,
  icons = true,
  icon_custom_colors = false,
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab_modified = '●',
  icon_pinned = '車',
  insert_at_end = true,
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
}

barBar.setup(options)
