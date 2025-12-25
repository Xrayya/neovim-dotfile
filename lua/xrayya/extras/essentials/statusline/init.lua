---@module "lazy"
---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local components = require("xrayya.extras.essentials.statusline.components")
    local custom_extension = require("xrayya.extras.essentials.statusline.custom_extensions")

    require("lualine").setup({
      options = {
        disabled_filetypes = {
          "alpha",
        },
      },
      sections = {
        lualine_a = { components.mode },
        lualine_b = { components.filename },
        lualine_c = { components.branch, components.diff },
        lualine_x = { components.diagnostics, components.lsp },
        lualine_y = { components.encoding, components.fileformat, components.filetype },
        lualine_z = { components.location, components.progress },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "quickfix",
        "nvim-dap-ui",
        "nvim-tree",
        custom_extension.color_picker,
        custom_extension.lspinfo,
        custom_extension.null_ls_info,
        custom_extension.sagaoutline,
        custom_extension.lazy,
        custom_extension.mason,
        custom_extension.telescope,
        custom_extension.trouble,
        custom_extension.lazygit,
      },
    })
  end,
}
