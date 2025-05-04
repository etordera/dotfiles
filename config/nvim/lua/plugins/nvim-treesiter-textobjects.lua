return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ak"] = "@block.outer",
            ["ik"] = "@block.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
          selection_modes = {
            ['@block.outer'] = 'V',
            ['@block.inner'] = 'V',
            ['@function.outer'] = 'V',
            ['@function.inner'] = 'V',
            ['@class.outer'] = 'V',
            ['@class.inner'] = 'V',
          },
        },
      },
    })
  end,
}
