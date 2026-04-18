return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter")

    configs.setup({
      ensure_installed = {
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "php",
        "pug",
        "python",
        "ruby",
        "vim",
        "vimdoc",
        "vue",
        "yaml"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
