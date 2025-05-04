return {
  'vim-test/vim-test',
  cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
  config = function()
    local function read_first_line(filename)
      local file = io.open(filename, "r")
      if not file then
        return nil
      end
      local line = file:read()
      file:close()
      return line
    end

    local function custom_test_strategy(cmd)
      local custom_command = read_first_line(".vim_test_commands")
      if custom_command then
        vim.cmd(custom_command .. " " .. cmd)
      else
        vim.cmd("vsplit | terminal " .. cmd)
      end
    end

    vim.g['test#strategy'] = "custom"
    vim.g['test#custom_strategies'] = { custom = custom_test_strategy }

    vim.g['test#python#runner'] = "pytest"
    vim.g['test#ruby#use_binstubs'] = 0
  end,
  keys = {
    { '<leader>sf', '<cmd>lua Close_auxiliar_windows()<cr><cmd>TestFile<CR>', desc = "spec file: Run test file" },
    { '<leader>ss', '<cmd>lua Close_auxiliar_windows()<cr><cmd>TestNearest<CR>', desc = "spec spec: Run nearest test" },
    { '<leader>sl', '<cmd>lua Close_auxiliar_windows()<cr><cmd>TestLast<CR>', desc = "spec last: Run again last executed test" },
    { '<leader>sa', '<cmd>lua Close_auxiliar_windows()<cr><cmd>TestSuite<CR>', desc = "spec all: Run whole test suite" },
    { '<leader>sp', '<cmd>TestVisit<CR>', desc = "spec previous: Return to last executed test location" },
  },
}
