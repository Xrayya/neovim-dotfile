---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "lua", "luadoc", "comment" },
        ensure_highlight = { "lua", "luadoc", "comment" },
        ensure_indent = { "lua" },
        ensure_fold = { "lua" },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed = require("xrayya.utils.lsp").check_ensure_installed({ "lua_ls" }, opts.ensure_installed)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@param opts Xray.lspconfigOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers["lua_ls"] = {}
    end,
  },
}
