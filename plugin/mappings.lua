vim.g.mapleader = ","
vim.g.maplocalleader = " "

local remap = vim.api.nvim_set_keymap
local default = { noremap = true, silent = true }

local remap_default = function(mode, key, f)
	remap(mode, key, f, default)
end

-- wrap
remap_default("n", "0", "^")
remap_default("v", "0", "^")
remap_default("n", "j", "gj")
remap_default("n", "k", "gk")

-- quit buffer fast
remap_default("n", "gQ", ":q!<CR>")
remap_default("n", "gx", ":x!<CR>")

-- fast spell replacement
remap_default("n", "zz", "1z=")
remap_default("n", "<F3>", ":set spell!<CR>")

-- yank till end of line
remap_default("n", "Y", "y$")

-- current date with F5
remap_default("i", "<F5>", '<C-R>=strftime("%Y-%m-%d")<CR>')
remap_default("n", "<F5>", '"=strftime("%Y-%m-%d")<CR>P')

-- Resize Splits faster
remap_default("n", "<localleader><", string.rep("<C-w><", 7))
remap_default("n", "<localleader>>", string.rep("<C-w>>", 7))
remap_default("n", "<localleader>-", string.rep("<C-w>-", 7))
remap_default("n", "<localleader>+", string.rep("<C-w>+", 7))
remap_default("n", "<localleader>=", "<C-w>=")

-- add new line under and above cursor
remap_default("n", "<Enter>", "o<ESC>")
remap_default("n", "<localleader><Enter>", "O<ESC>")

-- Switch CWD to the directory of the open buffer
remap_default("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

--- move lines around
remap_default("v", "<localleader>k", ":m'<-2<CR>`>my`<mzgv`yo`z")
remap_default("v", "<localleader>j", ":m'>+<CR>`<my`>mzgv`yo`z")
remap_default("n", "<localleader>k", "mz:m-2<CR>`z")
remap_default("n", "<localleader>j", "mz:m+<CR>`z")

-- clears last search highlighting
remap_default("n", "<Esc><Esc>", ':let @/=""<CR>')

-- jk, but usually its C-c
remap_default("i", "jk", "<ESC>")

-- Quick edit vimrc in vertical split
remap_default("n", "<leader>ev", ":vsplit $MYVIMRC<CR>")

-- remap exit mode to macro in register 1
remap_default("n", "Q", "@1")

-- jump to marks
remap_default("n", "<leader>1", "'1")
remap_default("n", "<leader>2", "'2")
remap_default("n", "<leader>3", "'3")
remap_default("n", "<leader>4", "'4")

-- toggle symbols outline
remap_default("n", "<localleader>v", ":SymbolsOutline<CR>")

-- toggle twillight
remap_default("n", "<localleader>z", ":ZenMode<CR>")

-- formatter
remap_default("n", "<localleader>fa", ":Format<CR>")

local telescope_remap = function(key, f)
	remap_default("n", key, string.format(":Telescope %s<CR>", f))
end

-- Telescope
telescope_remap("<leader>p", "fd")
telescope_remap("<leader>b", "buffers")
telescope_remap("<leader>B", "bibtex")
telescope_remap("<leader>l", "current_buffer_fuzzy_find")
telescope_remap("<leader>m", "marks")
telescope_remap("<leader>M", "man_pages")
telescope_remap("<leader>?", "oldfiles")
telescope_remap("<leader>r", "live_grep")
telescope_remap("<leader>gc", "git_bcommits")
telescope_remap("<leader>gf", "git_files")
telescope_remap("<leader>z", "spell_suggest")
telescope_remap("<leader>d", "lsp_document_diagnostics")
telescope_remap("<leader>D", "lsp_workspace_diagnostics")
telescope_remap("<leader>t", "lsp_document_symbols")
telescope_remap("<leader>T", "lsp_workspace_symbols")
telescope_remap("gr", "lsp_references")

telescope_remap("<leader>O", "find_files cwd=" .. os.getenv("ORGMODE"))
telescope_remap("<leader>Z", "find_files cwd=" .. os.getenv("ZK"))
telescope_remap("<leader>C", "find_files cwd=" .. os.getenv("XDG_CONFIG_HOME"))
telescope_remap("<leader>N", "find_files cwd=" .. os.getenv("XDG_CONFIG_HOME") .. "nvim")

remap_default("n", "<leader>y", ':lua require("telescope").extensions.neoclip.default()<CR>')
remap_default("n", "<F2>", ':lua require("neogen").generate()<CR>')

-- fugitive stuff
remap_default("n", "<localleader>gg", ":Gvdiffsplit! HEAD~1:%<CR>") -- diff file with last commit
remap_default("n", "<localleader>gs", ":Git<CR>") -- mvp
remap_default("n", "<localleader>gP", ":Git push<CR>")
remap_default("n", "<localleader>gd", ":Gvdiffsplit!<CR>")
remap_default("n", "<localleader>dg", ":diffget<CR>")
remap_default("n", "<localleader>dp", ":diffput<CR>")

-- nothing beats netrw
remap_default("n", "<localleader>te", ":Texplore<CR>")
remap_default("n", "<localleader>se", ":Sexplore<CR>")
remap_default("n", "<localleader>ee", ":Explore<CR>")
