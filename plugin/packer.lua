-- bootstrap packer
local execute = vim.api.nvim_command
local fn = vim.fn

-- $XDG_DATA_HOME/nvim/..
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  execute('packadd packer.nvim')
end

local pack = require('packer')

pack.startup(function(use)
  -- packer manages itself
  use({ 'wbthomason/packer.nvim', opt = true })

  -- classics
  use({ 'tpope/vim-repeat', keys = { '.' } })
  use({ 'tpope/vim-surround' })
  use({ 'tpope/vim-fugitive', cmd = { 'Git', 'Gwrite', 'Gedit', 'Gvdiffsplit' } })

  -- align stuff
  use({ 'godlygeek/tabular', cmd = 'Tabularize' })

  -- move reliably to root folder
  use({
    'airblade/vim-rooter',
    config = function()
      require('plugins.others').rooter()
    end,
  })

  use({
    'lambdalisue/suda.vim',
    config = function()
      vim.g.suda_smart_edit = 1
    end,
  })

  -- checking regs with '"', or in insert mode with <c-r>
  use({ 'tversteeg/registers.nvim' })

  -- LSP stuff
  -- does not need lazy loading, since it is already lazy
  use({
    'neovim/nvim-lspconfig',
    config = function()
      require('lsp')
    end,
    wants = 'coq_nvim',
    requires = {
      { 'ray-x/lsp_signature.nvim' }, -- echodoc in good
      { 'brymer-meneses/grammar-guard.nvim', run = ':GrammarInstall' },
      { 'simrat39/rust-tools.nvim' }, -- config for rust
    },
  })

  -- use {
  -- 'dense-analysis/ale',
  -- config = function() require('plugins.ale') end,
  -- requires = 'nathunsmitty/nvim-ale-diagnostic'
  -- }

  -- linter (ale replacement)
  use({
    'mfussenegger/nvim-lint',
    event = 'BufEnter',
    config = function()
      require('plugins.lint')
    end,
  })

  -- format with <space>fa
  use({
    'lukas-reineke/format.nvim',
    cmd = { 'Format', 'FormatWrite' },
    config = function()
      require('plugins.format')
    end,
  })

  -- FZF replacement with in-built LSP features
  use({
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.telescope')
    end,
    cmd = { 'Telescope' },
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-bibtex.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  })

  -- basically vim-commentary in lua
  -- 'gcc' to comment an uncomment stuff
  use({
    'winston0410/commented.nvim',
    config = function()
      require('commented').setup({
        keybindings = { n = 'gc', v = 'gc', nl = 'gcc' },
      })
    end,
  })

  -- colorschemes with support for Treesitter, LSP, and so on
  -- NOTE: load UI plugins after sourcing the colorscheme, for performance
  -- and to overwrite highlight groups properly
  use({
    'marko-cerovac/material.nvim',
    config = function()
      require('plugins.material')
    end,
  })

  use({
    'lukas-reineke/indent-blankline.nvim',
    wants = 'nvim-treesitter',
    after = 'material.nvim',
    config = function()
      require('plugins.others').indent_bline()
    end,
  })

  -- lua statusline
  use({
    'famiu/feline.nvim',
    event = 'BufWinEnter',
    config = "require('plugins.feline')",
    after = 'material.nvim',
    wants = 'gitsigns.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  })

  -- gitgutter replacement
  use({
    'lewis6991/gitsigns.nvim',
    after = 'material.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = "require('plugins.gitsigns')",
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    event = 'CursorHold',
    config = "require('plugins.treesitter')",
    run = ':TSUpdate',
  })

  use({

    'p00f/nvim-ts-rainbow',
    event = 'CursorMoved',
    after = 'nvim-treesitter',
  })

  use({
    'ms-jpq/coq_nvim',
    branch = 'coq',
    config = function()
      require('plugins.others').coq()
    end,
    run = ':COQdeps',
    requires = { { 'ms-jpq/coq.artifacts', branch = 'artifacts' } },
  })

  -- tab in normal to 'exit' strings, lists, etc.
  use({
    'abecodes/tabout.nvim',
    config = function()
      require('plugins.tabout')
    end,
    after = 'coq_nvim',
    wants = 'nvim-treesitter',
    event = 'InsertEnter',
  })

  -- treesitter powered matchup
  -- e.g., detects switch statements blocks and so on
  use({
    'andymass/vim-matchup',
    wants = 'nvim-treesitter',
    event = 'CursorMoved',
    config = function()
      require('plugins.others').matchup()
    end,
  })

  use({
    'windwp/nvim-autopairs',
    after = 'nvim-treesitter',
    config = function()
      require('plugins.nvim-autopairs')
    end,
  })

  -- open agenda with ',oa'
  use({
    'kristijanhusak/orgmode.nvim',
    after = 'coq_nvim',
    branch = 'tree-sitter',
    config = function()
      require('plugins.orgmode')
    end,
  })

  -- goyo replacement
  use({
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    requires = { 'folke/twilight.nvim', cmd = 'ZenMode' },
    config = function()
      require('plugins.others').zen()
    end,
  })

  -- NOTE: symbols-outline has more features than vista, e.g., renaming
  -- but it relies on LSP. Unlike vista which is able to use tags
  use({ 'simrat39/symbols-outline.nvim', opt = true, cmd = { 'SymbolsOutline' } })

  use({
    'beauwilliams/focus.nvim',
    config = function()
      require('focus').setup({
        number = true,
        relativenumber = true,
        hybridnumber = true,
        cursorline = true,
      })
    end,
  })

  use({
    'glepnir/dashboard-nvim',
    event = 'BufWinEnter',
    config = function()
      require('plugins.dashboard')
    end,
  })

  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = { 'markdown', 'md' },
  })

  use({ 'https://github.com/plasticboy/vim-markdown', ft = { 'markdown', 'md' } })

  use({ 'ron89/thesaurus_query.vim', cmd = 'ThesaurusQueryReplaceCurrentWord' })

  use({ 'lervag/vimtex', ft = { 'latex', 'tex' } })
end)
