local u = require("config.utils")

vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- wrap
u.nmap("0", "^")
u.vmap("0", "^")
u.nmap("j", "gj")
u.nmap("k", "gk")

-- quit buffer fast
u.nmap("gQ", ":q!<CR>")
u.nmap("gx", ":x!<CR>")

-- fast spell replacement
u.nmap("zz", "1z=")
u.nmap("<F3>", ":set spell!<CR>")

-- yank till end of line
u.nmap("Y", "y$")
u.nmap("vv", "v$")

-- current date with F5
u.imap("<F5>", '<C-R>=strftime("%Y-%m-%d")<CR>')
u.nmap("<F5>", '"=strftime("%Y-%m-%d")<CR>P')

-- Resize Splits faster
u.nmap("<localleader><", string.rep("<C-w><", 7))
u.nmap("<localleader>>", string.rep("<C-w>>", 7))
u.nmap("<localleader>-", string.rep("<C-w>-", 7))
u.nmap("<localleader>+", string.rep("<C-w>+", 7))
u.nmap("<localleader>=", "<C-w>=")

-- add new line under and above cursor
u.nmap("<Enter>", "o<ESC>")
u.nmap("<localleader><Enter>", "O<ESC>")

-- Switch CWD to the directory of the open buffer
u.nmap("<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

--- move lines around
u.vmap("<localleader>k", ":m'<-2<CR>`>my`<mzgv`yo`z")
u.vmap("<localleader>j", ":m'>+<CR>`<my`>mzgv`yo`z")
u.nmap("<localleader>k", "mz:m-2<CR>`z")
u.nmap("<localleader>j", "mz:m+<CR>`z")

-- clears last search highlighting
u.nmap("<Esc><Esc>", ':let @/=""<CR>')

-- jk, but usually its C-c
u.imap("jk", "<ESC>")

-- Quick edit vimrc in vertical split
u.nmap("<leader>ev", ":vsplit $MYVIMRC<CR>")

-- remap exit mode to macro in register 1
u.nmap("Q", "@1")

-- jump to marks
u.nmap("<leader>1", "'1")
u.nmap("<leader>2", "'2")
u.nmap("<leader>3", "'3")
u.nmap("<leader>4", "'4")

-- toggle symbols outline
u.nmap("<localleader>v", ":SymbolsOutline<CR>")

-- toggle twillight
u.nmap("<localleader>z", ":ZenMode<CR>")

-- formatter
u.nmap("<localleader>fa", ":Format<CR>")

u.nmap("<localleader>b", ":split $MASTERBIB<CR>")
u.nmap("<localleader>ng", ':lua require("neogen").generate()<CR>')

-- fugitive stuff
u.nmap("<localleader>gg", ":Gvdiffsplit! HEAD~1:%<CR>") -- diff file with last commit
u.nmap("<localleader>gs", ":Git<CR>") -- mvp
u.nmap("<localleader>gP", ":Git push<CR>")
u.nmap("<localleader>gd", ":Gvdiffsplit!<CR>")
u.nmap("<localleader>dg", ":diffget<CR>")
u.nmap("<localleader>dp", ":diffput<CR>")

-- nothing beats netrw
u.nmap("<localleader>te", ":Texplore<CR>")
u.nmap("<localleader>se", ":Sexplore<CR>")
u.nmap("<localleader>ee", ":Explore<CR>")

u.nmap("<localleader>co", ":copen<CR>")
u.nmap("<localleader>cc", ":cclose<CR>")
u.nmap("<localleader>cn", ":cnext<CR>")
u.nmap("<localleader>cp", ":cprev<CR>")
