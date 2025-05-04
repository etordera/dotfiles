return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<leader>o", function() require('telescope.builtin').find_files({previewer = false}) end, desc = "Find Files (no preview)" },
    { "<leader>g", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>f", "<cmd>Telescope grep_string<CR>", desc = "Grep string" },
    { "<leader>r", function() require('telescope.builtin').oldfiles({previewer = false, only_cwd = true}) end, desc = "Recent files in cwd" },
    { "<leader>m", "<cmd>Telescope current_buffer_tags only_sort_tags=true<CR>", desc = "Buffer tags" },
    { "<leader>T", "<cmd>Telescope resume<CR>", desc = "Resume last Telescope session" },
    { "<leader>ñ", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy find in current buffer" },
    {
      "<leader>g",
      function()
        vim.cmd('normal "zy')
        vim.cmd('exec "Telescope live_grep default_text=" . escape(@z, \' [?\')')
      end,
      desc = "Live grep visual selection",
      mode = "v"
    },
  },
}
