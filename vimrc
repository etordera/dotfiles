" ------------------------------------------------------------------------------
" Configuration / options
" ------------------------------------------------------------------------------

" Searching
set ignorecase    " Searches are case-insensitive
set smartcase     " Search case-sensitively for terms with uppercase letters
set incsearch     " Show search hits while typing
set nohlsearch    " Do not highlight search hits

" Indentation and tabs
set autoindent       " Copy indent from current line when starting a new line
set tabstop=4        " A <Tab> is four spaces
set shiftwidth=4     " Indentation shift is 4 spaces
set expandtab        " Use spaces instead of tabs
set backspace=indent,eol,start      " Sensible backspace behaviour

" Custom status line
set laststatus=2
set statusline=%f%<\ %q%h%w%m%r
set statusline+=%=
"set statusline+=[%b\ 0x%B]
"set statusline+=\ 
set statusline+=%l/%L
set statusline+=:%c
set statusline+=\ 
set statusline+=%#PmenuSel#
set statusline+=%{FugitiveStatusline()}
set statusline+=%#LineNr#

" Auto commands
augroup etordera
    autocmd!
    " Tab sizes per file type
    autocmd Filetype html,scss,eruby,xml,yaml,eruby.yaml,ruby,haml,javascript setlocal tabstop=2 shiftwidth=2
    " Keyword chars per file type
    autocmd Filetype ruby setlocal iskeyword=@,48-57,_,?,!
augroup END

" Share default register with system clipboard
if has('mac')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" Miscelaneous
set number             " Line numbers
set background=light   " Use colors for light background
set nowrap             " Don't wrap long lines
set splitright         " Split horizontal to right
set splitbelow         " Split vertical below
set mouse=a            " Enable mouse
if !has('nvim')
    set ttymouse=xterm2    " Make mouse play nice with tmux
endif
set scrolloff=4        " Keep 4 lines off the edges when scrolling
set sidescrolloff=8    " Keep 8 columns off the edges when scrolling horizontally
set pastetoggle=<F2>   " F2 toggles paste mode (paste without autoindent)
set nrformats=bin,hex  " <C-a>, <C-x> don't mess with 0-padded numbers (octal)
set diffopt=filler,vertical " Open diff windows with vertical split

" Keep swap, backup and undo files out of workspaces
if !has('nvim')
    let swapdir = $HOME.'/.vim/swapfiles'
    if !isdirectory(swapdir)
        call mkdir(swapdir, "p")
    endif
    let swapdir_spec = swapdir.'//'
    let &directory = swapdir_spec
    let &backupdir = swapdir_spec
    let &undodir = swapdir_spec
endif

" Load matchit (match do ... end)
runtime macros/matchit.vim


" ------------------------------------------------------------------------------
" Mappings and custom commands
" ------------------------------------------------------------------------------

" Ease things for spanish keyboard
noremap ñ /
noremap Ñ ?
let mapleader = " "

" Use the silver searcher for grepping
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column\ --ignore\ tags
    command! -nargs=+ AG execute 'silent grep! '.<q-args> | execute 'redraw!' | execute 'copen'
    " Find references to symbol under cursor
    nnoremap <leader>f :AG <C-r><C-w><cr>
endif

" Settings needed for keycodes to work in terminal vim
set <S-F3>=[1;2R
set <S-F4>=[1;2S

" Move to next/previous quickfix location
nnoremap <F3> :cnext<cr>
nnoremap <S-F3> :cprevious<cr>
nnoremap <F4> :cnfile<cr>
nnoremap <S-F4> :cpfile<cr>

" Move to next/previous change location
nnoremap <A-o> g;
nnoremap <A-i> g,

" Do a search and replace on quickfix list locations
nnoremap <leader>d :cdo s//g \| update<C-Left><C-Left><C-Left><Right><Right>

" Open previous file
nnoremap <leader>p <C-^>

" Quick save
nnoremap <leader>w :w<cr>

" Quick quit
nnoremap <leader>q :qa<cr>

" Close quickfix/local list
nnoremap <leader>c :cclose<cr>:lclose<cr>

" Change ruby hashrockets to new format on current line
nnoremap <leader>h :s/\v:([A-Za-z_0-9]+) ?\=\>/\1:/g<cr>
vnoremap <leader>h :s/\v:([A-Za-z_0-9]+) ?\=\>/\1:/g<cr>

" Toggle highlighting search matches
nnoremap <leader>l :set hlsearch!<cr>

" Create tags file: only project files
nnoremap <leader>tp :!ctags -R --languages=ruby --exclude=.git --exclude=log .<cr>
" Create tags file: project files and bundled gems
nnoremap <leader>tb :!ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle show --paths \| grep ^/)<cr>
" Jump to tag, open select window for multiple matches
nnoremap <leader>tt g<C-]>
vnoremap <leader>tt g<C-]>

" Write with sudo
cnoremap w!! w !sudo tee % > /dev/null

" Quickly edit and save .vimrc
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :w<cr>:source $MYVIMRC<cr>:q<cr>

" Exit insert mode without <esc> stretch
inoremap jk <esc>
if has('nvim')
    tnoremap jk <C-\><C-n>
