require("config.keymaps")
require("config.settings")
require("config.lazy")

-- this is to have yank in wsl requires the following dependencies

-- install win32yank in WSL:
-- curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip
-- unzip -p /tmp/win32yank.zip win32yank.exe > ~/.local/bin/win32yank.exe
-- chmod +x ~/.local/bin/win32yank.exe

--then add this to the path:
-- export PATH="$HOME/.local/bin:$PATH"


if vim.fn.executable('win32yank.exe') == 1 then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = false,
  }
end
