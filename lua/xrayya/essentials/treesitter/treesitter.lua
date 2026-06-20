---@class Xray.treesitterOpts
---@field ensure_install_parser? string[]
---@field exclude_highlight_ft? string[]
---@field exclude_indent_ft? string[]
---@field exclude_fold_ft? string[]

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts_extend = { "ensure_install_parser", "exclude_highlight_ft", "exclude_indent_ft", "exclude_fold_ft" },
    ---@param opts Xray.treesitterOpts
    config = function(_, opts)
      ---@diagnostic disable-next-line: redundant-parameter
      require("nvim-treesitter").setup(opts)

      local ensure_installed = opts.ensure_install_parser or {}
      local exclude_highlight_ft = opts.exclude_highlight_ft or {}
      local exclude_indent_ft = opts.exclude_indent_ft or {}
      local exclude_fold_ft = opts.exclude_fold_ft or {}

      require("nvim-treesitter").install(ensure_installed)

      local registered_filetype = {}
      for _, parser in ipairs(ensure_installed) do
        local filetypes = vim.treesitter.language.get_filetypes(parser)
        vim.list_extend(registered_filetype, filetypes)
      end

      vim.list.unique(registered_filetype)

      local buf_utils = require("xrayya.utils.buf")

      local ensure_highlight_fts = vim
        .iter(registered_filetype)
        :filter(function(parser)
          return not vim.tbl_contains(exclude_highlight_ft, parser)
        end)
        :totable()

      if not vim.tbl_isempty(ensure_highlight_fts) then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = ensure_highlight_fts,
          group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
          callback = function(args)
            if not buf_utils.is_large_buf(args.buf) then
              vim.treesitter.start(args.buf)
            end
          end,
        })
      end

      local ensure_fold_fts = vim
        .iter(registered_filetype)
        :filter(function(parser)
          return not vim.tbl_contains(exclude_fold_ft, parser)
        end)
        :totable()

      if not vim.tbl_isempty(ensure_fold_fts) then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = ensure_fold_fts,
          group = vim.api.nvim_create_augroup("TreesitterIndent", { clear = true }),
          callback = function(args)
            if not buf_utils.is_large_buf(args.buf) then
              vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
              vim.wo[0][0].foldmethod = "expr"
            end
          end,
        })
      end

      local ensure_indent_fts = vim
        .iter(registered_filetype)
        :filter(function(parser)
          return not vim.tbl_contains(exclude_indent_ft, parser)
        end)
        :totable()

      if not vim.tbl_isempty(ensure_indent_fts) then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = ensure_indent_fts,
          group = vim.api.nvim_create_augroup("TreesitterFold", { clear = true }),
          callback = function(args)
            if not buf_utils.is_large_buf(args.buf) then
              vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end,
        })
      end
    end,
  },
}
