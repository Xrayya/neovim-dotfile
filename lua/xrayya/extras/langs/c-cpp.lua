local query_driver, resource_dir
if vim.fn.has("win32") > 0 then
  query_driver = os.getenv("CLANGD_QUERY_DRIVER_PATH") -- e.g "C:\\Users\\Hary\\scoop\\apps\\msys2\\current\\mingw64\\bin\\g++.exe"
  resource_dir = os.getenv("CLANGD_QUERY_RESOURCE_DIR_PATH") -- e.g "C:\\Users\\Hary\\scoop\\apps\\msys2\\current\\mingw64\\lib\\gcc\\x86_64-w64-mingw32\\12.2.0\\"
end

local cmd = {
  "clangd",
  "--background-index",
  "--pch-storage=memory",
  "--clang-tidy",
  "--completion-style=detailed"
}

if query_driver ~= nil then
  cmd[#cmd + 1] = "--query-driver=" .. query_driver
end

if resource_dir ~= nil then
  cmd[#cmd + 1] = "--resource-dir=" .. resource_dir
end

---@module "lazy"
---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          snippets = {
            opts = {
              extended_filetypes = {
                c = { "cdoc" },
                cpp = { "cppdoc" },
              },
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@module "xrayya.core.modules.lsp"
    ---@type Xray.lspconfigOpts
    opts = {
      enable_servers = {
        clangd = {
          cmd = cmd,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "xrayya.essentials.treesitter.treesitter"
    ---@type Xray.treesitterOpts
    opts = {
      ensure_install_parser = { "cpp", "c", "comment" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = { ensure_installed = { "clangd" } },
  },
  { import = "xrayya.extras.debugger.codelldb" },
}
