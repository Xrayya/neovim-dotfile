---@type "lazy"
---@type LazySpec
return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-w><C-h>", "<CMD><C-u>TmuxNavigateLeft<CR>" },
      { "<C-w><C-j>", "<CMD><C-u>TmuxNavigateDown<CR>" },
      { "<C-w><C-k>", "<CMD><C-u>TmuxNavigateUp<CR>" },
      { "<C-w><C-l>", "<CMD><C-u>TmuxNavigateRight<CR>" },
    },
  },
}
