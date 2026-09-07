---@module "lazy"
---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      {
        "Xrayya/cc-adapter-vertex-ai.nvim",
      },
    },
    opts = {
      interactions = {
        chat = {
          adapter = "vertex_gemini",
        },
        inline = {
          adapter = "vertex_gemini",
        },
      },
      adapters = {
        http = {
          vertex_gemini = function()
            return require("codecompanion.adapters").extend("vertex-gemini", {
              env = {
                project_id = "valid_id",
                region = "global",
              },
            })
          end,
        },
      },
    },
  },
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
}
