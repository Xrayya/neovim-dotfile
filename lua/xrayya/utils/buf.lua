local M = {}

---@param buffer integer
---@return boolean
function M.is_large_buf(buffer)
  local max_size = 100 * 1024 -- 100 KB
  local max_line_count = 15000
  local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buffer))
  local line_count = vim.api.nvim_buf_line_count(buffer)
  return size >= max_size or line_count >= max_line_count
end

return M
