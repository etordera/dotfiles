-- Ease things for Spanish keyboard
vim.keymap.set('n', 'ñ', '/', { noremap = true })
vim.keymap.set('n', 'Ñ', '?', { noremap = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Open previous file
vim.api.nvim_set_keymap('n', '<leader>p', '<C-^>', { noremap = true })

-- Quick save
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })

-- Delete trailing spaces
vim.api.nvim_set_keymap('n', '<leader>ds', ':s/\\v\\s+$//<CR>', { noremap = true })

-- Change ruby hashrockets to new format on current line
vim.api.nvim_set_keymap('n', '<leader>h', ':s/\\v:([A-Za-z_0-9]+) ?\\=\\>/\\1:/g<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>h', ':s/\\v:([A-Za-z_0-9]+) ?\\=\\>/\\1:/g<CR>', { noremap = true })

-- Add frozen_string_literal on top of file
vim.api.nvim_set_keymap('n', '<leader>F', 'ggO# frozen_string_literal:true<CR><ESC>cc<ESC>', { noremap = true })

-- Jump to tag, open select window for multiple matches
vim.api.nvim_set_keymap('n', '<leader>tt', 'g<C-]>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>tt', 'g<C-]>', { noremap = true })

-- Move up/down inside wrapped lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- Exit insert mode without <esc> stretch
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true })

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
