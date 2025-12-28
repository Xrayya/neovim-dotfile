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

      if not vim.tbl_isempty(opts.ensure_highlight or {}) then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = opts.ensure_highlight,
          callback = function(_)
            vim.treesitter.start()
          end,
        })
      end

      if not vim.tbl_isempty(opts.ensure_fold or {}) then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = opts.ensure_fold,
          callback = function(_)
            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldmethod = "expr"
          end,
        })
      end

      if not vim.tbl_isempty(opts.ensure_indent or {}) then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = opts.ensure_indent,
          callback = function(_)
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end,
        })
      end
    end,
  },
}
