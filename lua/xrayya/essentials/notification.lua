---@module "lazy"
---@type LazySpec
return {
  "rcarriga/nvim-notify",
  ---@module "notify"
  ---@type notify.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    timeout = 1000,
    fps = 30,
  },
  config = function(_, opts)
    local notify = require("notify")

    vim.notify = notify

    if vim.g.has_no_bg_highlight then
      opts.background_colour = "#000000"
    end

    notify.setup(opts)
  end,
}
