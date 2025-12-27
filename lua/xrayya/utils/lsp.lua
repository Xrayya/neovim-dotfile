local M = {}

---@param servers table
---@param ensure_installed_var table
---@param custom_mappings? table
M.check_ensure_installed = function(servers, ensure_installed_var, custom_mappings)
  local mapping = require("mason-lspconfig").get_mappings().lspconfig_to_package
  for _, server in pairs(servers) do
    local server_mapping = mapping[server]

    if not server_mapping then
      local custom_server_mapping = (custom_mappings or {})[server]

      if not custom_server_mapping then
        vim.notify('No mapping found for "' .. server .. '"', vim.log.levels.ERROR, {
          title = "Xrayya LSPs Settings",
        })
        goto continue
      end

      if vim.fn.executable(custom_server_mapping) == 0 then
        vim.notify('"' .. custom_server_mapping .. '" is not installed and need manual install', vim.log.levels.ERROR, {
          title = "Xrayya LSPs Settings",
        })
      end
      goto continue
    end

    local server_package = require("mason-registry").get_package(server_mapping)
    if vim.fn.executable(vim.tbl_keys(server_package.spec.bin)[1]) == 0 then
      table.insert(ensure_installed_var, 1, server)
    end
    ::continue::
  end

  return ensure_installed_var
end

return M
