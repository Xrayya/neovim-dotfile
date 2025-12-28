local M = {}

---@param table1 table
---@param table2 table
---@return table
M.merge_set = function(table1, table2)
  local set = {}
  local keys = vim.tbl_values(table1)
  for _, key in pairs(keys) do
    set[key] = true
  end

  keys = vim.tbl_values(table2)
  for _, key in pairs(keys) do
    set[key] = true
  end

  return vim.tbl_keys(set)
end

return M
