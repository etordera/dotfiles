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
    vim.lsp.config('lua_ls',{})
    vim.lsp.config('pyright',{
      cmd = { 'lsp-server-wrapper.rb' },
    })
    -- vim.lsp.config('ruby_lsp', {})

    vim.keymap.set('n', '<leader>ld', function()
      vim.diagnostic.open_float()
    end, { desc = 'Show diagnostic in floating window' })
    vim.keymap.set('n', '<leader>lq', function()
      vim.diagnostic.setqflist()
      vim.cmd('copen')
    end, { desc = "Open diagnostics in quickfix list" })
  end,
}
