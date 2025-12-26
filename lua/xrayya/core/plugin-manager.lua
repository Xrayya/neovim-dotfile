-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- bootstrap extra-config
local extra_config_path = vim.fn.stdpath("config") .. "/lua/extra-config"
if not vim.uv.fs_stat(extra_config_path) then
  local out = vim.system({ "mkdir", "-p", extra_config_path })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone create `extra-config` folder:\n", "ErrorMsg" },
      { out,                                               "WarningMsg" },
      {
        "You need to create `/lua/extra-config` folder manually",
        "InfoMsg",
      },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

if not vim.uv.fs_stat(extra_config_path .. "/init.lua") then
  local out = vim.system({ "touch", extra_config_path .. "/init.lua" })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone create `/lua/extra-config/init.lua`:\n", "ErrorMsg" },
      { out,                                                      "WarningMsg" },
      {
        "You need to create `/lua/extra-config/init.lua` file manually",
        "InfoMsg",
      },
      {
        "See `/lua/core/plugin-manager.lua` for the detail configuration",
        "InfoMsg",
      },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

  local content = string.format(
    "%s\n\n%s\n%s\n%s\n%s\n%s\n%s",
    "-- Other configuration that you need",
    '---@module "lazy"',
    "---@type LazySpec",
    "return {",
    '  -- { import = "xrayya.essentials" },',
    '  -- { import = "xrayya.essentials.treesitter" },',
    "}"
  )

  local file = assert(io.open(extra_config_path .. "/init.lua", "w"))
  file:write(content)
  file:close()
end

require("lazy").setup({
  spec = {
    "folke/lazy.nvim",
    { import = "xrayya.core.modules" },
    { import = "extra-config" },
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      ---@module "tokyonight"
      ---@type tokyonight.Config
      ---@diagnostic disable-next-line: missing-fields
      opts = {
        style = "night",
        light_style = "day",
        transparent = true,
        on_highlights = function(highlights, _)
          highlights.LineNr.fg = highlights.LspInlayHint.fg
          highlights.LineNrAbove.fg = highlights.LspInlayHint.fg
          highlights.LineNrBelow.fg = highlights.LspInlayHint.fg
        end,
      },
    },
  },
  install = {
    colorscheme = { "tokyonight" },
  },
})
