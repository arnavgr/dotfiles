let g:plug_path = expand('~/.config/nvim/plugged')
call plug#begin(g:plug_path)

 " --- Aesthetics & Icons ---
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'nvim-tree/nvim-web-devicons'

    " --- Modern Replacements ---
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'windwp/nvim-autopairs'

    " --- Syntax & Rendering ---
    Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'master', 'do': ':TSUpdate'}
    Plug 'MeanderingProgrammer/render-markdown.nvim'
    Plug 'andrewferrier/wrapping.nvim'

call plug#end()
