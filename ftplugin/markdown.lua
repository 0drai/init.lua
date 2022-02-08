local g = vim.g
local c = vim.cmd
local u = require("config.utils")

-- toggle markdownpreview
u.nmap("<localleader>mp", ":MarkdownPreview<CR>")

-- inject vim commands fast
u.nmap("<F1>", "Go<CR><c-o>I<!-- vim: set spelllang=de : --><ESC><c-o>")

-- format with prettier
u.nmap("<F2>", ":!prettier -w % --parser markdown<CR>")

c([[set nofoldenable]])
c([[set spell]])

g.mkdp_browser = "qutebrowser"
g.markdown_folding_disabled = 1
