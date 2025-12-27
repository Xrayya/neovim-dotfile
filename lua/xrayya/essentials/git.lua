---@module "lazy"
---@type LazySpec
return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local config_opts = {
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        attach_to_untracked = true,
        current_line_blame = true,
        preview_config = {
          border = "rounded",
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          ---@param mode string | string[]
          ---@param l string
          ---@param r string | function
          ---@param mOpts? vim.keymap.set.Opts
          local function map(mode, l, r, mOpts)
            mOpts = mOpts or {}
            mOpts.buffer = bufnr
            vim.keymap.set(mode, l, r, mOpts)
          end

          map("n", "<Leader>gb", function()
            gitsigns.blame_line({ full = true })
          end, { desc = "Blame line" })

          map("n", "<Leader>gB", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })

          map("n", "<Leader>gd", gitsigns.diffthis, { desc = "Diff to index" })
          map("n", "<Leader>gD", function()
            ---@diagnostic disable-next-line: param-type-mismatch
            gitsigns.diffthis("~")
          end, { desc = "Diff to last commit" })

          map("n", "<Leader>gi", gitsigns.preview_hunk_inline, { desc = "Preview inline hunk" })

          map("n", "<Leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })

          map("n", "<Leader>gQ", function()
            ---@diagnostic disable-next-line: param-type-mismatch
            gitsigns.setqflist("all")
          end, { desc = "Open all file hunks in qflist" })
          map("n", "<Leader>gq", gitsigns.setqflist, { desc = "Open all buffers hunks in qflist" })

          map("n", "<Leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
          map("v", "<Leader>gr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset hunk" })
          map("n", "<Leader>gR", gitsigns.reset_buffer, { desc = "Reset current buffer" })

          map("n", "<Leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
          map("v", "<Leader>gs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage hunk" })
          map("n", "<Leader>gS", gitsigns.stage_buffer, { desc = "Stage current buffer" })

          map("n", "<Leader>gw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              ---@diagnostic disable-next-line: param-type-mismatch
              gitsigns.nav_hunk("next", { preview = true, target = "all" })
            end
          end, { desc = "Move to next hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              ---@diagnostic disable-next-line: param-type-mismatch
              gitsigns.nav_hunk("	rev", { preview = true, target = "all" })
            end
          end, { desc = "Move to previous hunk" })

          map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" })
        end,
      }

      opts = vim.tbl_deep_extend("force", config_opts, opts)

      return opts
    end,
  },
}
