local g = vim.g

-- disable providers
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0

-- disable other unused stuff
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_logipat = 1
g.loaded_rrhelper = 1
g.loaded_matchit = 1
g.loaded_man = 1
g.loaded_fzf = 1
g.loaded_tutor = 1
g.loaded_syncolor = 1

require("config")
require("plugins")
