" ------------------------------------------------------------------------------
" Configuration / options
" ------------------------------------------------------------------------------

" Searching
set ignorecase    " Searches are case-insensitive
set smartcase     " Search case-sensitively for terms with uppercase letters
set incsearch     " Show search hits while typing
set nohlsearch    " Do not highlight search hits
set inccommand=nosplit   " Highlight and preview replace for substitute command

" Indentation and tabs
set autoindent       " Copy indent from current line when starting a new line
set tabstop=4        " A <Tab> is 4 spaces
set shiftwidth=4     " Indentation shift is 4 spaces
set expandtab        " Use spaces instead of tabs
set backspace=indent,eol,start      " Sensible backspace behaviour

" Use old vim colorscheme instead of neovim 0.10 defaults
colorscheme vim
set notermguicolors

" Custom status line
set laststatus=2
set statusline=%f%<\ %q%h%w%m%r
set statusline+=%=
set statusline+=[%b\ 0x%B]
set statusline+=\ 
set statusline+=%l/%L
set statusline+=:%c
set statusline+=\ 
set statusline+=%#PmenuSel#
set statusline+=%{FugitiveStatusline()}
set statusline+=%#LineNr#
highlight StatusLineNC ctermfg=242
highlight StatusLine ctermfg=240

" Auto commands
augroup etordera
    autocmd!
    " Tab sizes per file type
    autocmd Filetype html,css,scss,eruby,xml,yaml,eruby.yaml,ruby,haml,javascript,vue,json,gsp setlocal tabstop=2 shiftwidth=2
    " Keyword chars per file type
    autocmd Filetype ruby setlocal iskeyword+=?
    autocmd Filetype haml setlocal iskeyword+=?,-
    autocmd Filetype javascript,scss setlocal iskeyword+=-
    " Disable deoplete plugin autocompletion inside Telescope prompts
    autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)
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
set nohidden           " Remove buffers when closing windows

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
let maplocalleader = " "

" Use ripgrep for grepping
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    command! -nargs=+ -complete=file RG execute 'silent grep! '.<q-args> | execute 'redraw!' | execute 'copen'
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
nnoremap <leader>R :cdo s//g \| update<C-Left><C-Left><C-Left><Right><Right>

" Open previous file
nnoremap <leader>p <C-^>

" Quick save
nnoremap <leader>w :w<cr>

" Quick quit
nnoremap <leader>q :qa<cr>

" Delete trailing spaces
nnoremap <leader>ds :s/\v\s+$//<cr>

" Close quickfix/local list, fugitive and test windows
function! CloseTestWindow()
    let l:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    for l:item in l:blist
        if match(l:item.name, 'phpunit\|rspec\|jest\|vue-cli-service test\|pytest') >= 0
            execute "bdelete " . l:item.bufnr
        endif
    endfor
endfunction
function! CloseFugitiveWindow()
    let fugitive_winnr = bufwinnr('/.git/index$')
    if fugitive_winnr != -1
        exe fugitive_winnr . "wincmd c"
    endif
endfunction
nnoremap <leader>c :cclose<cr>:lclose<cr>:call CloseFugitiveWindow()<cr>:call CloseTestWindow()<cr>

" Change ruby hashrockets to new format on current line
nnoremap <leader>h :s/\v:([A-Za-z_0-9]+) ?\=\>/\1:/g<cr>
vnoremap <leader>h :s/\v:([A-Za-z_0-9]+) ?\=\>/\1:/g<cr>

" Toggle highlighting search matches
nnoremap <leader>ll :set hlsearch!<cr>

" Create tags file: only project files
nnoremap <leader>tp :!ctags -R --languages=ruby,javascript,php --exclude=.git --exclude=log --exclude=node_modules .<cr>
" Create tags file: groovy projects
nnoremap <leader>tg :!ctags -R --languages=groovy,java,javascript --exclude=.git .<cr>
" Create tags file: project files and bundled gems
nnoremap <leader>tb :!ctags -R --languages=ruby,javascript --exclude=.git --exclude=log . $(bundle show --paths \| grep ^/)<cr>
" Jump to tag, open select window for multiple matches
nnoremap <leader>tt g<C-]>
vnoremap <leader>tt g<C-]>

" Write with sudo
cnoremap w!! w !sudo tee % > /dev/null

" Quickly edit and save .vimrc
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :w<cr>:source $MYVIMRC<cr>:q<cr>

" Move up/down inside wrapped lines
nnoremap j gj
nnoremap k gk

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

" Yank current file/folder path to clipboard
nnoremap <leader>yy :let @+=expand('%')<cr> \| :echo "Copied path:"@+<cr>
nnoremap <leader>yb :let @+=expand('%:t')<cr> \| :echo "Copied basename:"@+<cr>
nnoremap <leader>yf :let @+=expand('%:p')<cr> \| :echo "Copied full path:"@+<cr>

" Open file from path in clipboard
nnoremap <leader>yo :e <C-r>+<cr>

" Toggle word wrapping
nnoremap <leader>a :set wrap!<cr>

" Move visually selected lines up and down
vnoremap J :m '>+1<cr>gv
vnoremap K :m '<-2<cr>gv

" Set and clear diff mode
nnoremap <leader>dt :diffthis<cr>
nnoremap <leader>do :diffoff!<cr>

" XML pretty formatting
if executable('xmllint')
    command! XXmlLint execute '%!xmllint --format -'
endif

" JSON pretty formatting
if executable('jq')
    command! XJsonPretty execute '%!jq .'
endif

