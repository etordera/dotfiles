return {
  'yggdroot/indentline',
  config = function()
    vim.g.indentLine_enabled = 0
    vim.g.indentLine_char_list = {'|', '¦', '┆', '┊'}

    local function color_column_toggle()
      local new_colorcolumn = ""
      if (vim.o.colorcolumn == "") then new_colorcolumn = "100" end
      vim.o.colorcolumn = new_colorcolumn
    end

    vim.keymap.set("n", "<Leader><TAB>", function()
      vim.cmd("IndentLinesToggle")
      color_column_toggle()
    end, { noremap = true })
  end,
}
