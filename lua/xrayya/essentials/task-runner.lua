---@module "lazy"
---@type LazySpec
return {
  {
    "stevearc/overseer.nvim",
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {
      dap = false,
    },
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      local is_ok, wk = pcall(require, "which-key")
      if is_ok then
        local icon = require("xrayya.icons").ui.HammerWrench
        wk.add({ "<Leader>t", group = "Task Runner", icon = icon })
      end

      ---@param lhs string
      ---@param rhs string|fun()
      ---@param desc string
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end

      map("<Leader>to", overseer.toggle, "Toggle list")
      map("<Leader>tl", function()
        vim.cmd("OverseerRun")
      end, "Open Task List")
    end,
  },
}
