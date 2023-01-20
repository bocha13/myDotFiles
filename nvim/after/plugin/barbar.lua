local status_ok, barBar = pcall(require, "bufferline")
if not status_ok then
	return
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      require'bufferline.api'.set_offset(38, '------------- Explorer -------------')
    end
  end
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*',
  callback = function()
    if vim.fn.expand('<afile>'):match('NvimTree') then
      require'bufferline.api'.set_offset(0)
    end
  end
})

local options = {
  animation = false,
  auto_hide = false,
  tabpages = true,
  closable = true,
  clickable = true,
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
  letters = 'asdfjklghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
}

barBar.setup(options)
