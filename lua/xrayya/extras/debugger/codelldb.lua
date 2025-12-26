---@module "lazy"
---@type LazySpec
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    ---@module "mason-nvim-dap"
    ---@type MasonNvimDapSettings
    opts = {
      ensure_installed = { "codelldb" },
      handlers = {
        codelldb = function(config)
          local extended_configurations = {
            {
              name = "LLDB: Launch current file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.expand("%:p:r") .. (vim.fn.has("win32") > 0 and ".exe" or ".out")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
              args = {},
              console = "integratedTerminal",
            },
            {
              name = "LLDB: Launch current file (args)",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.expand("%:p:r") .. (vim.fn.has("win32") > 0 and ".exe" or ".out")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
              args = function()
                return vim.split(vim.fn.input("Args: "), " +", { trimempty = true })
              end,
              console = "integratedTerminal",
            },
          }

          config.configurations = config.configurations or {}
          vim.list_extend(config.configurations, extended_configurations)

          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
