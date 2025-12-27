local dapui_layouts = require("xrayya.essentials.debugger.layout")

---@module "lazy"
---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      local is_ok, overseer = pcall(require, "overseer")
      if is_ok then
        overseer.enable_dap()
      end
    end,
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        mode = { "n" },
        desc = "Start debugger",
      },
      {
        "<S-F5>",
        function()
          require("dap").terminate()
        end,
        mode = { "n" },
        desc = "Stop debug session",
      },
      {
        "<F17>", -- in case terminal process it this way
        function()
          require("dap").terminate()
        end,
        mode = { "n" },
        desc = "Stop debug session",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        mode = { "n" },
        desc = "Step over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        mode = { "n" },
        desc = "Step over",
      },
      {
        "<S-F11>",
        function()
          require("dap").step_out()
        end,
        mode = { "n" },
        desc = "Step over",
      },
      {
        "<F23>", -- in case terminal process it this way
        function()
          require("dap").step_out()
        end,
        mode = { "n" },
        desc = "Step over",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        mode = { "n" },
        desc = "Step over",
      },
      {
        "<S-F9>",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        mode = { "n" },
        desc = "Set conditional breakpoint",
      },
      {
        "<F21>", -- in case terminal process it this way
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        mode = { "n" },
        desc = "Set conditional breakpoint",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      opts = {},
    },
    ---@module "mason-nvim-dap"
    ---@type MasonNvimDapSettings
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { "nvim-dap-ui" },
          },
        },
      },
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

      vim.api.nvim_create_user_command("DapUIToggle", function(_)
        dapui.toggle()
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
