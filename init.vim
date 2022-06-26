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
set autoindent              " indent a new line the same amount as the line just typed and this is cool
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
" highlight ColorColumn ctermbg=darkcyan
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
set cursorline
set background=dark
" set backupdir=~/.cache/vim " Directory to store backup files.
    
" vim-plug -> 
call plug#begin('~/.config/nvim/plugged')

" Nvim LSP client
Plug 'neovim/nvim-lspconfig'

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

" Autoclose brackets
Plug 'cohama/lexima.vim'
let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1
let g:enable_endwise_rules = 1

Plug 'alvan/vim-closetag'           " Close HTML tags


" Modify surrounding brackets
Plug 'tpope/vim-surround'

" Tagbar
Plug 'preservim/tagbar'
nmap <F8> :TagbarToggle<CR>

" NerdTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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
                    \        [ 'gitbranch', 'readonly', 'filename', 'modified' ]
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



" For Rust development
Plug 'hrsh7th/nvim-cmp'         " Completion framework
Plug 'hrsh7th/cmp-nvim-lsp'     " LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'        " Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'simrat39/rust-tools.nvim' 
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'folke/todo-comments.nvim'

" For C++ development
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Fuzzy Finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Unused 
" Plug 'rust-lang/rust.vim'
" Plug 'dense-analysis/ale'

call plug#end()
" <- vim-plug 

" Set Theme
" colorscheme tokyonight  " tempus themes don't work without something better before?
colorscheme tempus_warp 

" numb 
:lua require('numb').setup()

" todo-comments
lua << EOF
  require("todo-comments").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" :help completeopt
set completeopt=menu,menuone,longest,noselect

set shortmess+=c
set signcolumn=yes

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

-- C++  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    filetypes = { "c", "cc", "cpp", "c++", "objc", "objcpp", "cppm", "c++m" };
    highlight = {
        lsRanges = true;
    };
    clang = {
      extraArgs = { "-std=c++20" } ; 
      excludeArgs = { "-frounding-math"} ;
    };
  }
}
require'lspconfig'.ccls.setup{}
-- C++  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Others  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
require'lspconfig'.ltex.setup{}
-- Others  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


-- BEGIN -- Go   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
require'lspconfig'.gopls.setup{
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod"},
    root_dir = require'lspconfig/util'.root_pattern("go.work", "go.mod", ".git"),
    settings = { 
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}
-- END   -- Go   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


-- local opts = {
--     tools = { -- rust-tools options
--         autoSetHints = true,
--         hover_with_actions = true,
--         inlay_hints = {
--             type_hints = true, 
--             chaining_hints = true,
--             show_parameter_hints = true,
--             parameter_hints_prefix = "",
--             other_hints_prefix = "",
--         },
--     },
-- 
--     -- all the opts to send to nvim-lspconfig
--     -- these override the defaults set by rust-tools.nvim
--     -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
--     server = {
--         -- on_attach is a callback called when the language server attachs to the buffer
--         -- on_attach = on_attach,
--         settings = {
--             -- to enable rust-analyzer settings visit:
--             -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
--             ["rust-analyzer"] = {
--                 -- enable clippy on save
--                 checkOnSave = {
--                     command = "clippy"
--                 },
--             }
--         }
--     },
-- }

require('rust-tools').setup({})
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF
