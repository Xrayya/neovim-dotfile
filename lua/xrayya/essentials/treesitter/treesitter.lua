return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.install").compilers = { "gcc", "clang" }

      require("nvim-treesitter.configs").setup(opts)

      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.o.foldlevelstart = 99
    end,
  },
}
