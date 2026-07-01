local kind_icons = require("xrayya.icons").kind

---@module "lazy"
---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config
  opts = {
    keymap = {
      builtin = {
        true,
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
      fzf = {
        true,
        ["tab"] = "down", -- NOTE: this is actually native fzf opts
        ["shift-tab"] = "up", -- NOTE: this is actually native fzf opts
        ["ctrl-n"] = "toggle+down", -- NOTE: this is actually native fzf opts
        ["ctrl-p"] = "toggle+up", -- NOTE: this is actually native fzf opts
        ["ctrl-space"] = "toggle", -- NOTE: this is actually native fzf opts
        ["ctrl-d"] = "preview-page-down",
        ["ctrl-u"] = "preview-page-up",
        ["ctrl-q"] = "select-all+accept",
      },
    },
    ---@type fzf-lua.config.Buffers
    ---@diagnostic disable-next-line: missing-fields
    buffers = {
      winopts = {
        preview = {
          vertical = "up:60%",
          layout = "vertical",
        },
      },
    },

    ---@type fzf-lua.config.Diagnostics
    ---@diagnostic disable-next-line: missing-fields
    diagnostics = {
      file_icons = true,
      winopts = {
        preview = {
          vertical = "up:60%",
          layout = "vertical",
        },
      },
    },

    ---@type fzf-lua.config.Lsp
    ---@diagnostic disable-next-line: missing-fields
    lsp = {
      jump1 = false,
      winopts = {
        preview = {
          vertical = "up:60%",
          layout = "vertical",
        },
      },
      ---@diagnostic disable-next-line: missing-fields
      symbols = {
        symbol_icons = kind_icons,
      },
      ---@diagnostic disable-next-line: missing-fields
      code_actions = {
        winopts = {
          preview = {
            vertical = "up:60%",
            layout = "vertical",
          },
        },
      },
    },
  },
  config = function(_, opts)
    local FzfLua = require("fzf-lua")

    FzfLua.setup(opts)

    FzfLua.register_ui_select()

    vim.lsp.buf.definition = FzfLua.lsp_definitions
    vim.lsp.buf.type_definition = FzfLua.lsp_typedefs
    vim.lsp.buf.references = FzfLua.lsp_references
    vim.lsp.buf.implementation = FzfLua.lsp_implementations
    vim.lsp.buf.document_symbol = FzfLua.lsp_document_symbols
    vim.lsp.buf.workspace_symbol = FzfLua.lsp_workspace_symbols

    ---@param lhs string
    ---@param rhs string|fun()
    ---@param desc string
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc })
    end

    map("grl", FzfLua.lsp_document_diagnostics, "Open diagnostic list")
    map("<Leader>b", FzfLua.buffers, "Buffer explorer")
    map("<leader>fc", FzfLua.commands, "Commands")
    map("<leader>fC", FzfLua.command_history, "Command history")
    map("<Leader>ff", FzfLua.files, "File")
    map("<Leader>fg", FzfLua.live_grep, "Grep")
    map("<Leader>fh", FzfLua.helptags, "Help")
    map("<leader>fk", FzfLua.keymaps, "Keymaps")
    map("<Leader>fq", FzfLua.quickfix, "Quickfix")
    map("<leader>fQ", FzfLua.quickfix_stack, "Quickfix history")
    map("<leader>fs", FzfLua.grep_curbuf, "Search in current buffer")

    local is_ok, whichkey = pcall(require, "which-key")
    if is_ok then
      whichkey.add({ "<Leader>f", group = "Find" })
    end
  end,
}
