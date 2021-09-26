local lint = require('lint')

lint.linters_by_ft = {
  c = { 'clangtidy', 'cppcheck', 'codespell' },
  sh = { 'shellcheck', 'codespell' },
  lua = { 'codespell' },
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  python = { 'codespell' },
  dockerfile = { 'hadolint', 'codespell' },
  bash = { 'shellcheck', 'codespell' },
  tex = { 'vale', 'chktex' },
  -- text = {'languagetool'},
  markdown = { 'markdownlint' },
  vimwiki = { 'markdownlint' },
}

vim.cmd([[au BufWritePost <buffer> lua require('lint').try_lint() ]])
vim.cmd([[au BufEnter <buffer> lua require('lint').try_lint() ]])
