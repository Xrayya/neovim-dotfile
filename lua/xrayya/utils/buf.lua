local M = {}

---@param buffer integer
---@param opts? {max_size?: integer, max_line_count?: integer}
---@return boolean
function M.is_large_buf(buffer, opts)
  local max_size = opts and opts.max_size or (100 * 1024) -- 100 KB
  local max_line_count = opts and opts.max_line_count or 15000
  local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buffer))
  local line_count = vim.api.nvim_buf_line_count(buffer)
  return size >= max_size or line_count >= max_line_count
end

return M
