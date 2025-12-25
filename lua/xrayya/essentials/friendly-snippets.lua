---@module "lazy"
---@type LazySpec
return {
  "rafamadriz/friendly-snippets",
  config = function()
    local is_ok, luasnip_vscode_loader = pcall(require, "luasnip.loaders.from_vscode")
    if is_ok then
      luasnip_vscode_loader.lazy_load()
    end
  end,
}
