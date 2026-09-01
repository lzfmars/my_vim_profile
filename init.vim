" My vim settings
let g:syntastic_python_python_exec = 'python3'
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

filetype plugin indent on

set nocompatible              " be iMproved, required
filetype detect

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.config/nvim/plugged')

" plugin in github
Plug 'bling/vim-airline'
Plug 'enricobacis/vim-airline-clock'
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
let g:airline#extensions#clock#format = '%H:%M'

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
Plug 'lukas-reineke/cmp-rg'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
noremap <leader>l :ccl<cr>

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
if isdirectory('.git')
	nmap <C-p> :lua require'fzf-lua'.git_files({ cmd = "git ls-files --cached --others --exclude-standard" })<CR>
else
	nmap <C-p> :FzfLua files<CR>
endif
nmap <C-a> :FzfLua grep search=""<Left>
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

Plug 'voldikss/vim-floaterm', {'on': ['FloatermNew', 'FloatermToggle']}
let g:floaterm_wintype = 'vsplit'
let g:floaterm_width = 0.5
" ESC 仅退出终端输入模式；F4 显示或隐藏窗口，并保留终端会话
nnoremap <silent> <F4> :FloatermToggle<CR>
tnoremap <silent> <F4> <C-\><C-n>:FloatermToggle<CR>
tnoremap <ESC> <Cmd>call <SID>LeaveTerminalInput()<CR>
function! s:RunTerminalWindowCommand() abort
  " 该映射只能从 t 触发；Ctrl-w 只是临时执行窗口命令，不应把持久状态改成 nt。
  call s:SetTerminalInput(v:true)
  " 立即等待下一键，避免短映射受 ttimeoutlen 影响而提前进入 Normal。
  let l:key = getcharstr()
  let l:move = l:key ==# "\<C-w>" ? 'w' : l:key
  if index(['w', 'h', 'j', 'k', 'l'], l:move) >= 0
    execute 'wincmd ' . l:move
    return
  endif

  " Esc 只取消前缀；fallback 可短暂进入 Terminal-Normal，但不能覆盖已保存的 t。
  " Ctrl-w 始终由 Neovim 消费，不会传给 shell 删除单词。
  if l:key !=# "\<Esc>"
    call feedkeys("\<C-\>\<C-n>\<C-w>" . l:key, 'n')
  endif
endfunction

tnoremap <C-w> <Cmd>call <SID>RunTerminalWindowCommand()<CR>

function! s:SetTerminalInput(active) abort
  if &buftype !=# 'terminal'
    return
  endif

  " t/nt 状态属于 terminal buffer；窗口离开后全局 mode() 只能看到当前窗口的模式。
  let b:resume_terminal_input = a:active
  if &filetype ==# 'floaterm'
    " Floaterm smart 根据光标位置猜测；固定为真实状态，避免返回窗口时误判。
    call floaterm#config#set(bufnr(), 'autoinsert',
          \ a:active ? 'always' : 'never')
  endif
endfunction

function! s:LeaveTerminalInput() abort
  " 在显式退出 t 之前记录 nt；这里只处理当前配置的 ESC，不接管原生组合键。
  call s:SetTerminalInput(v:false)
  call feedkeys("\<C-\>\<C-n>", 'n')
endfunction

function! s:RestoreTerminalInput() abort
  " 只恢复离开前正在输入的终端；Terminal-Normal 必须保持 Normal。
  if &buftype ==# 'terminal' && get(b:, 'resume_terminal_input', v:false)
    startinsert
  endif
endfunction

augroup terminal_input_by_window
  autocmd!
  autocmd TermEnter * call <SID>SetTerminalInput(v:true)
  autocmd WinEnter * call <SID>RestoreTerminalInput()
augroup END
au TermClose * :silent! FloatermKill<CR>

Plug 'kenn7/vim-arsync'
" vim-arsync depedencies
Plug 'prabirshrestha/async.vim'

Plug 'tpope/vim-sleuth'

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_modules = ["cscope_maps"] " This is required. Other config is optional
let g:gutentags_cscope_build_inverted_index_maps = 1
let g:gutentags_cache_dir = "~/code/.gutentags"
let g:gutentags_file_list_command = "fd -e c -e h -e cpp -e cc"
" let g:gutentags_trace = 1
Plug 'dhananjaylatkar/cscope_maps.nvim'

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
			\ set sts=4 |
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
set encoding=utf-8

" let g:c_syntax_for_h = 0
set foldlevelstart=99

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

let g:omni_sql_no_default_maps = 1
let g:ftplugin_sql_omni_key = '<Plug>DisableSqlOmni'

set clipboard=unnamed
set mouse=
set maxmempattern=100000

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
autocmd BufEnter * lua vim.diagnostic.enable(false)

nnoremap <silent> <esc> :nohlsearch<cr>

set title
set titlestring+=%{substitute(getcwd(),\ $HOME,\ '~',\ '')}

" Neovim 分屏不是独立的 macOS 窗口，不能同时持有不同输入源。
" 因此在窗口和终端模式变化时同步：终端输入使用豆包拼音，其余状态使用 ABC。
let s:macism = '/opt/homebrew/bin/macism'
let s:code_input_source = 'com.apple.keylayout.ABC'
let s:terminal_input_source = 'com.bytedance.inputmethod.doubaoime.pinyin'

