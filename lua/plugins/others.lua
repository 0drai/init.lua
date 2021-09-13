local M = {}
local g = vim.g

local cache = os.getenv('XDG_CACHE_HOME')

M.gutentags = function()
  local tags_dir = string.format('%s/tags', cache)

  if io.open(tags_dir, 'r') == nil then
    os.execute(string.format('mkdir -p %s', tags_dir))
    print('created gutentags dir @ %s', tags_dir)
  end

  -- telescope does only look for local tag files,
  -- which sucks big time
  -- https://github.com/nvim-telescope/telescope.nvim/pull/288
  g.gutentags_cache_dir = tags_dir
  g.gutentags_ctags_extra_args = { '-R' }
end

M.indent_bline = function()
  g.indent_blankline_show_current_context = true
  g.indent_blankline_show_first_indent_level = false
  g.indent_blankline_use_treesitter = true
  g.indent_blankline_filetype_exclude = { 'dashboard', 'telescope' }
end

M.rooter = function()
  g.rooter_silent_chdir = 1
  g.rooter_patterns = {
    '.git',
    'Makefile',
    '.vim',
    'compile_commands.json',
    'CMakeLists.txt',
    '.node_modules',
    'package.json',
    'Cargo.toml',
  }
end

M.matchup = function()
  -- matchup makes cursor movement laggy on older machines,
  -- these options help somewhat
  -- https://github.com/andymass/vim-matchup#deferred-highlighting
  g.matchup_matchparen_deferred = 1
  g.matchup_matchparen_deferred_show_delay = 200
  g.matchup_surround_enabled = 1
end

M.coq = function()
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
end

M.rnvimr = function()
  g.rnvimr_enable_ex = 1
  g.rnvimr_enable_picker = 1
  g.rnvimr_draw_border = 1
  g.rnvimr_hide_gitignore = 1
end

M.zen = function()
  require('zen-mode').setup({
    plugins = { gitsigns = true, tmux = true },

    -- NOTE: https://github.com/folke/zen-mode.nvim/issues/26
    on_open = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.cmd([[IndentBlanklineDisable]])
    end,
    on_close = function()
      vim.opt_local.number = true
      vim.opt_local.relativenumber = true
      vim.cmd([[IndentBlanklineEnable]])
    end,
  })
end

return M
