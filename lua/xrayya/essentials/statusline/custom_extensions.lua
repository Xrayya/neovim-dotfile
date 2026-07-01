local icons = require("xrayya.icons")

local custom_extension = {
  telescope = {
    sections = {
      lualine_a = {
        {
          function()
            return icons.ui.Telescope .. " Telescope"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "TelescopePrompt" },
  },
  color_picker = {
    sections = {
      lualine_a = {
        {
          function()
            return icons.kind.Color .. " Color Picker"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "color-picker" },
  },
  lspinfo = {
    sections = {
      lualine_a = {
        {
          function()
            return icons.ui.LSP .. " LSP Info"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "lspinfo" },
  },
  null_ls_info = {
    sections = {
      lualine_a = {
        {
          function()
            return icons.ui.LSP .. " Null LS Info"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "null-ls-info" },
  },
  sagaoutline = {
    sections = {
      lualine_a = {
        {
          function()
            return icons.ui.LSP .. " LSP Saga Outline"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "sagaoutline" },
  },
  trouble = {
    sections = {
      lualine_a = {
        {
          function()
            return "Trouble"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "Trouble" },
  },
  lazy = {
    sections = {
      lualine_a = {
        {
          function()
            return icons.ui.Socket .. " Lazy"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "lazy" },
  },
  mason = {
    sections = {
      lualine_a = {
        {
          function()
            return icons.ui.ToolBox .. " Mason"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "mason" },
  },
  lazygit = {
    sections = {
      lualine_a = {
        {
          function()
            return " LazyGit"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "lazygit" },
  },
  fzf_lua = {
    sections = {
      lualine_a = {
        {
          function()
            return " Fzf"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "fzf" },
  },
  dap_view = {
    sections = {
      lualine_a = {
        {
          function()
            return " Dap View"
          end,
          color = { gui = "bold" },
        },
      },
    },
    filetypes = { "dap-view" },
  },
}

return custom_extension
