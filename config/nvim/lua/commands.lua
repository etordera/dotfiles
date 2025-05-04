-- Use ripgrep for grepping
if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --vimgrep --smart-case'
  vim.api.nvim_command('command! -nargs=+ -complete=file RG execute \'silent grep! \'.<q-args> | execute \'redraw!\' | execute \'copen\'')
end

-- XML pretty formatting
if vim.fn.executable('xmllint') == 1 then
  vim.api.nvim_create_user_command('XXmlLint', '%!xmllint --format -', {})
end

-- HTML pretty formatting
if vim.fn.executable('tidy') == 1 then
  vim.api.nvim_create_user_command('XHtmlFormat', '%!tidy -quiet -indent --wrap 100 --tidy-mark no --drop-empty-elements no --show-warnings no', {})
end

-- JSON pretty formatting
if vim.fn.executable('jq') == 1 then
  vim.api.nvim_create_user_command('XJsonPretty', '%!jq .', {})
end

-- Hex dump
if vim.fn.executable('xxd') == 1 then
  vim.api.nvim_create_user_command('XHexDump', '%!xxd', {})
end

-- Quick open terminal in vertical split
vim.api.nvim_create_user_command('T', function()
  vim.o.shell = '/bin/bash --login'
  vim.cmd('vsplit | terminal')
  vim.o.shell = '/bin/bash'
end, {})
