---@module "lazy"
---@type LazySpec
return {
  "EthanJWright/vs-tasks.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function (_, opts)
    require("vstask").setup(opts)

    local is_ok, telescope = pcall(require, "telescope")
    if is_ok then
      telescope.load_extension("vstask")
    end
  end
}
