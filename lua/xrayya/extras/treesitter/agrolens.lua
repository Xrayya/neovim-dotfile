---@module "lazy"
---@type LazySpec
return {
  "desdic/agrolens.nvim",
  config = function(_, opts)
    local is_ok, telescope = pcall(require, "telescope")
    if is_ok then
      telescope.load_extension("agrolens")
    end

    telescope.extensions = {
      agrolens = opts,
    }
  end,
}
