" My vim settings

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin in github
Plugin 'cscope.vim'
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
let g:airline_section_b = '%{getcwd()}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme = "solarized"
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0

Plugin 'altercation/vim-colors-solarized'
syntax on
set background=dark
let g:solarized_termcolors = 256
let g:solarized_termtrans = 1
let g:solarized_contrast = "high"
let g:solarized_visibility = "high"

Plugin 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '/home/mars/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_invoke_completion = '<C-X>'

Plugin 'mileszs/ack.vim'
nnoremap go <CR>:cope<CR>
nnoremap gc :ccl<CR>
let g:ackprg="ag --vimgrep -Q"
let g:ackhighlight = 1

Plugin 'kien/ctrlp.vim'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_cache_dir = '/tmp/ctrlp.cache'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_root_markers = ['README', 'CMakeLists.txt', 'cofiregure.ac', 'Makefile.am']

Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on	  " required

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

" enable colorscheme
colorscheme solarized

" ack.vim
function! VisualSelection_ack(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\"`$')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'ga'
        execute "Ack " . "\"" . l:pattern . "\""
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
vnoremap <silent> ga :call VisualSelection_ack('ga')<CR>

" netrw settings
let g:netrw_preview = 1
let g:netrw_winsize = 20
