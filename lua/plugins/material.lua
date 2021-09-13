require('material').setup({

  contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
  borders = false, -- Enable borders between verticaly split windows

  italics = {
    comments = true, -- Enable italic comments
    keywords = true, -- Enable italic keywords
    functions = true, -- Enable italic functions
    strings = true, -- Enable italic strings
    variables = false, -- Enable italic variables
  },

  contrast_windows = { -- Specify which windows get the contrasted (darker) background
    'terminal', -- Darker terminal background
    'packer', -- Darker packer background
    'qf', -- Darker qf list background
  },

  text_contrast = {
    lighter = false, -- Enable higher contrast text for lighter style
    darker = false, -- Enable higher contrast text for darker style
  },

  disable = {
    background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
    term_colors = true, -- Prevent the theme from setting terminal colors
    eob_lines = false, -- Hide the end-of-buffer lines
  },

  -- black on white completion menu
  custom_highlights = {

    Pmenu = { fg = '#111111', bg = '#FFFFFF' }, -- Popup menu: normal item.
    PmenuSel = { fg = '#000000', bg = '#AAAAAA', style = 'italic' }, -- Popup menu: selected item.
  },
})

vim.g.material_style = 'darker'

vim.cmd([[colorscheme material]])