" Hex dump
if executable('xxd')
    command! XHexDump execute '%!xxd'
endif

" Quick open terminal in vertical split
if has('nvim')
    command! T execute 'set shell=/bin/bash\ --login' | execute 'vsplit' | execute 'terminal' | execute 'set shell=/bin/bash'
endif

" Decode Base64 values
if executable('decode64')
    nnoremap <leader>v :let @+ = system('decode64 <C-r>=expand("<cWORD>")<cr>')<cr> \| :let @0=@+<cr> \| :echom @+<cr>
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
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
" Check syntax inside vim
Plug 'dense-analysis/ale'
" Running tests/rspecs
Plug 'vim-test/vim-test'
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
" Autocomplete
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Autocomplete source: syntax highlighting
    Plug 'Shougo/neco-syntax'
    " Autocomplete source: ruby
    Plug 'etordera/deoplete-ruby'
    " Autocomplete source: rails
    Plug 'etordera/deoplete-rails'
    " Autocomplete source: rspec
    Plug 'etordera/deoplete-rspec'
endif
" Dart syntax highlighting
Plug 'dart-lang/dart-vim-plugin'
" Vue syntax highlighting
Plug 'leafOfTree/vim-vue-plugin'
" Rubocop autocorrection
if executable('rubocop')
    Plug 'etordera/vim-rubocop-autocorrect'
endif
" nginx syntax highlighting
Plug 'chr4/nginx.vim'

call plug#end()

" NERDTree settings
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>i :NERDTreeFind<cr>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMouseMode = 2

" vim-closetag settings
let g:closetag_filenames = '*.html,*.htm,*.xml,*.erb,*.php,*.gsp,*.vue'

" Telescope settings
nnoremap <leader>o :lua require('telescope.builtin').find_files({previewer = false})<cr>
nnoremap <leader>g :Telescope live_grep<cr>
vnoremap <leader>g "zy<cmd>exec 'Telescope live_grep default_text=' . escape(@z, ' [?')<cr>
nnoremap <leader>f :Telescope grep_string<cr>
nnoremap <leader>r :lua require('telescope.builtin').oldfiles({previewer = false, only_cwd = true})<cr>
nnoremap <leader>m :Telescope current_buffer_tags only_sort_tags=true<cr>
nnoremap <leader>T :Telescope resume<cr>
nnoremap <leader>F :Telescope current_buffer_fuzzy_find<cr>

" vim-test settings
function! InitTestCommands()
    let config_file = '.vim_test_commands' 
    if filereadable(config_file)
        let g:test_commands = readfile(config_file)
    else
        let g:test_commands = ['vsplit | terminal', 'Dispatch -compiler=rspec',]
    endif
    let g:test_command_current = 0
endfunction
call InitTestCommands()

function! RotateTestCommand()
    let g:test_command_current = g:test_command_current + 1
    if g:test_command_current >= len(g:test_commands)
        let g:test_command_current = 0
    endif
endfunction

function! TestCommandInfo()
    echo "Test command: ".g:test_commands[g:test_command_current]
endfunction

function! CustomTestStrategy(cmd)
    let l:command = g:test_commands[g:test_command_current]
    let l:options = ''
    if  l:command =~ '.*Dispatch.*'
        let l:options = ' --no-color'
    endif
    execute l:command . ' ' . a:cmd . l:options
endfunction

let test#ruby#use_binstubs = 0
let g:test#custom_strategies = {'custom': function('CustomTestStrategy')}
let g:test#strategy = 'custom'
let test#python#runner = 'pytest'

nnoremap <Leader>sc :call RotateTestCommand()<cr>:call TestCommandInfo()<cr>
nnoremap <Leader>si :call TestCommandInfo()<cr>
nnoremap <Leader>sf :call CloseTestWindow()<cr>:TestFile<cr>
nnoremap <Leader>ss :call CloseTestWindow()<cr>:TestNearest<cr>
nnoremap <Leader>sl :call CloseTestWindow()<cr>:TestLast<cr>
nnoremap <Leader>sa :call CloseTestWindow()<cr>:TestSuite<cr>

" UltiSnips settings
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger = '<C-e>'

" ALE settings
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_linters = { 'ruby': ['rubocop'] }
let rubocop_executable_file = './.vim_rubocop_executable' 
if filereadable(rubocop_executable_file)
    let g:ale_ruby_rubocop_executable = rubocop_executable_file
endif
nnoremap <Leader>lt :ALEToggleBuffer<cr>

" Deoplete settings
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Indentline settings
function! ColorColumnToggle()
    let newcolorcolumn = &colorcolumn == "" ? "100" : ""
    let &colorcolumn = newcolorcolumn
endfunction
let g:indentLine_enabled = 0
nnoremap <Leader><TAB> :IndentLinesToggle<cr>:call ColorColumnToggle()<cr>

" EasyMotion settings
let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnmñ'

" Fugitive -> Fold changes in Gclog
nnoremap <leader>G :setlocal foldmethod=syntax<cr>

" vim-vue-plugin settings
let g:vim_vue_plugin_config = { 
      \'syntax': {
      \   'template': ['html'],
      \   'script': ['javascript'],
      \   'style': ['css', 'scss', 'sass'],
      \},
      \'full_syntax': [],
      \'initial_indent': [],
      \'attribute': 0,
      \'keyword': 1,
      \'foldexpr': 0,
      \'debug': 0,
      \}

function! OnChangeVueSyntax(syntax)
  if a:syntax == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:syntax =~ '\vsass|scss|css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction
