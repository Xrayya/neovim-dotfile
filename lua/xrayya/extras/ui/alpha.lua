---@module "lazy"
---@type LazySpec
return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local ui = require("xrayya.icons").ui
    math.randomseed(os.time())

    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      [[                                                 ]],
      [[                                                 ]],
      [[                                                 ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", ui.FindFile .. "  Find file", "<cmd>FzfLua files<cr>"),
      dashboard.button("o", ui.RecentFile .. "  Recently used files", "<cmd>FzfLua oldfiles<cr>"),
      dashboard.button("l", ui.Clock2 .. "  Load last session", "<cmd>SessionManager load_current_dir_session<cr>"),
      dashboard.button("g", ui.GrepString .. "  Find text", "<cmd>FzfLua live_grep<cr>"),
      dashboard.button(
        "c",
        ui.Gear .. "  Browse nvim config file",
        "<cmd>FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<cr>"
      ),
      dashboard.button("M", ui.ToolBox .. "  Open Mason Home", "<cmd>Mason<cr>"),
      dashboard.button("P", ui.Socket .. "  Open Plugin Manager", "<cmd>Lazy<cr>"),
      dashboard.button("Q", ui.Out .. "  Quit Neovim", "<cmd>qa<cr>"),
    }

    dashboard.section.footer.val = ""

    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local is_ok, lazy = pcall(require, "lazy")
        if is_ok then
          local total_plugins = #vim.tbl_keys(lazy.plugins())
          local startuptime = lazy.stats().startuptime

          dashboard.section.footer.val =
            string.format("%s %d plugins %s %.2f ms", ui.Socket, total_plugins, ui.Dashboard, startuptime)

          ---@diagnostic disable-next-line: param-type-mismatch
          pcall(vim.cmd, "AlphaRedraw")
        end
      end,
    })
  end,
}
