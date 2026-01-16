---@module "lazy"
---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      local dap = require("dap")

      dap.adapters = opts.adapters or {}
      dap.configurations = opts.configurations or {}

      if vim.fn.has("unix") and vim.fn.executable("kitty") == 1 then
        dap.defaults.fallback.external_terminal = {
          command = "/usr/bin/kitty",
          args = { "-e" },
        }
      elseif vim.fn.has("win32") then
        -- WARNING: not tested yet
        dap.defaults.fallback.external_terminal = {
          command = "wt.exe",
          args = { "powershell", "-NoExit" },
        }
      end

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
        desc = "Step into",
      },
      {
        "<S-F11>",
        function()
          require("dap").step_out()
        end,
        mode = { "n" },
        desc = "Step out",
      },
      {
        "<F23>", -- in case terminal process it this way
        function()
          require("dap").step_out()
        end,
        mode = { "n" },
        desc = "Step out",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        mode = { "n" },
        desc = "Toggle breakpoint",
      },
      {
        "<S-F9>",
        function()
          vim.ui.select({ "normal", "condition", "hit condition", "log message" }, {
            prompt = "Select the type of breakpoint:",
            format_item = function(item)
              local format = "Set breakpoint"
              if item == "normal" then
                format = format .. " (normal)"
              else
                format = format .. " with " .. item
              end
              return format
            end,
          }, function(item, _)
            if item == "normal" then
              require("dap").set_breakpoint()
            elseif item == "condition" then
              require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
            elseif item == "hit condition" then
              require("dap").set_breakpoint(nil, vim.fn.input("Breakpoint hit condition: "))
            elseif item == "log message" then
              require("dap").set_breakpoint(nil, nil, vim.fn.input("Log message: "))
            end
          end)
        end,
        mode = { "n" },
        desc = "Set conditional breakpoint",
      },
      {
        "<F21>", -- in case terminal process it this way
        function()
          vim.ui.select({ "normal", "condition", "hit condition", "log message" }, {
            prompt = "Select the type of breakpoint:",
            format_item = function(item)
              local format = "Set breakpoint"
              if item == "normal" then
                format = format .. " (normal)"
              else
                format = format .. " with " .. item
              end
              return format
            end,
          }, function(item, _)
            if item == "normal" then
              require("dap").set_breakpoint()
            elseif item == "condition" then
              require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
            elseif item == "hit condition" then
              require("dap").set_breakpoint(nil, vim.fn.input("Breakpoint hit condition: "))
            elseif item == "log message" then
              require("dap").set_breakpoint(nil, nil, vim.fn.input("Log message: "))
            end
          end)
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
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        controls = {
          enabled = true,
        },
      },
    },
    config = function(_, opts)
      local dapview = require("dap-view")
      dapview.setup(opts)

      local is_ok, dap = pcall(require, "dap")
      if is_ok then
        dap.listeners.before.attach.dapui_config = function()
          dapview.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapview.open()
        end
      end
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
