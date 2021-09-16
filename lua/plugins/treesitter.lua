local ts_parser = require('nvim-treesitter.parsers').get_parser_configs()

ts_parser.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  filetype = 'org',
}

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c',
    'cpp',
    'lua',
    'json',
    'yaml',
    'python',
    'latex',
    'bash',
    'html',
    'typescript',
    'javascript',
    'cmake',
    'bibtex',
    'dockerfile',
    'rust',
    'comment',
    'toml',
    'org',
  },

  highlight = {
    enable = true,
    -- disable = {'org'},
    additional_vim_regex_highlighting = { 'org' },
  },

  textobjects = {
    select = {
      enable = true,
      lookeahead = true,
      keymaps = {
        ['ac'] = '@comment.outer',
        ['ic'] = '@class.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = '.',
      scope_incremental = ';',
      node_decremental = '-',
    },
  },

  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 500,
  },

  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },

  autopairs = { enable = true },
  indent = { enable = true, disable = { 'python' } },
})
