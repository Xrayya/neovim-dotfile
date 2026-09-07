---@module "lazy"
---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "viespejo/cc-adapter-vertex-ai.nvim",
    },
    init = function()
      -- Backward compatibility shim: recent versions of codecompanion.nvim moved
      -- `codecompanion.utils.adapters` to `codecompanion.adapters.utils`.
      -- cc-adapter-vertex-ai.nvim imports the old module path.
      package.preload["codecompanion.utils.adapters"] = function()
        return require("codecompanion.adapters.utils")
      end
    end,
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
