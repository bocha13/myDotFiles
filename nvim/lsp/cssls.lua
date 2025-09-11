return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_markers = { 'package.json', '.git' },
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      },
      modules = true -- Enable CSS modules
    },
    scss = { validate = true },
    less = { validate = true },
  },
}
