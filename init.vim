" vim:set et sw=2 ts=2 fdm=marker fdl=1:

" install plug.vim if not available
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_auto_install
    autocmd!
    au VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

let g:ale_disable_lsp = 1

call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-rooter'
Plug 'vim-scripts/YankRing.vim'
Plug 'godlygeek/tabular'
Plug 'ludovicchabant/vim-gutentags'
Plug 'itchyny/lightline.vim'
Plug 'sainnhe/sonokai'
Plug 'machakann/vim-swap'
Plug 'lervag/vimtex'
call plug#end()

let g:python3_host_prog = '/usr/bin/python3'

" File encoding
set encoding=utf-8
set fileencodings=utf-8

set hidden
set title
set cursorline

" always show statusline
set laststatus=2

set number
set relativenumber

" split the right waay
set splitright
set splitbelow

" set search and ignore case
set ignorecase
set incsearch
set hlsearch
set magic

" copying and pasting
set clipboard+=unnamedplus

" Indentations
set shiftwidth=2
set tabstop=2
set softtabstop=2
set textwidth=79
set autoindent
set smartindent
set expandtab
set smarttab

" set linebreak at characters 'breakat'
set linebreak
set breakat=\ \	;:,!?

"Start scrolling when we're 10 lines away from margins
set scrolloff=10
set sidescrolloff=20
set sidescroll=1

" set shell to bash
set shell=/bin/bash
set shortmess+=c
set signcolumn=yes
set updatetime=300

" complete config
set complete+=k
set complete-=t
set completeopt=menu,preview,noinsert