endif

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

" Resizing windows
nnoremap <A-l> :vertical resize +2<cr>
nnoremap <A-h> :vertical resize -2<cr>
nnoremap <A-j> :resize -1<cr>
nnoremap <A-k> :resize +1<cr>

" Close window
nnoremap <leader>x <C-w>c

" Keep only current window
nnoremap <leader>z <C-w>o

" XML pretty formatting
if executable('xmllint')
    command! XXmlLint execute '%!xmllint --format -'
endif

" Hex dump
if executable('xxd')
    command! XHexDump execute '%!xxd'
endif

" Quick open terminal in vertical split
if has('nvim')
    command! T execute 'set shell=/bin/bash\ --login' | execute 'vsplit' | execute 'terminal' | execute 'set shell=/bin/bash'
endif


" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

" Keep vim and neovim plugins in separate paths
let plug_vim_path = '~/.vim/autoload/plug.vim'
let plugins_path = '~/.vim/plugged'
if has('nvim')
    let plug_vim_path = '~/.local/share/nvim/site/autoload/plug.vim'
    let plugins_path = '~/.local/share/nvim/plugged'
endif

" Automatically install vim-plug (https://github.com/junegunn/vim-plug)
if empty(glob(plug_vim_path))
  echo "Downloading vim-plug..."
  execute "!curl -fLo ".plug_vim_path." --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(plugins_path)

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
" Run rspecs in tmux pane, read errors to quickfix list
Plug 'tpope/vim-dispatch'
" Custom text-objects
Plug 'kana/vim-textobj-user'
" Ruby text-objects: r(uby block), f(unction), c(lass), n(ame)
Plug 'tek/vim-textobj-ruby'
" ERB text-objects: E(RB)
Plug 'whatyouhide/vim-textobj-erb'
" Open file:line
Plug 'bogado/file-line'
" Snippets
Plug 'SirVer/ultisnips'
" Show indentation lines
Plug 'yggdroot/indentline'
" Manage docker containers
Plug 'etordera/vim-docker-tools'
" Autocomplete
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Autocomplete source: syntax highlighting
    Plug 'Shougo/neco-syntax'
    " Autocomplete source: ruby
    Plug 'etordera/deoplete-ruby'
    " Autocomplete source: rails
    Plug 'etordera/deoplete-rails'
else
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
endif

call plug#end()

" NERDTree settings
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>i :NERDTreeFind<cr>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMouseMode = 2

" vim-closetag settings
let g:closetag_filenames = '*.html,*.htm,*.xml,*.erb,*.php,*.gsp'

" Ctrl-P settings
set wildignore+=*/bin/*,*tmp/*,*.class,*.zip,*.jpg,*.png
let g:ctrlp_map = '<leader>o'
let g:ctrlp_working_path_mode = 'a'
" Add kinds for universal-ctags: S for singleton methods, s for scopes
let g:ctrlp_buftag_types = { 'ruby': '--ruby-types=cfFmSs' }
nnoremap <leader>r :CtrlPMRUFiles<cr>
nnoremap <leader>m :CtrlPBufTag<cr>

" vim-rspec settings
function! RotateRSpecCommand()
    let g:rspec_command = g:rspec_commands[g:rspec_command_next]." --format documentation {spec}"
    let g:rspec_command_next = g:rspec_command_next + 1
    if g:rspec_command_next >= len(g:rspec_commands)
        let g:rspec_command_next = 0
    endif
endfunction

function! RSpecCommandInfo()
    echo "RSpec command: ".g:rspec_command
endfunction

"let g:rspec_commands = ['!rspec', '!bundle exec rspec', 'Dispatch -compiler=rspec bundle exec rspec', 'vsplit | terminal bundle exec rspec', 'terminal bundle exec rspec']
let g:rspec_commands = ['Dispatch -compiler=rspec bundle exec rspec', 'vsplit | terminal bundle exec rspec']
let g:rspec_command_next = 0
call RotateRSpecCommand()

nnoremap <Leader>sc :call RotateRSpecCommand()<cr>:call RSpecCommandInfo()<cr>
nnoremap <Leader>si :call RSpecCommandInfo()<cr>
nnoremap <Leader>sf :call RunCurrentSpecFile()<cr>
nnoremap <Leader>ss :call RunNearestSpec()<cr>
nnoremap <Leader>sl :call RunLastSpec()<cr>
nnoremap <Leader>sa :call RunAllSpecs()<cr>

" UltiSnips settings
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger = '<C-e>'

" Syntastic settings
if executable('rubocop')
    function! SaveAndRubocop()
        let g:syntastic_ruby_checkers = ['rubocop']
        write
        unlet g:syntastic_ruby_checkers
    endfunction
    nnoremap <Leader>b :call SaveAndRubocop()<cr>
endif

" Deoplete settings
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Indentline settings
let g:indentLine_enabled = 0
nnoremap <Leader>y :IndentLinesToggle<cr>

" Docker Tools settings
let g:dockertools_size = 10
nnoremap <Leader>k :DockerToolsToggle<cr>

" EasyMotion settings
let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnmñ'
