" Basic vim configuration
set nocompatible
filetype plugin on
syntax on

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" UI
set number
set relativenumber
set ruler
set showcmd
set showmode
set cursorline

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Editing
set backspace=indent,eol,start
set history=1000
set undofile

" Splits
set splitbelow
set splitright

" Colors
set termguicolors
set background=dark

" Status line
set laststatus=2
set statusline=%F%m%r%h%w\ [%Y]\ [%l,%v]\ [%p%%]

" Key mappings
let mapleader=","
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>
inoremap jk <ESC>
noremap <C-s> <esc>:w<CR>
