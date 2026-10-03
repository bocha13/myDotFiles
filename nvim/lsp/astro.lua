local mason = vim.fn.stdpath('data') .. '/mason/packages'

local function typescript_lib(root_dir)
  if root_dir and root_dir ~= '' then
    local found = vim.fs.find('node_modules/typescript/lib', {
      path = root_dir,
      upward = true,
      type = 'directory',
    })
    if found[1] and vim.uv.fs_stat(found[1] .. '/typescript.js') then
      return found[1]
    end
  end

  local fallbacks = {
    mason .. '/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib',
    mason .. '/astro-language-server/node_modules/typescript/lib',
  }
  for _, path in ipairs(fallbacks) do
    if vim.uv.fs_stat(path .. '/typescript.js') then
      return path
    end
  end
  return ''
end

return {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = { 'astro.config.mjs', 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  init_options = {
    typescript = {
      tsdk = mason .. '/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib',
    },
  },
  before_init = function(_, config)
    config.init_options.typescript.tsdk = typescript_lib(config.root_dir)
  end,
}
