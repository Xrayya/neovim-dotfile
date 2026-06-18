---@module "lazy"
---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          snippets = {
            opts = {
              extended_filetypes = {
                javascriptreact = { "html", "jsdoc" },
                typescriptreact = { "html", "tsdoc" },
                javascript = { "jsdoc" },
                typescript = { "tsdoc" },
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "xrayya.essentials.treesitter.treesitter"
    ---@type Xray.treesitterOpts
    opts = {
      ensure_install_parser = { "javascript", "jsx", "jsdoc", "typescript", "tsx", "comment" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed = require("xrayya.utils.lsp").check_ensure_installed({ "ts_ls" }, opts.ensure_installed)
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
        config = {
          init_options = {
            preferences = {
              importModuleSpecifierPreference = "shortest",
            },
          },
        },
        settings = {
          code_lens = "all",
          tsserver_max_memory = 3072,
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
