vim.api.nvim_create_user_command("CppCompile", function()
  local input_file = vim.fn.expand("%:p")
  local output_file = vim.fn.expand("%:p:r")

  if vim.fn.has("win32") > 0 then
    output_file = output_file .. ".exe"
  else
    output_file = output_file .. ".out"
  end

  ---@diagnostic disable-next-line: missing-fields
  vim.uv.spawn("g++", {
    args = { "-fdiagnostics-color=always", "-Wall", "-g", input_file, "-o", output_file },
  }, function(code, _)
    if code == 0 then
      vim.notify("Compiling done", vim.log.levels.INFO, {
        title = "C++ Compilation",
      })
    else
      vim.notify("Compiling failed", vim.log.levels.ERROR, {
        title = "C++ Compilation",
      })
    end
  end)
end, {})

local query_driver, resource_dir
if vim.fn.has("win32") > 0 then
  query_driver = os.getenv("CLANGD_QUERY_DRIVER_PATH")      -- e.g "C:\\Users\\Hary\\scoop\\apps\\msys2\\current\\mingw64\\bin\\g++.exe"
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
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers["clangd"] = {
        cmd = cmd,
      }
    end,
  },
}
