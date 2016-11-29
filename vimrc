" My vim settings
filetype plugin indent on

set nocompatible              " be iMproved, required
if v:version < 704
	filetype off                  " required
	let g:lang = 'c'
else
	let g:lang = ''
	autocmd Filetype python let g:lang = 'python'
	autocmd Filetype c let g:lang = 'c'
endif


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin in github
Plugin 'cscope.vim'
if g:lang == 'python'
	let g:cscope_cmd = '/usr/local/bin/pycscope'
endif
let g:cscope_open_location = 0
let g:cscope_ignore_files = '.*[^ch]$\|.*[^\.].$'
let g:cscope_ignore_strict = 0
nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
nnoremap <leader>o <CR>:lop<CR>
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

Plugin 'bling/vim-airline'
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

Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme = "solarized"

Plugin 'altercation/vim-colors-solarized'
syntax on
set background=dark
set t_Co=256
let g:solarized_termcolors = 256
let g:solarized_termtrans = 1
let g:solarized_contrast = "high"
let g:solarized_visibility = "high"

Plugin 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '/home/mars/lvs-v4/lvs-kernel/redhat-kernel-source/linux-2.6.32/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_invoke_completion = '<C-X>'
let g:ycm_autoclose_preview_window_after_insertion = 1

Plugin 'dyng/ctrlsf.vim'
nmap gs <Plug>CtrlSFPrompt
vmap ga <Plug>CtrlSFVwordExec
nmap ga <Plug>CtrlSFCwordExec
noremap gc <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_default_root = 'project'

Plugin 'kien/ctrlp.vim'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_cache_dir = '/tmp/ctrlp.cache'
let g:ctrlp_root_markers = ['.git', 'README', 'configure.ac', 'Makefile.am']
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 100000
let g:ctrlp_user_command = {
\ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
  \ },
\ 'fallback': 'ag %s -l --nocolor -g "\.(c|h)$"'
\ }

Plugin 'FelikZ/ctrlp-py-matcher'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1

Plugin  'ianva/vim-youdao-translater'
vnoremap <silent> <C-T> :<C-u>Ydv<CR>
nnoremap <silent> <C-T> :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

Plugin 'tpope/vim-fugitive'

Plugin 'easymotion/vim-easymotion'
nmap f <Plug>(easymotion-overwin-f2)
let g:EasyMotion_verbose = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

if g:lang == 'c'
	Plugin 'vim-utils/vim-man'
	map <leader>k <Plug>(Man)
	map <leader>v <Plug>(Vman)
endif

if g:lang == 'python'
	Plugin 'scrooloose/syntastic'
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:syntastic_python_checkers = ["flake8"]
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
if v:version < 704
	filetype plugin indent on	  " required
endif

if g:lang == 'python'
	set et
	set sta
	set sts=4
endif
set nu
set ai
set ci
set ts=4
set wim=longest,list
set sw=4
set hls
set backspace=indent,eol,start
set writebackup
set nobackup

set enc=utf-8
set fenc=utf-8
let g:c_syntax_for_h = 1

map <leader>y "+y
map <leader>p "+p

nnoremap s <nop>

" enable colorscheme
colorscheme solarized

" netrw settings
let g:netrw_preview = 1
let g:netrw_winsize = 20

highlight SignColumn ctermbg=8

augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

