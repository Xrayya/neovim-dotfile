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
    opts = function(_, opts)
      opts = require("xrayya.utils.treesitter").extend(opts, {
        ensure_installed = { "javascript", "jsx", "jsdoc", "typescript", "tsx", "comment" },
        ensure_highlight = { "javascript", "jsx", "jsdoc", "typescript", "tsx", "comment" },
        ensure_indent = { "javascript", "typescript", "tsx" },
        ensure_fold = { "javascript", "typescript", "tsx" },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed = require("xrayya.utils.lsp").check_ensure_installed({ "tsgo" }, opts.ensure_installed)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@param opts Xray.lspconfigOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      ---@type vim.lsp.Config
      opts.servers["tsgo"] = {
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "shortest",
          },
        },
        ---@module "lspconfig"
        ---@type lspconfig.settings.ts_ls
        settings = {
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = false,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
        on_attach = function(client, bufnr)
          -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
          -- `vim.lsp.buf.code_action()` if specified in `context.only`.
          vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
            local source_actions = vim.tbl_filter(function(action)
              return vim.startswith(action, "source.")
            end, client.server_capabilities.codeActionProvider.codeActionKinds)

            vim.lsp.buf.code_action({
              context = {
                only = source_actions,
                diagnostics = {},
              },
            })
          end, {})
        end,
      }
    end,
  },
  {
    {
      "ray-d-song/inlay-hint-trim.nvim",
      opts = {
        clients = {
          ["tsgo"] = true,
        },
      },
    },
  },
}
