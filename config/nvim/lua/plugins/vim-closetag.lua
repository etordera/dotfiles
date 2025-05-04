return {
  'alvan/vim-closetag',
  config = function()
    vim.g.closetag_filenames = '*.html,*.htm,*.xml,*.erb,*.php,*.gsp,*.vue'
  end,
  -- Alternative: https://github.com/cohama/lexima.vim
}

