local dapui_layouts = require("xrayya.essentials.debugger.layout")

---@module "lazy"
---@type LazySpec
return {
  { "mfussenegger/nvim-dap" },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      opts = {},
    },
    opts = {},
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    ---@module "dapui"
    ---@type dapui.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      layouts = dapui_layouts.running_console,
    },
    config = function(_, opts)
      local dapui = require("dapui")
      local dap = require("dap")

      dapui.setup(opts)

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      local function setup_dap_with_layout(layout)
        local dapui_opts = vim.tbl_deep_extend("force", opts, {
          layouts = layout,
        })

        dapui.setup(dapui_opts)
      end

      setup_dap_with_layout(dapui_layouts.running_console)

      vim.api.nvim_create_user_command("DapSetupRunningConsole", function(_)
        setup_dap_with_layout(dapui_layouts.running_console)
      end, {})
      vim.api.nvim_create_user_command("DapSetupRunning", function(_)
        setup_dap_with_layout(dapui_layouts.running)
      end, {})
      vim.api.nvim_create_user_command("DapSetupDebugging", function(_)
        setup_dap_with_layout(dapui_layouts.debugging)
      end, {})
      vim.api.nvim_create_user_command("DapSetupDebuggingConsole", function(_)
        setup_dap_with_layout(dapui_layouts.debugging_console)
      end, {})
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ---@module "nvim-dap-virtual-text"
    ---@type nvim_dap_virtual_text_options
    opts = {
      only_first_definition = false,
      all_references = true,
    },
  },
}
