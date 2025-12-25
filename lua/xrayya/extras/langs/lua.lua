---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "nvim-treesitter"
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ensure_installed = { "lua", "luadoc" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls" }
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function (_, opts)
      opts.servers = opts.servers or {}
      opts.servers["lua_ls"] = {}
    end
  }
}
