"********* Plugins *********

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'daviesjamie/vim-base16-lightline'
call plug#end()

"*********************************************

set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'base16' }
set t_Co=256
set mouse=a
set nocompatible
filetype on
syntax on
set number
set list
set listchars=tab:?\ ,trail:·,nbsp:·

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" remaps
nnoremap U <C-r>
noremap Q <Nop>

" Autocompletion
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
noremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" draw highlighted line
set cul
set culopt=screenline

" Tabba enbart med spaces
set tabstop=2
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab

" Låt aldrig markören nå första eller sista raden vid scrollning
set scrolloff=1

" Sökning
set incsearch
set hlsearch

set autoindent
set ignorecase

set autoread
set wildmenu
set shortmess=I

