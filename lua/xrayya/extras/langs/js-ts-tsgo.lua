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
    ---@module "xrayya.core.modules.lsp"
    ---@type Xray.lspconfigOpts
    opts = {
      enable_servers = {
        tsgo = {
          cmd = function(dispatchers, config)
            local cmd = "tsgo"
            if (config or {}).root_dir then
              local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
              if vim.fn.executable(local_cmd) == 1 then
                cmd = local_cmd
              end
            end
            return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
          end,
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
          root_dir = function(bufnr, on_dir)
            -- The project root is where the LSP can be started from
            -- As stated in the documentation above, this LSP supports monorepos and simple projects.
            -- We select then from the project root, which is identified by the presence of a package
            -- manager lock file.
            local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
            -- Give the root markers equal priority by wrapping them in a table
            root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
              or vim.list_extend(root_markers, { ".git" })

            local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
            local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
            local project_root = vim.fs.root(bufnr, root_markers)
            if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
              -- deno lock is closer than package manager lock, abort
              return
            end
            if deno_root and (not project_root or #deno_root >= #project_root) then
              -- deno config is closer than or equal to package manager lock, abort
              return
            end
            -- project is standard TS, not deno
            -- We fallback to the current working directory if no project root is found
            on_dir(project_root or vim.fn.getcwd())
          end,
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
        },
      },
    },
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
  {
    "folke/noice.nvim",
    ---@type NoiceConfig
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            find = 'Decoration provider %"win%" %(ns=nvim%.lsp%.inlayhint%):',
          },
          opts = { skip = true }, -- Drop the message completely
        },
        {
          filter = {
            event = "lsp",
            find = "Invalid 'col': out of range",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
