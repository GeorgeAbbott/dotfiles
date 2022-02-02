set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
" set backupdir=~/.cache/vim " Directory to store backup files.
    
" vim-plug -> 
call plug#begin('~/.config/nvim/plugged')

" Easy alignment
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" For Rust development
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'

" Collection of common configurations for the Nvim LSP client
" Plug 'neovim/nvim-lspconfig'

" Completion framework
" Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
" Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
" Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-buffer'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
" Plug 'simrat39/rust-tools.nvim'

" Snippet engine
" Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
" Optional
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

call plug#end()

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
let g:ale_linters = { 'rust': ['analyzer'] }
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

" Avoid showing extra messages when using completion
" set shortmess+=c
