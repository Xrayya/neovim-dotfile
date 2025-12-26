---@module "lazy"
---@type LazySpec
return {
  "mrjones2014/codesettings.nvim",
  opts = {},
  config = function(_, opts)
    require("codesettings").setup(opts)

    vim.lsp.config("*", {
      before_init = function(_, config)
        local codesettings = require("codesettings")
        codesettings.with_local_settings(config.name, config)
      end,
    })
  end,
  ft = { "json", "jsonc", "lua" },
}
