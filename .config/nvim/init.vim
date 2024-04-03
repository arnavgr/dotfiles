source $HOME/.config/nvim/vim-plug/plugins.vim

" General
set ruler
set autowrite
set noswapfile nowritebackup nobackup
set number relativenumber
set history=1000
set ttimeout ttimeoutlen=1 timeoutlen=500
set wildmenu wildmode=list:full
set visualbell
set display+=lastline
set nofoldenable
set splitright splitbelow
set cursorline
set pumheight=10
set nowrap
set inccommand=nosplit
set showcmd
set termguicolors

" Indendation
set autoindent smarttab expandtab
set shiftround tabstop=2 shiftwidth=2

" Keybind shortcuts
set pastetoggle=<F26>
map <F25> :NERDTreeToggle<CR>
map <C-h> :tabp<cr>
map <C-l> :tabn<cr>
map <C-e> :tabclose<cr>
map <C-n> :tabnew<cr>

" Search
set gdefault
set ignorecase smartcase

set list
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«,nbsp:¬
set scrolloff=1 sidescrolloff=5

" Colorscheme
colorscheme dracula

" airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


