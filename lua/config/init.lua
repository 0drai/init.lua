local o = vim.opt
local g = vim.g

-- python to conda
g.python3_host_prog = os.getenv("CONDA_PYTHON_EXE")

-- read file changes automatically
o.autoread = true
o.title = true
o.cursorline = true
o.hidden = true

-- always show status line
o.laststatus = 2
o.signcolumn = "auto:2"

-- disable completion messages
o.shortmess = vim.o.shortmess .. "c"
g.relativenumber = true
g.number = true
o.splitright = true
o.splitbelow = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true
o.magic = true
o.ignorecase = true
-- unnamedplus = use the + register (cmd-v paste in our term)
o.clipboard = { "unnamed", "unnamedplus" }

-- enable wrap on long lines
o.wrap = true
o.wildmenu = true
o.wildmode = "longest:full,full"
o.wildignorecase = true
o.wildignore = {
	"*.swp",
	"*.bak",
	"*.pyc",
	"*.class",
	"*.aux",
	"*toc",
	"*blg",
	"*.bcf",
	"*bbl",
	"*.tdo",
	"*.bin",
	"*.so",
	"*.rlib",
	"*_build/*",
	"*build/*",
	"*/coverage/*",
}

-- not breaking words on line wrap
o.linebreak = true

-- scroll vertically/horizontally
o.scrolloff = 10
o.sidescrolloff = 20
o.sidescroll = 1

-- indentations
o.shiftwidth = 2 -- indent by 1 column
o.shiftround = true -- tab indent to nearest level
o.textwidth = 79 -- max pasted text width
o.autoindent = true -- copy indent from current line
o.smartindent = true -- enable c-style indenting in c/c++ files
o.tabstop = 2 -- indent level every column
o.softtabstop = 2 -- tab indent when mixing spaces and tabs
o.expandtab = true -- convert tabs to spaces

-- disable backups and swap files
o.backup = false
o.writebackup = false
o.swapfile = false
o.lazyredraw = true

vim.cmd([[set termguicolors]])

require("config.autocmd")
require("config.mappings")
