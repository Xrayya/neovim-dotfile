---@module "lazy"
---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback_to_mappings" },
        ["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },
        ["<M-l>"] = { "snippet_forward", "fallback" },
        ["<M-h>"] = { "snippet_backward", "fallback" },
        ["<C-b>"] = {
          function(cmp)
            cmp.scroll_documentation_up(1)
          end,
        },
        ["<C-f>"] = {
          function(cmp)
            cmp.scroll_documentation_down(1)
          end,
        },
      },
      completion = {
        trigger = {
          show_on_insert = true,
          show_on_backspace_in_keyword = true,
        },
        menu = {
          border = "rounded",
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 }, { "source_symbol" }, { "label_description" } },
            components = {
              source_symbol = {
                width = { max = 30 },
                text = function(ctx)
                  local icons = require("xrayya.icons")
                  local mapping = {
                    buffer = icons.ui.Buffer,
                    path = icons.ui.Path,
                    lsp = icons.ui.LSP,
                    cmdline = icons.ui.Terminal,
                    snippets = icons.ui.Scissor,
                    lazydev = icons.misc.LazyDev,
                  }

                  local symbol = string.format("%s ", mapping[ctx.source_id] or ctx.source_id)

                  if ctx.source_id == "lsp" and ctx.item.client_name then
                    symbol = string.format("%s [%s]", symbol, ctx.item.client_name)
                  end

                  return symbol
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          window = { border = "rounded" },
        },
      },
      signature = { window = { border = "rounded" } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          lua = {
            inherit_defaults = true,
            "lazydev",
          },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          lsp = {
            fallbacks = {},
          },
        },
      },
      fuzzy = {
        sorts = {
          "exact",
          "score",
          "sort_text",
        },
      },
      appearance = {
        kind_icons = require("xrayya.icons").kind,
      },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      require("blink-cmp").setup(opts)

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("*", { capabilities = capabilities })
    end,
  },
}
