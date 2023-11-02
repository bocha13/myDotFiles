-- function to create autogroups
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- remove auto comment on new line after comment
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = augroup("general"),
  desc = "Disable New Line Comment",
})

-- go to github repo for selected text
vim.api.nvim_create_user_command("OpenGithubRepo", function(_)
  local ghpath = vim.api.nvim_eval("shellescape(expand('<cfile>'))")
  local formathpath = ghpath:sub(2, #ghpath - 1)
  local repourl = "https://www.github.com/" .. formathpath
  vim.fn.system({ "xdg-open", repourl })
end, {
  desc = "Open Github Repo",
  force = true,
})

-- make nvim detect Jenkinsfile as groovy for syntax highlighting
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("setlocal filetype=groovy")
  end,
  group = augroup("general"),
  pattern = "Jenkinsfile",
  desc = "Set Jenkinsfile filetype",
})
