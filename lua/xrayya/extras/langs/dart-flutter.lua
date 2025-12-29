---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "dart", "comment" },
        ensure_highlight = { "dart", "comment" },
        ensure_indent = { "dart" },
        ensure_fold = { "dart" },
      })
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    ---@module "flutter-tools"
    ---@type flutter.Config
    opts = {
      debugger = {
        enabled = true,
      },
      dev_log = {
        enabled = false,
      },
      fvm = vim.fn.executable("fvm") == 1,
      settings = {
        renameFilesWithClasses = "always",
      },
      widget_guides = {
        enabled = true,
      },
    },
    config = function(_, opts)
      require("flutter-tools").setup(opts)

      local dap = require("dap")

      vim.api.nvim_create_user_command("FlutterHotReload", function(_)
        if dap.status() ~= "" then
          dap.repl.execute(".hot-reload")
        end
      end, {})

      vim.api.nvim_create_augroup("FlutterHotReload", {})
      vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
        pattern = { "*.dart" },
        group = "FlutterHotReload",
        callback = function(_)
          vim.cmd("FlutterHotReload")
        end,
      })
    end,
  },
}
