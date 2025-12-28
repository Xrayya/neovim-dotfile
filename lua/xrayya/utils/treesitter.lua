local adt = require("xrayya.utils.adt")

local M = {}

---@module "xrayya.essentials.treesitter.treesitter"
---@param opts Xray.treesitterOpts
---@param addition_opts Xray.treesitterOpts
M.extend = function(opts, addition_opts)
  opts.ensure_installed = opts.ensure_installed or {}
  opts.ensure_highlight = opts.ensure_highlight or {}
  opts.ensure_indent = opts.ensure_indent or {}
  opts.ensure_fold = opts.ensure_fold or {}

  opts.ensure_installed = adt.merge_set(opts.ensure_installed or {}, addition_opts.ensure_installed or {})
  opts.ensure_highlight = adt.merge_set(opts.ensure_highlight or {}, addition_opts.ensure_highlight or {})
  opts.ensure_indent = adt.merge_set(opts.ensure_indent or {}, addition_opts.ensure_indent or {})
  opts.ensure_fold = adt.merge_set(opts.ensure_fold or {}, addition_opts.ensure_fold or {})

  return opts
end

return M
