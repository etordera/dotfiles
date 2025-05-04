return {
  'dense-analysis/ale',
  lazy = false,
  init = function()
    vim.g.ale_virtualtext_cursor = 'disabled'
    vim.g.ale_linters = { ruby = { 'rubocop' } }

    local rubocop_executable_file = './.vim_rubocop_executable'
    if vim.fn.filereadable(rubocop_executable_file) == 1 then
      vim.g.ale_ruby_rubocop_executable = rubocop_executable_file
    end
  end,
  keys = {
    { '<Leader>lt', ':ALEToggleBuffer<CR>', mode = 'n', desc = 'Toggle ALE buffer diagnostics' },
  },
}