" ignore these files
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildignore+=*.aux,*toc,*blg,*.bcf,*bbl,*.tdo
set wildignore+=*_build/*
set wildignore+=*build/*
set wildignore+=*/coverage/*

" let tab trigger auto completion
set wildchar=<Tab> wildmenu wildmode=full

" updates to the file are read
set autoread

augroup retlast
  " Return to last edit position when opening files
  autocmd!
  au BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
augroup END

augroup delws
  " delete whitespaces on save
  autocmd!
  au BufWritePre * %s/\s\+$//e
augroup END

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let ale_virtualtext_cursor = 1
let g:ale_completion_enabled = 0

let b:ale_fixers = {'tex': ['latexindent']}

nmap <silent> <C-h> <Plug>(ale_previous_wrap)
nmap <silent> <C-l> <Plug>(ale_next_wrap)

let mapleader = ','
let maplocalleader = ' '

" Remapping 0 to the first non blank character
noremap 0 ^

" key mapping
noremap j gj
noremap k gk

" add new line under and above cursor
noremap <Enter> o<ESC>
noremap <localleader><Enter> O<ESC>

" exit fast
inoremap jk <ESC>

" quit buffer fast
noremap gQ :q!<CR>
noremap gx :x!<CR>

" searches for current selections
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" move lines around
vmap <localleader>k :m'<-2<cr>`>my`<mzgv`yo`z
nmap <localleader>k mz:m-2<cr>`z
nmap <localleader>j mz:m+<cr>`z
vmap <localleader>j :m'>+<cr>`<my`>mzgv`yo`z

" clears last search highlighting
nnoremap <silent> <Esc><Esc> :let @/=""<CR>

" Quick edit vimrc in vertical split
noremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
noremap <silent> <leader>es :so $MYVIMRC<CR>

" open yankring
noremap <silent> <Leader>y :YRShow<CR>

" jump to marks
noremap <leader>1 '1
noremap <leader>2 '2
noremap <leader>3 '3
noremap <leader>4 '4

nnoremap <silent> <leader>p :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>m :Marks<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>r :RG<CR>
nnoremap <silent> <leader>gc :BCommits<CR>
nnoremap <silent> <leader>gg :GGrep<CR>
nnoremap <silent> <leader>gf :GFiles<CR>

let g:fzf_tags_command = 'ctags -R'

imap <C-x><C-f> <plug>(fzf-complete-file)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=? -complete=dir GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" Using floating windows of Neovim to start fzf
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'

  function! FloatingFZF()
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

" gutentags dir
let gutentags_dir = $HOME . '/.cache/tags'
if !isdirectory(expand(gutentags_dir))
  call mkdir(gutentags_dir, 'p')
  echo 'created gutentags directory @ ' . gutentags_dir
endif
let g:gutentags_cache_dir = gutentags_dir

" Yankring {
let yankring_dir = $HOME . '/.cache/yankring'
if !isdirectory(expand(yankring_dir))
  call mkdir(yankring_dir, 'p')
  echo 'created yankring directory @ ' . yankring_dir
endif
let g:yankring_history_dir = yankring_dir
" }

" vimtex
let g:smart_display_opts                  = { 'column' : 80 }
let g:vimtex_quickfix_mode                = '0'
let g:vimtex_view_general_viewer          = 'okular'
let g:vimtex_view_general_options         = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:tex_flavor                          = 'latex'

augroup latex_clean
  " runs 'latexmk -c' after quitting
  autocmd!
  au User VimtexEventQuit VimtexClean
augroup END

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! CocGitStatus()
    return get(g:, 'coc_git_status', '')
endfunction

function! LightlineReadonly()
    return &readonly ? '🔒' : ''
endfunction

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

" Show full path of filename
function! FilePath()
    return expand('%')
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? ' ✓ ' : printf(
    \   '%d   %d  ',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [
      \             [ 'mode', 'paste'],
      \             ['gitbranch', 'blame'],
      \             ['perm', 'filename', 'modified', 'cocstatus', 'lint']
      \           ],
      \ },
      \ 'component' : {
      \   'lineinfo' : ' %3l:%-2v'
      \},
      \ 'component_function' : {
      \   'perm'             : 'LightlineReadonly',
      \   'filename'         : 'FilePath',
      \   'gitbranch'        : 'CocGitStatus',
      \   'cocstatus'        : 'coc#status',
      \   'blame'            : 'LightlineGitBlame',
      \   'lint'             : 'LinterStatus'
      \ },
      \ }

let g:lightline.colorscheme	= 'sonokai'

let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}

let g:lightline.subseparator = {
	\   'left': '', 'right': ''
  \}

augroup coc_lightline_update
  " Use autocmd to force lightline update.
  autocmd!
  au User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END

let g:coc_global_extensions = [
            \'coc-emoji',
            \'coc-json',
            \'coc-python',
            \'coc-sh',
            \'coc-git',
            \'coc-clangd',
            \'coc-markdownlint',
            \'coc-snippets']

" Use <C-l> for trigger snippet expand.
imap <C-j> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <localleader>x for convert visual selected code to snippet
xmap <localleader>x  <Plug>(coc-convert-snippet)

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

" show chunk diff at current position
nmap <localleader>gd <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap <localleader>gc <Plug>(coc-git-commit)

" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

" toggle git gutter
nnoremap <silent><localleader>gg :CocCommand git.toggleGutters<CR>

" chunk stage
nnoremap <silent><localleader>ga :CocCommand git.chunkStage<CR>

" undo chunk
nnoremap <silent><localleader>gu :CocCommand git.chunkUndo<CR>

" fold unchanged
nnoremap <silent><localleader>gf :CocCommand git.foldUnchanged<CR>

" open in browser
nnoremap <silent><localleader>go :CocCommand git.browserOpen<CR>

" copy url of line
nnoremap <silent><localleader>gy :CocCommand git.copyUrl<CR>

" open fugitive git blame
nnoremap <silent><localleader>gb :Git blame<CR>

" open fugitive git status
nnoremap <silent><localleader>gs :Git<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

" Remap for rename current word
nmap <localleader>rn <Plug>(coc-rename)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap for do codeAction of current line
nmap <localleader>ca  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <localleader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
nnoremap <silent> <localleader>cl :CocList<CR>

" Show all diagnostics
nnoremap <silent> <localleader>cd  :<C-u>CocList diagnostics<cr>

" Show commands
nnoremap <silent> <localleader>cc  :<C-u>CocList commands<cr>

" Find symbol of current document
nnoremap <silent> <localleader>co  :<C-u>CocList outline<cr>

" Search workspace symbols
nnoremap <silent> <localleader><localleader>  :<C-u>CocList -I symbols<cr>

" Format File
nnoremap <silent> <localleader>ff  :Format<cr>

set termguicolors
" let g:sonokai_style = 'shusia'
let g:sonokai_disable_italic_comment = 1
let g:sonokai_enable_italic             = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_virtual_text   = 'colored'
let g:sonokai_current_word              = 'bold'
let g:sonokai_better_performance        = 1
colorscheme sonokai
