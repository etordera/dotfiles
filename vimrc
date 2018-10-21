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

" Line numbers
set number
" Disabled as a workaround for ruby/haml slowdown bug
" set relativenumber

" Custom status line
set laststatus=2
set statusline=%f%<\ %q%h%w%m%r
set statusline+=%=
set statusline+=%l:%c
set statusline+=\ 
set statusline+=%#PmenuSel#
set statusline+=%{FugitiveStatusline()}
set statusline+=%#LineNr#

" Auto commands
augroup etordera
    autocmd!
    " Custom parameters per file type
    autocmd Filetype html,scss,eruby,xml,yaml,ruby,haml setlocal tabstop=2 shiftwidth=2
augroup END

" Share default register with system clipboard
if has('mac')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" Miscelaneous
set nowrap             " don't wrap long lines
set splitright         " split horizontal to right
set splitbelow         " split vertical below
set mouse=a            " enable mouse
set scrolloff=4        " keep 4 lines off the edges when scrolling
set pastetoggle=<F2>   " F2 toggles paste mode (paste without autoindent)
set nrformats=bin,hex  " <C-a>, <C-x> don't mess with 0-padded numbers (octal)
set diffopt=filler,vertical " open diff windows with vertical split

" Keep swap, backup and undo files out of workspaces
let swapdir = $HOME.'/.vim/swapfiles'
if !isdirectory(swapdir)
    call mkdir(swapdir, "p")
endif
let swapdir_spec = swapdir.'//'
let &directory = swapdir_spec
let &backupdir = swapdir_spec
let &undodir = swapdir_spec

" Key bindings ----------------------------
" Ease things for spanish keyboard
noremap ñ /
noremap Ñ ?
let mapleader = " "

if executable('ag')
    " Use the silver searcher for grepping
    set grepprg=ag\ --nogroup\ --nocolor\ --column\ --ignore\ tags\ \"$*\"
    command! -nargs=+ AG execute 'silent grep! '.<q-args> | execute 'redraw!' | execute 'copen'
    " Find references to symbol under cursor
    nnoremap <leader>f :AG <C-r><C-w><cr>
endif

" Open previous file
nnoremap <leader>p <C-^>

" Quick save
nnoremap <leader>w :w<cr>

" Quick quit
nnoremap <leader>q :qa<cr>

" Close quickfix list
nnoremap <leader>c :cclose<cr>

" Change ruby hashrockets to new format on current line
nnoremap <leader>h :s/:\([^=,'"]*\) =>/\1:/g<cr>

" Create tags file: only project files
nnoremap <leader>tp :!ctags -R --languages=ruby --exclude=.git --exclude=log .<cr>
" Create tags file: project files and bundled gems
nnoremap <leader>tb :!ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle show --paths \| grep ^/)<cr>
" Jump to tag, open select window for multiple matches
nnoremap <leader>tt g<C-]>
vnoremap <leader>tt g<C-]>
" Jump to tag, include ending ? or !
nnoremap <leader>tf viw<Right>g<C-]>

" Write with sudo
cnoremap w!! w !sudo tee % > /dev/null

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

" Swap 'jump to' markers.
" Easier to type ' now jumps to line and column.
nnoremap ' `
nnoremap ` '

" Quicker change to other windows
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" Plugins ---------------------------------
" Plugin management with vim-plug (https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')

" Add/change surrounding elements
Plug 'tpope/vim-surround'
" Allow dot command for plugins
Plug 'tpope/vim-repeat'
" Git integration
Plug 'tpope/vim-fugitive'
" Rails utilities
Plug 'tpope/vim-rails'
" Add/remove comments
Plug 'tpope/vim-commentary'
" Automatically add 'end'
Plug 'tpope/vim-endwise'
" Automatically close html tags
Plug 'alvan/vim-closetag'
" Automatically pair brackets, parentheses, quotes
Plug 'jiangmiao/auto-pairs'
" File tree sidebar
Plug 'scrooloose/nerdtree'
" Quick movements
Plug 'easymotion/vim-easymotion'
" Fuzzy file searches
Plug 'ctrlpvim/ctrlp.vim'
" Check syntax inside vim
Plug 'vim-syntastic/syntastic'
" Running rspec
Plug 'thoughtbot/vim-rspec'

call plug#end()

" NERDTree settings
nnoremap <leader>n :NERDTreeToggle<cr>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMouseMode = 2

" vim-closetag settings
let g:closetag_filenames = '*.html,*.htm,*.xml,*.erb,*.php'

" Ctrl-P settings
set wildignore+=*/bin/*,*tmp/*,*.class,*.zip,*.jpg,*.png
let g:ctrlp_map = '<leader>o'
nnoremap <leader>r :CtrlPMRUFiles<cr>

" vim-rspec settings
let g:rspec_command = "!bundle exec rspec --format documentation {spec}"
nnoremap <Leader>sf :call RunCurrentSpecFile()<CR>
nnoremap <Leader>ss :call RunNearestSpec()<CR>
nnoremap <Leader>sl :call RunLastSpec()<CR>
nnoremap <Leader>sa :call RunAllSpecs()<CR>
