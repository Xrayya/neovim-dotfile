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
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = { ensure_installed = { "tsgo" } },
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
