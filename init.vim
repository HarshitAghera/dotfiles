set encoding=utf-8

set nocompatible

""" General
set background=dark
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase         " Do case insensitive matching
set smartcase          " Do smart case matching
set incsearch          " Incremental search
set autowrite          " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a            " Enable mouse usage (all modes)

" sets tab as 4 spaces
" reference: https://stackoverflow.com/questions/234564/
" tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" File finder
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" Configure default file browser netrw
" let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view by default


let mapleader = " "

inoremap jk <Esc>
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>
noremap <leader>a :q!<CR>
noremap <leader>r :wq<CR>
noremap <leader>z <C-z>

" noremap <C-j> <C-w>j
" noremap <C-k> <C-w>k
" noremap <C-h> <C-w>h
" noremap <C-l> <C-w>l

noremap <C-j> :tabp<CR>
noremap <C-k> :tabn<CR>
" noremap <C-;> g<Tab>

noremap <leader>b :Ex<CR>
noremap <leader>o :Texplore<CR>

noremap <leader>os :e ~/.config/nvim/init.vim<CR>
noremap <leader>rc :source ~/.config/nvim/init.vim<CR>

set number
set numberwidth=3

set wrap linebreak

" Plug vim plugin manager
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
" Plug 'tpope/vim-sensible'
" Plug 'junegunn/seoul256.vim'

" For statusline
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
" Plug 'nvim-tree/nvim-web-devicons'
"

" For commenting
Plug 'numToStr/Comment.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

lua require('init')
