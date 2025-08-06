return {
  "olimorris/codecompanion.nvim",
  cmd = { 'CodeCompanion', 'CodeCompanionChat' },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
    },
    opts = {
      log_level = "DEBUG", -- or "TRACE"
    }
  },
  keys = {
    { "<leader>C", "<cmd>CodeCompanionChat Toggle<cr>", desc="CodeCompation Chat" },
  },
  config = function()
    require("codecompanion").setup({
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools 
            make_tools = true,              -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true,      -- Show tool results directly in chat buffer
            format_tool = nil,               -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            -- MCP Resources
            make_vars = true,                -- Convert MCP resources to #variables for prompts
            -- MCP Prompts 
            make_slash_commands = true,      -- Add MCP prompts as /slash commands
          }
        }
      }
    })
  end,
}
