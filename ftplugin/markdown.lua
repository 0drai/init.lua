local remap = vim.api.nvim_set_keymap
local default = { noremap = true, silent = true }
local remap_default = function(mode, key, f)
  remap(mode, key, f, default)
end

-- toggle markdownpreview
remap_default('n', '<localleader>mp', ':MarkdownPreview<CR>')

-- inject vim commands fast
remap_default('n', '<F1>', 'Go<CR><c-o>I<!-- vim: set spelllang=de : --><ESC><c-o>')

vim.cmd([[set nofoldenable]])

vim.g.markdown_folding_disabled = 1
vim.g.mkdp_browser = 'qutebrowser'
