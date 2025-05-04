-- Open Handbook preview
local function open_handbook_preview()
  local filename_no_ext = vim.fn.expand('%:r')
  local suffix = ".html"
  if string.find(filename_no_ext, 'README$') then
    filename_no_ext = filename_no_ext:sub(1, #filename_no_ext - 6)
    suffix = ""
  end
  local url = "http://localhost:8100/" .. filename_no_ext .. suffix

  vim.cmd("!" .. "open " .. vim.fn.shellescape(url))
  vim.cmd("redraw!")
end
vim.api.nvim_set_keymap('n', '<leader>sh', '', {
  noremap = true,
  callback = open_handbook_preview,
  desc = 'Open Handbook preview in browser'
})

-- Map <leader>º to open log.txt in a vertical split
vim.api.nvim_set_keymap('n', '<leader>º', '', {
  noremap = true,
  callback = function()
    vim.cmd('vsp ~/workspaces/enric/log.txt')
  end,
  desc = 'Open log.txt in vsplit',
})

-- Map <leader>1 to open log-tirant.txt in a vertical split
vim.api.nvim_set_keymap('n', '<leader>1', '', {
  noremap = true,
  callback = function()
    vim.cmd('vsp ~/workspaces/enric/log-tirant.txt')
  end,
  desc = 'Open log-tirant.txt in vsplit',
})
