return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "lua", "pug", "vim", "vimdoc", "vue", "ruby", "python", "php", "javascript", "html", "yaml"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
