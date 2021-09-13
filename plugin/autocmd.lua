local api = vim.api

-- Taken from https://github.com/norcalli/nvim_utils
local create_augroups = function(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup ' .. group_name)
    api.nvim_command('autocmd!')
    -- for _, def in ipairs(definition) do
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

local autocmds = {
  -- disable highlighting of search result after entering insert mode
  toggle_search_highlighting = { { 'InsertEnter', '*', ':nohl | redraw' } },
  lua_highlight = {
    { 'TextYankPost', '*', 'silent! lua vim.highlight.on_yank{timeout=500}' },
  },
  -- return to last position
  retlast = {
    {
      'BufReadPost',
      '*',
      [[
     if line("'\"") > 0 && line("'\"") <= line("$") |
       exe "normal! g`\"" |
     endif
    ]],
    },
  },
  -- auto compile packer after saving it
  packer_compile = {
    {
      'BufWritePost',
      'plugins.lua',
      [[source <afile> | PackerCompile | echomsg 'packer compiled!']],
    },
  },
  -- delete tailing white spaces on save
  delws = { { 'BufWritePre', '*', [[%s/\s\+$//e]] } },

  spell_leave = { { 'BufLeave', '*', 'set nospell' } },

  quit = {
    { 'FileType', 'dashboard,help', [[nnoremap <silent> <buffer> q :q<CR>]] },
  },

  dash_enter = { { 'FileType', 'dashboard', [[IndentBlanklineDisable]] } },
}

create_augroups(autocmds)
