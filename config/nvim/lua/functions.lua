-- Close auxiliar windows
function Close_auxiliar_windows()
  local test_patterns = {
    "^term:.*phpunit",
    "^term:.*rspec",
    "^term:.*jest",
    "^term:.*vue-cli-service test",
    "^term:.*pytest",
    "^fugitive:",
  }

  vim.cmd('cclose')
  vim.cmd('lclose')
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_is_valid(buf) then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      for _, pattern in ipairs(test_patterns) do
        if string.find(buf_name, pattern) then
          vim.cmd("close " .. win)
        end
      end
    end
  end
end
vim.keymap.set("n", "<leader>c", Close_auxiliar_windows, { desc = "Close auxiliar windows" })
