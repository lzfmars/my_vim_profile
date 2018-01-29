" My vim settings
filetype plugin indent on

set nocompatible              " be iMproved, required
let g:lang = ''
autocmd FileType python let g:lang = 'python'
autocmd FileType c let g:lang = 'c'
filetype detect


" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Plug 'gmarik/Vundle.vim'

" plugin in github
Plug 'lzfmars/cscope.vim', {'for': ['c', 'python']}
autocmd FileType python let g:cscope_cmd = '/usr/local/bin/pycscope' |
			\ let g:cscope_ignore_files = '.*[^\.][^p][^y]$' |
			\ let g:cscope_lang = 'python'
autocmd FileType c let g:cscope_cmd = '/usr/bin/cscope' |
			\ let g:cscope_ignore_files = '.*[^ch]$\|.*[^\.].$' |
			\ let g:cscope_lang = 'c'
if g:lang == 'python'
	let g:cscope_cmd = '/usr/local/bin/pycscope'
	let g:cscope_ignore_files = '.*[^\.][^p][^y]$'
	let g:cscope_lang = 'python'
else
	let g:cscope_ignore_files = '.*[^ch]$\|.*[^\.].$'
	let g:cscope_lang = 'c'
endif
let g:cscope_open_location = 0
let g:cscope_ignore_strict = 0
let g:cscope_silent = 1
nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
nnoremap <leader>o <CR>zz:lop<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>

Plug 'bling/vim-airline'
set laststatus=2
set encoding=utf-8
set ttimeoutlen=50
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1

Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = "solarized"

Plug 'altercation/vim-colors-solarized'
syntax on
set background=dark
set t_Co=256
let g:solarized_termcolors = 256
let g:solarized_termtrans = 1
let g:solarized_contrast = "high"
let g:solarized_visibility = "high"

Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer', 'on': []}
let g:ycm_global_ycm_extra_conf = '/home/mars/linux/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_invoke_completion = '<C-X>'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\s{4}', 're!:\s+'],
    \   'html': [ '<', '</' ],
    \ }
augroup load_us_ycm
	autocmd!
	autocmd InsertEnter * call plug#load('YouCompleteMe')
				\| call youcompleteme#Enable()
				\| autocmd! load_us_ycm
augroup END

Plug 'dyng/ctrlsf.vim', {'on': ['<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordExec', '<Plug>CtrlSFCwordExec', 'CtrlSFToggle']}
nmap gs <Plug>CtrlSFPrompt
vmap ga <Plug>CtrlSFVwordExec
nmap ga <Plug>CtrlSFCwordExec
noremap gc <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_default_root = 'project+fw'

Plug 'junegunn/fzf', { 'do': './install --all' }
nmap <C-p> :FZF<CR>

Plug 'junegunn/fzf.vim'
nmap <C-l> :Tags<CR>
nmap <C-k> :BTags<CR>
nmap <C-a> :Ag 
nmap <C-z> :Commits<CR>

Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1

Plug  'ianva/vim-youdao-translater'
vnoremap <silent> <C-T> :<C-u>Ydv<CR>
nnoremap <silent> <C-T> :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

Plug 'tpope/vim-fugitive'

Plug 'junegunn/gv.vim'
nmap <F9> :GV<CR>

Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-overwin-f2)'}
nmap f <Plug>(easymotion-overwin-f2)
let g:EasyMotion_verbose = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

Plug 'vim-utils/vim-man', {'for': 'c', 'on': ['<Plug>Man', '<Plug>Vman']}
map <leader>k <Plug>(Man)
map <leader>v <Plug>(Vman)

Plug 'w0rp/ale', {'for': 'python'}
let g:airline#extensions#ale#enabled = 0
let g:ale_set_loclist = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_linters = {
\   'python': ['flake8'],
\}

Plug 'fs111/pydoc.vim', {'for': 'python'}
let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_highlight = 0

Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" All of your Plugins must be added before the following line
call plug#end()            " required

autocmd FileType python set et |
			\ set sta |
			\ set sts=4 |
			\ set sw=4 |
			\ set ts=4 |
			\ set tw=79
autocmd FileType c set sw=4 |
			\ set ts=4 |
			\ set tw=80 |
			\ set noet |
			\ set nosta
autocmd FileType html,css,javascript set et |
			\ set sta |
			\ set sts=4 |
			\ set sw=4 |
			\ set ts=4
set sw=4
set ts=4
" endif
set nu
set ai
set ci
set wim=longest,list
set hls
set backspace=indent,eol,start
set writebackup
set nobackup

set enc=utf-8
set fenc=utf-8
let g:c_syntax_for_h = 1
set foldlevelstart=99

map <leader>y "+y
map <leader>p "+p

nnoremap s <nop>

" enable colorscheme
colorscheme solarized

" netrw settings
let g:netrw_preview = 1
let g:netrw_winsize = 20

augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
