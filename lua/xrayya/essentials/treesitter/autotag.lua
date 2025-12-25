---@module "lazy"
---@type LazySpec
return {
  "windwp/nvim-ts-autotag",
  ---@module "nvim-ts-autotag"
  ---@type nvim-ts-autotag.PluginSetup
  opts = {
    opts = {
      enable_close = true,
      enable_close_on_slash = false,
      enable_rename = false,
    }
  }
}
