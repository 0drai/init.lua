local remap = vim.api.nvim_set_keymap
local default = { noremap = true, silent = true }
local remap_default = function(mode, key, f)
  remap(mode, key, f, default)
end

local saga = require('lspsaga')
saga.init_lsp_saga({
  finder_action_keys = {
    open = '<CR>',
    vsplit = '<C-v>',
    split = '<C-x>',
    quit = 'q',
    scroll_down = '<C-f>',
    scroll_up = '<C-b>',
  },
  code_action_keys = { quit = 'q', exec = '<CR>' },
})

-- saga/lsp stuff
remap_default('n', 'K', ':Lspsaga hover_doc<CR>')

-- scroll down hover doc or scroll in definition preview
remap_default('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")

-- scroll up hover doc
remap_default('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

remap_default('n', '<localleader>ca', ':Lspsaga code_action<CR>')
remap_default('n', '<C-k>', ':Lspsaga signature_help<CR>')
remap_default('n', '<localleader>rn', ':Lspsaga rename<CR>')

remap_default('n', '<C-h>', ':Lspsaga diagnostic_jump_prev<CR>')
remap_default('n', '<C-l>', ':Lspsaga diagnostic_jump_next<CR>')

-- https://github.com/glepnir/lspsaga.nvim/pull/207
remap_default('n', 'gh', ':Lspsaga lsp_finder<CR>')
remap_default('n', 'gp', ':Lspsaga preview_definition<CR>')
remap_default('n', '<localleader>d', ':Lspsaga show_line_diagnostics<CR>')
