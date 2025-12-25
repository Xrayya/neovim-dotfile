---@module "lazy"
---@type LazySpec
return {
  {
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
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    opts = {
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    -- enabled = false,
    opts = {
      chunk = {
        enable = true,
      },
      indent = {
        enable = true,
        use_treesitter = true,
        chars = { "▏" },
      },
      line_num = {
        enable = true,
        use_treesitter = true,
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },
  {
    "b0o/incline.nvim",
    opts = {
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      hide = {
        cursorline = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        if modified then
          filename = filename .. " ●"
        end
        return {
          ft_icon
          and { " ", ft_icon, " ", guibg = ft_color, guifg = require("incline.helpers").contrast_color(ft_color) }
          or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
          guibg = "#44406e",
        }
      end,
    },
  },
}
