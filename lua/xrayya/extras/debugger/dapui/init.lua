local dapui_layouts = require("xrayya.extras.debugger.dapui.layout")

---@module "lazy"
---@type LazySpec
return {
  -- NOTE: Typically you need to enable module `essentials.debugger` first
  -- NOTE: You might want to disable `nvim-dap-view` (`lua/xrayya/essentials/debuggger.lua`)
  -- since it has the same functionalities
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

    vim.api.nvim_create_user_command("DapuiLayoutRunningConsole", function(_)
      setup_dap_with_layout(dapui_layouts.running_console)
    end, {})
    vim.api.nvim_create_user_command("DapuiLayoutRunning", function(_)
      setup_dap_with_layout(dapui_layouts.running)
    end, {})
    vim.api.nvim_create_user_command("DapuiLayoutDebugging", function(_)
      setup_dap_with_layout(dapui_layouts.debugging)
    end, {})
    vim.api.nvim_create_user_command("DapuiLayoutDebuggingConsole", function(_)
      setup_dap_with_layout(dapui_layouts.debugging_console)
    end, {})

    vim.api.nvim_create_user_command("DapuiToggle", function(_)
      dapui.toggle()
    end, {})

    vim.keymap.set("n", "<Leader>d", function()
      require("dapui").toggle()
    end, { desc = "Toggle DAP UI" })
  end,
}
