-- Autocommand group
vim.api.nvim_create_augroup("etordera", { clear = true })

-- Tab sizes per file type
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "php", "python", "sh" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
  group = "etordera",
})

-- Keyword chars per file type
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "ruby" },
  callback = function()
    vim.opt_local.iskeyword:append("?")
  end,
  group = "etordera",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "haml" },
  callback = function()
    vim.opt_local.iskeyword:append("?,-")
  end,
  group = "etordera",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "javascript", "scss" },
  callback = function()
    vim.opt_local.iskeyword:append("-")
  end,
  group = "etordera",
})
