---@module "lazy"
---@type LazySpec
return {
  { "nvim-lua/plenary.nvim",       lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = {},
    config = function(_, opts)
      local icons = require("xrayya.icons")

      local themes = require("telescope.themes")
      local actions = require("telescope.actions")

      local telescope = require("telescope")
      local telescope_builtin = require("telescope.builtin")

      local telescope_config = {
        pickers = {
          find_files = {
            hidden = true,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            mappings = {
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          diagnostics = {
            layout_strategy = "vertical",
          },
          help_tags = {
            layout_config = {
              preview_width = 0.6,
            },
          },
          lsp_document_symbols = {
            theme = "ivy",
            layout_config = {
              height = 0.4,
            },
          },
          lsp_workspace_symbols = {
            theme = "ivy",
            layout_config = {
              height = 0.4,
            },
          },
          lsp_definitions = {
            layout_strategy = "vertical",
            hidden = true,
            no_ignore = true,
            jump_type = "never",
          },
          lsp_type_definitions = {
            layout_strategy = "vertical",
            hidden = true,
            no_ignore = true,
            jump_type = "never",
          },
          lsp_references = {
            layout_strategy = "vertical",
            hidden = true,
            no_ignore = true,
            jump_type = "never",
          },
          lsp_implementations = {
            layout_strategy = "vertical",
            hidden = true,
            no_ignore = true,
            jump_type = "never",
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        defaults = {
          prompt_prefix = icons.ui.Telescope .. "  ",
          selection_caret = icons.ui.GoTo .. " ",
          path_display = { "smart" },
          file_ignore_patterns = { ".git/" },
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<Tab>"] = actions.move_selection_next,
              ["<S-Tab>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
            },
            n = {
              ["<Tab>"] = actions.move_selection_next,
              ["<S-Tab>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            themes.get_dropdown(),
          },
        },
      }

      telescope_config = vim.tbl_deep_extend("force", telescope_config, opts)

      telescope.setup(telescope_config)

      vim.lsp.buf.definition = telescope_builtin.lsp_definitions
      vim.lsp.buf.type_definition = telescope_builtin.lsp_type_definitions
      vim.lsp.buf.references = telescope_builtin.lsp_references
      vim.lsp.buf.implementation = telescope_builtin.lsp_implementations
      vim.lsp.buf.workspace_symbol = telescope_builtin.lsp_workspace_symbols
      vim.lsp.buf.document_symbol = telescope_builtin.lsp_document_symbols

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
    cmd = {
      "Telescope",
    },
    keys = {
      {
        "<Leader>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffer explorer",
      },
      {
        "<leader>fc",
        function()
          require("telescope.builtin").commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>fH",
        function()
          require("telescope.builtin").command_history()
        end,
        desc = "Command history",
      },
      {
        "<Leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "File",
      },
      {
        "<Leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep",
      },
      {
        "<Leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help",
      },
      {
        "<leader>fk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "Keymapts",
      },
      {
        "<Leader>fq",
        function()
          require("telescope.builtin").quickfix()
        end,
        desc = "Quickfix",
      },
      {
        "<leader>fQ",
        function()
          require("telescope.builtin").quickfixhistory()
        end,
        desc = "Quickfix history",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_ivy())
        end,
        desc = "Search in current buffer",
      },
    },
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
    },
    opts = {},
  },
}
