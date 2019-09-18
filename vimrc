" My vim settings
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

filetype plugin indent on

set nocompatible              " be iMproved, required
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
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" forbid gutentags adding gtags databases
let g:gutentags_auto_add_gtags_cscope = 0

let g:gutentags_define_advanced_commands = 1

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
let g:airline_powerline_fonts = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#gutentags#enabled = 1

Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = "gruvbox"

Plug 'morhetz/gruvbox'
syntax on
set background=dark
set t_Co=256
let g:gruvbox_contrast_dark = 'soft'

Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" if hidden is not set, TextEdit might fail.
set hidden
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
" set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

Plug 'dyng/ctrlsf.vim', {'on': ['<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordExec', '<Plug>CtrlSFCwordExec', 'CtrlSFToggle']}
nmap gs <Plug>CtrlSFPrompt
vmap ga <Plug>CtrlSFVwordExec
nmap ga <Plug>CtrlSFCwordExec
noremap gc <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_auto_focus = {
  \ "at": "start"
  \ }
let g:ctrlsf_ackprg = 'rg'
let g:ctrlsf_extra_root_markers = ['.root']

Plug 'junegunn/fzf', { 'do': './install --all'}
Plug 'junegunn/fzf.vim'
nmap <C-p> :FZF<CR>
nmap <C-l> :Tags<CR>
nmap <C-k> :BTags<CR>
nmap <C-a> :Rg 
nmap <C-z> :Commits<CR>
nmap <C-h> :History<CR>

Plug 'liuchengxu/vista.vim'
nmap <F8> :Vista!!<CR>
let g:vista_close_on_jump = 1
let g:vista_default_executive = 'ctags'
" let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 0

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

Plug 'w0rp/ale'
let g:airline#extensions#ale#enabled = 0
let g:ale_set_loclist = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_python_flake8_options = '--ignore=E,W,F403,F405 --select=F,C'
let g:ale_linters_explicit = 1
let g:ale_linter_aliases = {
\	'mako': ['html'],
\}
let g:ale_linters = {
\   'python': ['flake8'],
\   'html': ['htmlhint'],
\   'mako': ['htmlhint'],
\   'c': ['cppcheck'],
\   'cpp': ['cppcheck'],
\   'h': ['cppcheck'],
\}

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

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1

Plug 'Yggdroot/indentLine'
let g:indentLine_color_dark = 1
let g:indentLine_fileTypeExclude = ['']

Plug 'hesselbom/vim-hsftp'

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

let g:c_syntax_for_h = 0
set foldlevelstart=99

" if !has('nvim')
	set backupdir=~/.vim/backup//
	set directory=~/.vim/swap//
	set undodir=~/.vim/undo//
" endif

map <leader>y "+y
map <leader>p "+p

nnoremap s <nop>

" enable colorscheme
colorscheme gruvbox

" netrw settings
let g:netrw_preview = 1
let g:netrw_winsize = 20

augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

nmap <F4> :vert term<CR>

let g:omni_sql_no_default_maps = 1
let g:ftplugin_sql_omni_key = '<Plug>DisableSqlOmni'

" py3 sys.dont_write_bytecode = True

" if has('nvim')
	" set clipboard+=unnamedplus
	" set noshowcmd noruler
" endif
