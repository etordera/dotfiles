require("settings")
require("filetypes")
require("keymaps")
require("commands")
require("functions")
require("colorscheme")
require("config.lazy")
require("statusline")
if vim.fn.filereadable(vim.fn.stdpath('config') .. '/lua/local_settings.lua') == 1 then
  require('local_settings')
end
