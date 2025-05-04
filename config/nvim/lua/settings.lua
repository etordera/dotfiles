-- Searching and replacing
vim.opt.ignorecase = true      -- Searches are case-insensitive
vim.opt.smartcase = true       -- Search case-sensitively for terms with uppercase letters
vim.opt.incsearch = true       -- Show search hits while typing
vim.opt.hlsearch = false       -- Do not highlight search hits
vim.opt.inccommand = 'nosplit' -- Highlight and preview replace for substitute command

-- Indentation and tabs
vim.opt.autoindent = true      -- Copy indent from current line when starting a new line
vim.opt.tabstop = 2            -- A <Tab> is 2 spaces
vim.opt.shiftwidth = 2         -- Indentation shift is 2 spaces
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.backspace = { 'indent', 'eol', 'start' }  -- Sensible backspace behaviour

-- Share default register with system clipboard
if vim.fn.has('mac') == 1 then
  vim.opt.clipboard = 'unnamed'
else
  vim.opt.clipboard = 'unnamedplus'
end

-- Miscellaneous
vim.opt.number = true               -- Line numbers
vim.opt.background = 'light'        -- Use colors for light background
vim.opt.wrap = false                -- Don't wrap long lines
vim.opt.splitright = true           -- Split horizontal to right
vim.opt.splitbelow = true           -- Split vertical below
vim.opt.mouse = 'a'                 -- Enable mouse
vim.opt.scrolloff = 4               -- Keep 4 lines off the edges when scrolling
vim.opt.sidescrolloff = 8           -- Keep 8 columns off the edges when scrolling horizontally
vim.opt.hidden = false              -- Remove buffers when closing windows
vim.opt.nrformats = { 'bin', 'hex' }       -- <C-a>, <C-x> don't mess with 0-padded numbers (octal)
vim.opt.diffopt = { 'filler', 'vertical' } -- Open diff windows with vertical split

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true
})
