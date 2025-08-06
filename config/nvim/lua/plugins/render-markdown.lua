return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'markdown', 'codecompanion' },
  opts = {
    file_types = { 'markdown', 'codecompanion' },
  },
  keys = {
    { '<Leader>M', ':RenderMarkdown buf_toggle<CR>', mode = 'n', desc = 'Toggle RenderMarkdown' },
  },
}
