set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
" set tabstop=4               " number of columns occupied by a tab 
" set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
" set expandtab               " converts tabs to white space
" set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed 
set number                  " add line numbers
set wildmode=full,longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
highlight ColorColumn ctermbg=darkcyan
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
set cursorline
set termguicolors           " Themes don't seem to work without this. 
set autochdir
" set backupdir=~/.cache/vim " Directory to store backup files.
let mapleader=','

" Some aliases to make my life easier 
command W w 
command Wq wq 
command Q q
command WQ wq

" Highlight yanked text
autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=4000 }

" Telescope shortcuts 
noremap <leader>cs :Telescope colorscheme<CR>
noremap <leader>gr :Telescope grep_string<CR>
noremap <leader>lg :Telescope live_grep<CR>

noremap <leader>gc :Telescope git_commits<CR>
noremap <leader>gs :Telescope git_status<CR>
noremap <leader>fd :Telescope fd<CR>

    
" vim-plug -> 
call plug#begin('~/.config/nvim/plugged')

"""""""""""
" Themes ->
Plug 'folke/tokyonight.nvim'
let g:tokyonight_style = 'night' " night; storm; day 
let g:tokyonight_enable_italic = 1 

Plug 'morhetz/gruvbox'
let g:gruvbox_italic = 1

Plug 'sjl/badwolf'
let g:badwolf_darkgutter = 1
let g:badwolf_css_props_highlight = 1

Plug 'arcticicestudio/nord-vim'

Plug 'ciaranm/inkpot'

Plug 'nanotech/jellybeans.vim'
let g:jellybeans_use_term_italics = 1

Plug 'tomasr/molokai'
let g:molokai_original = 0

Plug 'jnurmine/Zenburn'

Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'

Plug 'https://git.sr.ht/%7Eswalladge/paper.vim'

Plug 'connorholyday/vim-snazzy'
let g:SnazzyTransparent = 0

Plug 'https://github.com/altercation/vim-colors-solarized'

Plug 'https://github.com/katawful/kat.nvim'

Plug 'https://github.com/humanoid-colors/vim-humanoid-colorscheme'

Plug 'https://github.com/Rigellute/shades-of-purple.vim'

Plug 'https://github.com/acetylen/boring.nvim'

Plug 'https://github.com/rktjmp/lush.nvim'
Plug 'https://github.com/mcchrish/zenbones.nvim'

" <- end themes
"""""""""""""""

" loupe - improves searching with /, ?, #, *, i.e. highlighting + <Leader>n to 
" clear highlighting 
Plug 'https://github.com/wincent/loupe'

" Peek at location when entering :N
Plug 'nacro90/numb.nvim'

" Easy alignment
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Speeddating - <C-A> and <C-X> increment/decrement dates correctly. 
Plug 'tpope/vim-speeddating'

" Converting bases: gA shows representations and crd, crx, cro, crb convert
" under cursor
Plug 'glts/vim-magnum'     " Depedency of vim-radical
Plug 'glts/vim-radical'

" Repeat commands
Plug 'tpope/vim-repeat'

" Rainbow brackets for easy viewing
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

""" Autoclose brackets
"Plug 'cohama/lexima.vim'
"let g:lexima_enable_basic_rules = 0
"let g:lexima_enable_newline_rules = 0
"let g:enable_endwise_rules = 0
"

" Modify surrounding brackets
Plug 'tpope/vim-surround'

" Tagbar
Plug 'preservim/tagbar'
nmap <F8> :TagbarToggle<CR>

" NerdTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'      " must be last?
nmap <F7> :NERDTreeToggle<CR>

" Git 
Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter/'  " Display changes in sidebar to left

" Lightline
Plug 'itchyny/lightline.vim'

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': { 
                \ 'left':  [ [ 'mode', 'paste' ], 
                    \        [ 'gitbranch', 'readonly', 'filename', 'modified', 'absolutepath' ]
                    \      ],
                \ 'right': [ [ 'lineinfo' ],
                    \        [ 'percent' ],
                    \        [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ]
                    \      ]
                \ }, 
            \ 'component': { 
                \ 'charvaluehex': '0x%B'
            \ },
            \ 'component_function': {
                \ 'gitbranch': 'FugitiveHead'
            \ }
            \ }

Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

Plug 'nvim-lua/popup.nvim'
Plug 'RishabhRD/lspactions'
nnoremap <leader>ar :lua require'lspactions'.rename()<CR>
" vim.lsp.handlers["textDocument/codeAction"] = require'lspactions'.codeaction
" vim.cmd [[ nnoremap <leader>af :lua require'lspactions'.code_action()<CR> ]]
" vim.cmd [[ nnoremap <leader>af :lua require'lspactions'.range_code_action()<CR> ]]




" For C++ development
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Fuzzy Finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf'

call plug#end()
" <- vim-plug 

" :help completeopt
set completeopt=menu,menuone,longest,noselect,noinsert
set shortmess+=c
set signcolumn=yes

" Set Theme 
if strftime("%H") >= 6 && strftime("%H") < 18
    set background=light
    colorscheme tempus_totus 
else
  set background=dark 
  colorscheme badwolf
endif

" numb 
:lua require('numb').setup()
