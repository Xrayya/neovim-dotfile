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

      local debugger_icons = require("xrayya.icons").debugger

      ---@param name string
      ---@param icon string
      ---@param hl string
      local function set_dap_sign(name, icon, hl)
        vim.fn.sign_define(name, { text = icon, texthl = hl, linehl = "", numhl = "" })
      end

      set_dap_sign("DapBreakpoint", debugger_icons.BreakPoint, "DiagnosticSignError")
      set_dap_sign("DapBreakpointCondition", debugger_icons.BreakPointConditional, "DiagnosticSignError")
      set_dap_sign("DapBreakpointRejected", debugger_icons.BreakPointRejected, "DiagnosticSignInfo")
      set_dap_sign("DapLogPoint", debugger_icons.BreakPointLog, "DiagnosticSignError")
      set_dap_sign("DapStopped", debugger_icons.BreakPointActive, "DiagnosticSignWarn")

      ---@param lhs string
      ---@param rhs string|fun()
      ---@param desc string
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end

      local function set_conditional_breakpoint()
        local bp_condition = vim.fn.input("Breakpoint condition: ")
        local bp_hit_condition = vim.fn.input("Breakpoint hit condition: ")
        local bp_log_message = vim.fn.input("Log message: ")
        dap.set_breakpoint(
          bp_condition ~= "" and bp_condition or nil,
          bp_hit_condition ~= "" and bp_hit_condition or nil,
          bp_log_message ~= "" and bp_log_message or nil
        )
      end

      map("<F5>", dap.continue, "Start debugger")
      map("<S-F5>", dap.terminate, "Stop debug session")
      map("<F17>", dap.terminate, "Stop debug session") -- Shift-F5 in some terminals
      map("<F10>", dap.step_over, "Step over")
      map("<F11>", dap.step_into, "Step into")
      map("<S-F11>", dap.step_out, "Step out")
      map("<F23>", dap.step_out, "Step out") -- Shift-F11 in some terminals
      map("<F9>", dap.toggle_breakpoint, "Toggle breakpoint")
      map("<S-F9>", set_conditional_breakpoint, "Set conditional breakpoint")
      map("<F21>", set_conditional_breakpoint, "Set conditional breakpoint") -- Shift-F9 in some terminals

      map("<Leader>dc", dap.continue, "Start debugger")
      map("<Leader>dt", dap.terminate, "Stop debug session")
      map("<Leader>dO", dap.step_over, "Step over")
      map("<Leader>di", dap.step_into, "Step into")
      map("<Leader>do", dap.step_out, "Step out")
      map("<Leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
      map("<Leader>dB", set_conditional_breakpoint, "Set conditional breakpoint")

      local is_ok_wk, whichkey = pcall(require, "which-key")
      if is_ok_wk then
        whichkey.add({ "<Leader>d", group = "Debugger" })
      end

      local is_ok_ov, overseer = pcall(require, "overseer")
      if is_ok_ov then
        overseer.enable_dap()
      end
    end,
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
