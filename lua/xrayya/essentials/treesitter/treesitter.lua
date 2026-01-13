---@class Xray.treesitterOpts
---@field ensure_installed? string[]
---@field ensure_highlight? string[]
---@field ensure_indent? string[]
---@field ensure_fold? string[]

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    ---@param opts Xray.treesitterOpts
    config = function(_, opts)
      ---@diagnostic disable-next-line: redundant-parameter
      require("nvim-treesitter").setup(opts)

      require("nvim-treesitter").install(opts.ensure_installed or {})

      local buf_utils = require("xrayya.utils.buf")

      if not vim.tbl_isempty(opts.ensure_highlight or {}) then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = opts.ensure_highlight,
          callback = function(args)
            if not buf_utils.is_large_buf(args.buf) then
              vim.treesitter.start()
            end
          end,
        })
      end

      if not vim.tbl_isempty(opts.ensure_fold or {}) then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = opts.ensure_fold,
          callback = function(args)
            if not buf_utils.is_large_buf(args.buf) then
              vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
              vim.wo[0][0].foldmethod = "expr"
            end
          end,
        })
      end

      if not vim.tbl_isempty(opts.ensure_indent or {}) then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = opts.ensure_indent,
          callback = function(args)
            if not buf_utils.is_large_buf(args.buf) then
              vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end,
        })
      end
    end,
  },
}
