-- Ease things for Spanish keyboard
vim.api.nvim_set_keymap('n', 'ñ', '/', { noremap = true })
vim.api.nvim_set_keymap('n', 'Ñ', '?', { noremap = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Settings needed for keycodes to work in terminal vim
vim.api.nvim_set_var('<S-F3>', '\x1b[1;2R')
vim.api.nvim_set_var('<S-F4>', '\x1b[1;2S')

-- Move to next/previous quickfix location
vim.api.nvim_set_keymap('n', '<F3>', ':cnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-F3>', ':cprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F4>', ':cnfile<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-F4>', ':cpfile<CR>', { noremap = true })

-- Do a search and replace on quickfix list locations
vim.api.nvim_set_keymap('n', '<leader>R', ':cdo s//g | update<C-Left><C-Left><C-Left><Right><Right>', { noremap = true })

-- Open previous file
vim.api.nvim_set_keymap('n', '<leader>p', '<C-^>', { noremap = true })

-- Quick save
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })

-- Quick quit
vim.api.nvim_set_keymap('n', '<leader>q', ':qa<CR>', { noremap = true })

-- Delete trailing spaces
vim.api.nvim_set_keymap('n', '<leader>ds', ':s/\\v\\s+$//<CR>', { noremap = true })

-- Change ruby hashrockets to new format on current line
vim.api.nvim_set_keymap('n', '<leader>h', ':s/\\v:([A-Za-z_0-9]+) ?\\=\\>/\\1:/g<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>h', ':s/\\v:([A-Za-z_0-9]+) ?\\=\\>/\\1:/g<CR>', { noremap = true })

-- Toggle highlighting search matches
vim.api.nvim_set_keymap('n', '<leader>ll', ':set hlsearch!<CR>', { noremap = true })

-- Create tags file: only project files
vim.api.nvim_set_keymap('n', '<leader>tp', ':!ctags -R --languages=ruby,javascript,php --exclude=.git --exclude=log --exclude=node_modules --exclude=public --exclude=vendor .<CR>', { noremap = true })

-- Create tags file: groovy projects
vim.api.nvim_set_keymap('n', '<leader>tg', ':!ctags -R --languages=groovy,java,javascript --exclude=.git .<CR>', { noremap = true })

-- Jump to tag, open select window for multiple matches
vim.api.nvim_set_keymap('n', '<leader>tt', 'g<C-]>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>tt', 'g<C-]>', { noremap = true })

-- Write with sudo
vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee % > /dev/null', { noremap = true })

-- Quickly edit and save .vimrc
vim.api.nvim_set_keymap('n', '<leader>ev', ':vsp $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':w<CR>:source $MYVIMRC<CR>:q<CR>', { noremap = true })

-- Move up/down inside wrapped lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- Exit insert mode without <esc> stretch
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-n>', { noremap = true })

-- Quicker begin and end of line
vim.keymap.set('n', 'H', '0', { noremap = true })
vim.keymap.set('v', 'H', '0', { noremap = true })
vim.keymap.set('n', 'L', '$', { noremap = true })
vim.keymap.set('v', 'L', '$', { noremap = true })

-- Sensible yank to end of line
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

-- Swap 'jump to' markers
-- Easier to type ' now jumps to line and column.
vim.keymap.set('n', "'", '`', { noremap = true })
vim.keymap.set('n', '`', "'", { noremap = true })

-- Quicker change to other windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { noremap = true })

-- Resizing windows
vim.keymap.set('n', '<A-l>', ':vertical resize +2<CR>', { noremap = true })
vim.keymap.set('n', '<A-h>', ':vertical resize -2<CR>', { noremap = true })
vim.keymap.set('n', '<A-j>', ':resize -1<CR>', { noremap = true })
vim.keymap.set('n', '<A-k>', ':resize +1<CR>', { noremap = true })

-- Close window
vim.keymap.set('n', '<leader>x', '<C-w>c', { noremap = true })

-- Keep only current window
vim.keymap.set('n', '<leader>z', '<C-w>o', { noremap = true })

-- Yank current file/folder path to clipboard
vim.keymap.set('n', '<leader>yy', function()
    vim.fn.setreg('+', vim.fn.expand('%'))
    print("Copied path: " .. vim.fn.getreg('+'))
end, { noremap = true })
vim.keymap.set('n', '<leader>yb', function()
    vim.fn.setreg('+', vim.fn.expand('%:t'))
    print("Copied basename: " .. vim.fn.getreg('+'))
end, { noremap = true })
vim.keymap.set('n', '<leader>yf', function()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
    print("Copied full path: " .. vim.fn.getreg('+'))
end, { noremap = true })

-- Open file from path in clipboard
vim.keymap.set('n', '<leader>yo', ':e <C-r>+<CR>', { noremap = true })

-- Toggle word wrapping
vim.keymap.set('n', '<leader>a', function()
    vim.wo.wrap = not vim.wo.wrap
end, { noremap = true })

-- Move visually selected lines up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- Set and clear diff mode
vim.keymap.set('n', '<leader>dt', ':diffthis<CR>', { noremap = true })
vim.keymap.set('n', '<leader>do', ':diffoff!<CR>', { noremap = true })

-- Sort and get unique values from spreadsheet copied data
vim.keymap.set('n', '<leader>su', [[ggVG:s/\s\+/\r/g<CR>:g/^$/d<CR>VG<Esc>ggVG:sort u<CR>]], { noremap = true })

-- Sort and get count of values from spreadsheet copied data
vim.keymap.set('n', '<leader>suc', [[ggVG:s/\s\+/\r/g<CR>:g/^$/d<CR>VG<Esc>ggVG:sort<CR>VG:!uniq -c \| sort -r<CR>]], { noremap = true })

-- Decode Base64 values
if vim.fn.executable('decode64') == 1 then
    vim.keymap.set('n', '<leader>v', function()
        local word = vim.fn.expand('<cWORD>')
        vim.fn.setreg('+', vim.fn.system('decode64 ' .. word))
        vim.fn.setreg('0', vim.fn.getreg('+'))
        print(vim.fn.getreg('+'))
    end, { noremap = true })
end
