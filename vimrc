" My vim settings
filetype plugin indent on

set nocompatible              " be iMproved, required
let g:lang = ''
autocmd FileType python let g:lang = 'python'
autocmd FileType c let g:lang = 'c'
autocmd FileType cpp let g:lang = 'cpp'
filetype detect


" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')

" plugin in github
Plug 'ludovicchabant/vim-gutentags'

Plug 'skywind3000/gutentags_plus'
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/etc/gtags.conf'
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" config project root markers.
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazSl', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" forbid gutentags adding gtags databases
let g:gutentags_auto_add_gtags_cscope = 0

let g:gutentags_plus_nomap = 1
noremap <silent> <leader>fs :GscopeFind s <C-R><C-W><cr><C-W>j
noremap <silent> <leader>fg :GscopeFind g <C-R><C-W><cr><C-W>j
noremap <silent> <leader>fc :GscopeFind c <C-R><C-W><cr><C-W>j
noremap <silent> <leader>ft :GscopeFind t <C-R><C-W><cr><C-W>j
noremap <silent> <leader>fe :GscopeFind e <C-R><C-W><cr><C-W>j
noremap <silent> <leader>ff :GscopeFind f <C-R>=expand("<cfile>")<cr><cr><C-W>j
noremap <silent> <leader>fi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr><C-W>j
noremap <silent> <leader>fd :GscopeFind d <C-R><C-W><cr><C-W>j
noremap <silent> <leader>fa :GscopeFind a <C-R><C-W><cr><C-W>j

Plug 'skywind3000/vim-preview'
"P 预览 大p关闭
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
noremap <leader>u :PreviewScroll -1<cr>
noremap <leader>d :PreviewScroll +1<cr>
noremap <leader>l :ccl<cr>

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
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#gutentags#enabled = 1

Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = "solarized"

Plug 'altercation/vim-colors-solarized'
syntax on
set background=dark
set t_Co=256
let g:solarized_termcolors = 16
let g:solarized_termtrans = 1
let g:solarized_contrast = "normal"
let g:solarized_visibility = "normal"

Plug 'Valloric/YouCompleteMe', {'do': 'python3 install.py --all', 'on': []}
let g:ycm_global_ycm_extra_conf = '/home/mars/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_invoke_completion = '<C-X>'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_disable_for_files_larger_than_kb = 10240
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_cache_omnifunc = 1
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\   'html': [ '<', '</' ],
			\ }
set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 1
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
let g:ctrlsf_search_mode = 'sync'
let g:ctrlsf_ackprg = 'rg'

Plug 'junegunn/fzf', { 'do': './install --all'}
Plug 'junegunn/fzf.vim'
nmap <C-p> :FZF<CR>
nmap <C-l> :Tags<CR>
nmap <C-k> :BTags<CR>
nmap <C-a> :Rg 
nmap <C-z> :Commits<CR>
nmap <C-h> :History<CR>
" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1

Plug  'ianva/vim-youdao-translater', {'on': ['Ydv', 'Ydc', 'Yde']}
vnoremap <silent> <C-T> :<C-u>Ydv<CR>
nnoremap <silent> <C-T> :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

Plug 'tpope/vim-fugitive'

Plug 'junegunn/gv.vim', {'on': 'GV'}
nmap <F9> :GV<CR>

Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-overwin-f2)'}
nmap f <Plug>(easymotion-overwin-f2)
let g:EasyMotion_verbose = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

Plug 'vim-utils/vim-man', {'for': ['c', 'cpp'], 'on': ['<Plug>Man', '<Plug>Vman']}
map <leader>k <Plug>(Man)
map <leader>v <Plug>(Vman)

Plug 'w0rp/ale', {'for': 'python'}
let g:airline#extensions#ale#enabled = 0
let g:ale_set_loclist = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_python_flake8_options = '--ignore=E,W,F403,F405 --select=F,C'
let g:ale_linters = {
\   'python': ['flake8'],
\}

Plug 'fs111/pydoc.vim', {'for': 'python'}
let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_highlight = 0

Plug 'haya14busa/incsearch.vim', {'on': ['<Plug>(incsearch-forward)', '<Plug>(incsearch-backward)', '<Plug>(incsearch-stay)',
										\'<Plug>(incsearch-nohl-n)', '<Plug>(incsearch-nohl-N)', '<Plug>(incsearch-nohl-*)',
										\'<Plug>(incsearch-nohl-#)', '<Plug>(incsearch-nohl-g*)', '<Plug>(incsearch-nohl-g#)']}
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

Plug 'sheerun/vim-polyglot'

" All of your Plugins must be added before the following line
call plug#end()            " required

autocmd FileType python set et |
			\ set sta |
			\ set sts=4 |
			\ set sw=4 |
			\ set cc=80 |
			\ set ts=4
autocmd FileType c,cpp set sw=4 |
			\ set ts=4 |
			\ set noet |
			\ set cc=81 |
			\ set nosta
autocmd FileType html,css,javascript set et |
			\ set sta |
			\ set sts=4 |
			\ set sw=4 |
			\ set cc& |
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

" set fileencodings=utf-8,ucs-bom,gbk,gb2312,gb18030,cp936
set fileencodings=utf-8
set termencoding=utf-8
set encoding=utf-8

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

nmap <F4> :term<CR>
