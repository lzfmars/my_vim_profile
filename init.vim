" My vim settings
let g:syntastic_python_python_exec = 'python3'
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

filetype plugin indent on

set nocompatible              " be iMproved, required
filetype detect

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')

" plugin in github
Plug 'bling/vim-airline'
set laststatus=2
set encoding=utf-8
set ttimeoutlen=50
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#vista#enabled = 1
let g:airline#extensions#nvimlsp#enabled = 0

Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = "gruvbox"

Plug 'morhetz/gruvbox'
syntax on
set background=dark
set t_Co=256
let g:gruvbox_contrast_dark = 'hard'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
noremap <leader>l :ccl<cr>

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
if isdirectory('.git')
	" nmap <C-p> :Fzflua git_files --cached --others --exclude-standard<CR>
	nmap <C-p> :lua require'fzf-lua'.git_files({ cmd = "git ls-files --cached --others --exclude-standard" })<CR>
else
	nmap <C-p> :FzfLua files<CR>
endif
nmap <C-l> :FzfLua tags<CR>
nmap <C-.> :FzfLua btags<CR>
nmap <C-a> :FzfLua grep search=
vmap ga :FzfLua grep_visual<CR>
nmap ga :FzfLua grep_cword<CR>

Plug 'liuchengxu/vista.vim'
nmap <F8> :Vista!!<CR>
let g:vista_close_on_jump = 1
let g:vista_default_executive = 'ctags'
" let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 0

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1

Plug 'voldikss/vim-translator', {'on': ['<Plug>TranslateW', '<Plug>TranslateWV']}
let g:translator_default_engines = ['google', 'haici', 'bing']
" Display translation in a window
nmap <silent> <C-t> <Plug>TranslateW
vmap <silent> <C-t> <Plug>TranslateWV

Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-overwin-f2)'}
nmap f <Plug>(easymotion-overwin-f2)
let g:EasyMotion_verbose = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

Plug 'vim-utils/vim-man', {'for': ['c', 'cpp'], 'on': ['<Plug>Man', '<Plug>Vman']}
map <leader>k <Plug>(Man)
map <leader>v <Plug>(Vman)

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'Yggdroot/indentLine'
let g:indentLine_color_dark = 1
let g:indentLine_fileTypeExclude = ['']

Plug 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call plug#end()            " required

autocmd FileType python set et |
			\ set sta |
			\ set sts=4 |
			\ set sw=4 |
			\ set cc=80 |
			\ set ts=4
autocmd FileType c,cpp set sw=2 |
			\ set ts=2 |
			\ set sts=2 |
			\ set et |
			\ set cc=81 |
			\ set sta
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

" let g:c_syntax_for_h = 0
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

nmap <F4> :vs +te<CR>
autocmd TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>:q<CR>

let g:omni_sql_no_default_maps = 1
let g:ftplugin_sql_omni_key = '<Plug>DisableSqlOmni'

" py3 sys.dont_write_bytecode = True

" if has('nvim')
	" set clipboard+=unnamedplus
	" set noshowcmd noruler
" endif
set clipboard=unnamed

nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
vnoremap d "_d
vnoremap dd "_dd
nnoremap c "_c
nnoremap cc "_cc
nnoremap C "_C
vnoremap c "_c
vnoremap cc "_cc

au! BufNewFile,BufRead *.cc setf cpp
autocmd BufEnter * lua vim.diagnostic.disable()

nnoremap <silent> <esc> :nohlsearch<cr>

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
  -- REQUIRED - you must specify a snippet engine
    expand = function(args)
	vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif vsnip.expand_or_jumpable() then
					vsnip.expand_or_jump()
				elseif has_words_before() then
					fallback()
				else
					fallback()
				end
		  end, { "i", "s" }),
	["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif vsnip.jumpable(-1) then
					vsnip.jump(-1)
				else
					fallback()
				end
	          end, { "i", "s" }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  }, {
    { name = 'cmp_tabnine' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
local servers = { 'pyright', 'clangd', 'bashls', 'html', 'jsonls', 'sqlls', 'tsserver' }
for i = 1, #servers do
  require('lspconfig')[servers[i]].setup {
    capabilities = capabilities
  }
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>fs', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>fg', vim.lsp.buf.definition, opts)
  end,
})

EOF
