return {
  'saghen/blink.cmp',
  opts = {
    keymap = {
      ['<TAB>'] = { 'select_next', 'fallback' },
      ['<S-TAB>'] = { 'select_prev', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
      list = {
        selection = { preselect = false },
      },
    },
  },
  opts_extend = { "sources.default" }
}
