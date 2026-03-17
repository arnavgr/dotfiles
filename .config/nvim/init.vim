source $HOME/.config/nvim/vim-plug/plugins.vim
filetype plugin indent on

" --- General Settings ---
set ruler
set autowrite
set noswapfile nowritebackup nobackup
set number relativenumber
set ttimeout ttimeoutlen=50 timeoutlen=500
set termguicolors

" Global defaults
set wrap
set linebreak
set textwidth=0
set conceallevel=2

" --- Keybinds ---
map <F1> :NvimTreeToggle<CR>
map <C-h> :tabp<cr>
map <C-l> :tabn<cr>
map <C-e> :tabclose<cr>
map <C-n> :tabnew<cr>

" Manual Toggle - Use this to fix wrapping on the fly
nnoremap <silent> <leader>w :ToggleWrapping<CR>

" --- Search & Visuals ---
set gdefault
set ignorecase smartcase
set list
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«,nbsp:¬
set scrolloff=1 sidescrolloff=5

silent! colorscheme dracula

" --- Airline ---
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dracula'
let g:airline_section_z = '%l:%c'

" --- Lua Configuration ---
lua << EOF
local function safe_require(module)
    local ok, m = pcall(require, module)
    return ok and m or nil
end

-- 1. Treesitter
local ts = safe_require('nvim-treesitter.configs')
if ts then
    ts.setup({ highlight = { enable = true } })
end

-- 2. Wrapping (Clean Setup)
local wrapping = safe_require('wrapping')
if wrapping then
    wrapping.setup({})
end

-- 3. Render Markdown
local rm = safe_require('render-markdown')
if rm then 
    rm.setup({
        html = { enabled = false },
        latex = { enabled = false },
        yaml = { enabled = false },
    }) 
end

-- 4. Utilities
local ap = safe_require('nvim-autopairs')
if ap then ap.setup({}) end

local nt = safe_require('nvim-tree')
if nt then nt.setup({ view = { width = 30 } }) end
EOF
