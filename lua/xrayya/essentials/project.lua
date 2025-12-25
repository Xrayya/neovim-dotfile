---@module "lazy"
---@type LazySpec
return {
  "ahmedkhalf/project.nvim",
  opts = {
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    show_hidden = true,
  },
  config = function()
    local is_ok, telescope = pcall(require, "telescope")
    if is_ok then
      telescope.load_extension("projects")
    end
  end,
}
