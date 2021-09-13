local g = vim.g

g.ale_fixers = {
  lua = { 'lua-format' },
  go = { 'gofmt', 'goimports' },
  javascript = { 'prettier', 'eslint' },
  typescript = { 'prettier', 'eslint' },
  yaml = { 'prettier' },
  sh = { 'shfmt' },
  zsh = { 'shfmt' }, -- :-(
  rust = { 'rustfmt' },
  tex = { 'latexindent' },
  python = { 'yapf' },
}

g.ale_sign_error = ''
g.ale_sign_warning = ''
g.ale_echo_msg_error_str = 'E'
g.ale_echo_msg_warning_str = 'W'
g.ale_virtualtext_prefix = '    '
g.ale_echo_msg_format = '[%linter%] %code% %s [%severity%]'
g.ale_loclist_msg_format = '[%linter%] %s [%severity%]'

g.ale_virtualtext_cursor = 1
g.ale_completion_enabled = 0
g.ale_floating_preview = 0
g.ale_cursor_detail = 0
g.ale_hover_to_preview = 0
g.ale_hover_to_floating_preview = 0
