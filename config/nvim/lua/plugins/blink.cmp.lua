return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    keymap = {
      preset = "enter",
      ["<M-Tab>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
    },
    cmdline = { sources = { "cmdline" } },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust" },
    completion = {
      list = {
        selection = { preselect = false },
      },
    },
  },
  opts_extend = { "sources.default" },
}
