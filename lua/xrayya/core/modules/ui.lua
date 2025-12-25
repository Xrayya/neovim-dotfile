---@module "lazy"
---@type LazySpec
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  ---@type NoiceConfig
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      lsp_doc_border = true,
    },
    hover = {
      silent = true,
    },
    routes = {
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
    },
  },
  keys = {
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(1) then
          return "<c-f>"
        end
      end,
      mode = { "n", "i", "s" },
    },
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-1) then
          return "<c-b>"
        end
      end,
      mode = { "n", "i", "s" },
    },
  },
}
