" Options ---------------------------------
" Search options
set ignorecase
set smartcase
set incsearch

" Indentation and tabs
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start

" Indentation per file type
autocmd Filetype html setlocal ts=2 sw=2
autocmd Filetype scss setlocal ts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sw=2
autocmd Filetype xml setlocal ts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sw=2

" Line numbers
set number
set relativenumber

" Share default register with system clipboard
set clipboard=unnamedplus

" Miscelaneous
set nowrap
set splitright
set splitbelow
set mouse=a

" Key bindings ----------------------------
" Ease things for spanish keyboard
noremap ñ /
noremap Ñ ?
let mapleader = " "

" Add blank lines
nnoremap <leader><cr> o<esc>

" Quickly edit and save .vimrc
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :w<cr>:source $MYVIMRC<cr>:q<cr>

" Exit insert mode without <esc> stretch
inoremap jk <esc>

" Quicker begin and end of line
nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $

" Sensible yank to end of line
nnoremap Y y$

" Swap jump to markers.
" Easier to type ' now jumps to line and column.
nnoremap ' `
nnoremap ` '

" Plugins ---------------------------------
" Plugin management with vim-plug (https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'alvan/vim-closetag'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/FuzzyFinder'

call plug#end()

" vim-closetag settings
let g:closetag_filenames = '*.html,*.htm,*.xml,*.erb,*.php'

" FuzzyFinder settings
set wildignore+=bin/*,tmp/*,*.class,*.zip,*.jpg,*.png
nnoremap <leader>o :FufFile **/<cr>
