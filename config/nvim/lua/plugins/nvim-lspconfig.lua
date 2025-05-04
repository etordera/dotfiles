return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup({})

    vim.keymap.set('n', '<leader>ld', function()
      vim.diagnostic.open_float()
    end, { desc = 'Show diagnostic in floating window' })
    vim.keymap.set('n', '<leader>lq', function()
      vim.diagnostic.setqflist()
      vim.cmd('copen')
    end, { desc = "Open diagnostics in quickfix list" })
  end,
}
