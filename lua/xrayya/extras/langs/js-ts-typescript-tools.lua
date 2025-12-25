---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "nvim-treesitter"
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ensure_installed = { "javascript", "jsdoc", "typescript", "tsx", "comment" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed =
          require("xrayya.utils.lsp").check_ensure_installed({ "ts_ls" }, opts.ensure_installed)
    end,
  },
  {
    -- WARNING: if you are gonna use this config, do not enable normal `js-ts`
    -- WARNING: if you already activate `js-ts` lang setup, disable it, turn it off
    -- INFO: https://github.com/pmizio/typescript-tools.nvim

    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("typescript-tools").setup({
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "shortest",
          },
        },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          code_lens = "all",
          publish_diagnostic_on = "change",
          expose_as_code_action = "all",
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      })
    end,
  },
}
