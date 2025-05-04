return {
  "preservim/nerdtree",
  cmd = { 'NERDTreeToggle', 'NERDTreeFind' },
  config = function()
    vim.g.NERDTreeAutoDeleteBuffer = 1
    vim.g.NERDTreeMouseMode = 2
  end,
  keys = {
    { '<leader>n', '<cmd>NERDTreeToggle<CR>', desc = "Toggle NERDTree" },
    { '<leader>i', '<cmd>NERDTreeFind<CR>', desc = "Find file in NERDTree" },
  },
}
