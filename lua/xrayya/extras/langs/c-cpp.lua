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
    ---@param opts Xray.lspconfigOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      ---@type vim.lsp.Config
      opts.servers["clangd"] = {
        cmd = cmd,
      }
    end,
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
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      opts.ensure_installed = require("xrayya.utils.lsp").check_ensure_installed({ "clangd" }, opts.ensure_installed)
    end,
  },
  { import = "xrayya.extras.debugger.codelldb" },
}
