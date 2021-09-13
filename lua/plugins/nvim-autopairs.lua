local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ check_ts = true, fast_wrap = { map = '<C-e>', end_key = '<C-e>' } })

-- require('nvim-treesitter.configs').setup {autopairs = {enable = true}}()

-- require("nvim-autopairs.completion.compe").setup({
-- map_cr = true, --  map <CR> on insert mode
-- map_complete = true -- it will auto insert `(` after select function or method item
-- })
--

npairs.setup({ map_bs = false })

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      -- you can change <c-g><c-g> to <c-e> if you don't use other i_CTRL-X modes
      return npairs.esc('<c-g><c-g>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
