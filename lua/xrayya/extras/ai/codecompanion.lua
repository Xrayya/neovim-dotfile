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
            local has_secrets, secrets = pcall(require, "secrets")
            return require("codecompanion.adapters").extend("vertex-gemini", {
              env = {
                project_id = has_secrets and secrets.gcp_project_id or "fallback-project-id",
                region = has_secrets and secrets.gcp_region or "global",
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