function! s:SyncInputSource() abort
  " Headless 任务不应修改桌面输入法；工具缺失时保持当前状态。
  if empty(nvim_list_uis()) || !executable(s:macism)
    return
  endif

  " fzf-lua 的查询框虽然是 Terminal buffer，但输入内容主要是路径和代码关键词，应保持 ABC。
  let l:use_terminal_input = &buftype ==# 'terminal'
        \ && &filetype !=# 'fzf'
        \ && mode(1) =~# '^t'
  let l:target = l:use_terminal_input
        \ ? s:terminal_input_source
        \ : s:code_input_source
  let l:current = trim(system([s:macism]))
  if v:shell_error != 0 || l:current ==# l:target
    return
  endif

  " 同步等待可避免 CJK 输入法尚未接管时，首字符仍落入旧输入法。
  call system([s:macism, l:target])
endfunction

augroup input_source_by_window
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter,FocusGained,TermEnter,TermLeave *
        \ call <SID>SyncInputSource()
augroup END

lua << EOF
-- 全屏终端在大小屏之间移动时，Floaterm 会保留创建时的绝对列宽。
-- 在终端尺寸变化或重新获得焦点后，按当前屏幕重算 vsplit Floaterm。
local function resize_floaterm()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local width = vim.b[buf].floaterm_width
    if vim.bo[buf].filetype == 'floaterm'
        and vim.b[buf].floaterm_wintype == 'vsplit'
        and type(width) == 'number' then
      if width > 0 and width < 1 then
        width = math.floor(vim.o.columns * width)
      end
      -- 极窄布局无法满足目标宽度时，保留 Neovim 的可用布局。
      pcall(vim.api.nvim_win_set_width, win, math.max(1, width))
    end
  end
end

vim.api.nvim_create_autocmd({ 'VimResized', 'FocusGained' }, {
  group = vim.api.nvim_create_augroup('FloatermAutoResize', { clear = true }),
  callback = resize_floaterm,
})

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
				else
				  fallback()
				end
			  end, { "i", "s" }),
	["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
		          cmp.select_prev_item()
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
    { name = 'rg' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
  }, {
    { name = 'cmp_tabnine' },
  }),
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
local servers = { 'bashls', 'html', 'jsonls', 'sqlls', 'ts_ls', 'dockerls', 'lua_ls', 'gopls' }
for i = 1, #servers do
  vim.lsp.config(servers[i], {
    capabilities = capabilities
  })
end
--require('lspconfig')['clangd'].setup {
--	capabilities = capabilities,
--	cmd = {
--		"clangd",
--		"--header-insertion=never",
--		"--all-scopes-completion"
--	}
--}
vim.lsp.config('pyright', {
	capabilities = capabilities,
	python = {
		analysis = {
		autoSearchPaths = true,
    		diagnosticMode = "openFilesOnly",
    		useLibraryCodeForTypes = true,
		autoImportCompletions = false
		}
	}
})

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

vim.keymap.set({ "n", "v" }, "<leader>gg", "<cmd>Cs f g<cr>")
vim.keymap.set({ "n", "v" }, "<leader>gs", "<cmd>Cs f s<cr>")
require("cscope_maps").setup({
-- maps related defaults
  disable_maps = true, -- "true" disables default keymaps
  skip_input_prompt = false, -- "true" doesn't ask for input
  prefix = "<leader>c", -- prefix to trigger maps

  -- cscope related defaults
  cscope = {
    -- location of cscope db file
    db_file = "./cscope.out", -- DB or table of DBs
                              -- NOTE:
                              --   when table of DBs is provided -
                              --   first DB is "primary" and others are "secondary"
                              --   primary DB is used for build and project_rooter
    -- cscope executable
    exec = "cscope", -- "cscope" or "gtags-cscope"
    -- choose your fav picker
    picker = "quickfix", -- "quickfix", "location", "telescope", "fzf-lua", "mini-pick" or "snacks"
    -- qf_window_size = 5, -- deprecated, replaced by picket_opts below, but still supported for backward compatibility
    -- qf_window_pos = "bottom", -- deprecated, replaced by picket_opts below, but still supported for backward compatibility
    picker_opts = {
      window_size = 5, -- any positive integer
      window_pos = "bottom", -- "bottom", "right", "left" or "top"
    },
    -- "true" does not open picker for single result, just JUMP
    skip_picker_for_single_result = false, -- "false" or "true"
    -- custom script can be used for db build
    db_build_cmd = { script = "default", args = { "-bqkv" } },
    -- statusline indicator, default is cscope executable
    statusline_indicator = nil,
    -- try to locate db_file in parent dir(s)
    project_rooter = {
      enable = false, -- "true" or "false"
      -- change cwd to where db_file is located
      change_cwd = false, -- "true" or "false"
    },
    -- cstag related defaults
    tag = {
      -- bind ":Cstag" to "<C-]>"
      keymap = true, -- "true" or "false"
      -- order of operation to run for ":Cstag"
      order = { "cs", "tag_picker", "tag" }, -- any combination of these 3 (ops can be excluded)
      -- cmd to use for "tag" op in above table
      tag_cmd = "tjump",
    },
  },

  -- stack view defaults
  stack_view = {
    tree_hl = true, -- toggle tree highlighting
  }
})

EOF
