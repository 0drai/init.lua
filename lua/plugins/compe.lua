local remap = vim.api.nvim_set_keymap
vim.o.completeopt = 'menuone,noselect'
vim.opt.pumheight = 15

require('compe').setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 2,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  documentation = true,

  source = {
    buffer = { enable = true, priority = 1 },
    -- NOTE: its really bad though
    spell = {
      enable = true,
      priority = 5,
      filetypes = { 'markdown', 'text', 'tex', 'vimwiki' },
    },
    -- treesitter = {enable = true, priority = 7, menu = '[TS]'},
    tags = { enable = true, priority = 6 },
    nvim_lsp = { enable = true, priority = 8 },
    luasnip = { enable = true, priority = 9, menu = '[SNP]' },
    path = { enable = true, priority = 10 },
    omni = { filetypes = { 'tex' } },

    nvim_lua = false,
    vsnip = false,
    calc = false,
    snippets_nvim = false,

    -- neorg = true
    orgmode = true,
  },
})

require('luasnip').config.set_config({ history = true })

require('luasnip/loaders/from_vscode').load()

-- compe/tab completion
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-n>')
  elseif require('luasnip').expand_or_jumpable() then
    return t("<cmd>lua require'luasnip'.jump(1)<Cr>")
  elseif check_back_space() then
    return t('<Tab>')
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-p>')
  elseif require('luasnip').jumpable(-1) then
    return t("<cmd>lua require'luasnip'.jump(-1)<CR>")
  else
    return t('<S-Tab>')
  end
end

remap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
remap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
remap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
remap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

remap('i', '<C-Space>', 'compe#complete()', { silent = true, expr = true })
remap('i', '<CR>', "compe#confirm('<CR>')", { silent = true, expr = true })
remap('i', '<C-e>', "compe#close('<C-e>')", { silent = true, expr = true })
remap('i', '<C-f>', "compe#scroll({ 'delta': +4 })", { silent = true, expr = true })
remap('i', '<C-b>', "compe#scroll({ 'delta': -4 })", { silent = true, expr = true })
