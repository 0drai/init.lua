local g = vim.g
g.coq_settings = {
  ['keymap.recommended'] = false,
  ['keymap.jump_to_mark'] = '<c-j>',
  ['auto_start'] = 'shut-up',

  ['clients.tmux.enabled'] = false,
  ['clients.tree_sitter.enabled'] = false,
  ['clients.tags.enabled'] = false,

  ['clients.lsp.weight_adjust'] = 0.7,
  ['clients.snippets.weight_adjust'] = 0.5,
  ['clients.paths.weight_adjust'] = 0.4,
  ['clients.buffers.weight_adjust'] = 0.3,

  ['display.icons.mode'] = 'long',
  ['display.pum.source_context'] = { '[', ']' },
  ['display.pum.kind_context'] = { ' ', ' ' },
}

local remap = vim.api.nvim_set_keymap
-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

require('coq_3p')({
  { src = 'nvimlua', short_name = 'nLUA' },
  { src = 'vimtex', short_name = 'vTEX' },
  { src = 'orgmode', short_name = 'ORG' },
})
