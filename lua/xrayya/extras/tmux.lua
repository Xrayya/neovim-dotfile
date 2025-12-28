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
      { "<C-h>", "<CMD><C-u>TmuxNavigateLeft<CR>" },
      { "<C-j>", "<CMD><C-u>TmuxNavigateDown<CR>" },
      { "<C-k>", "<CMD><C-u>TmuxNavigateUp<CR>" },
      { "<C-l>", "<CMD><C-u>TmuxNavigateRight<CR>" },
    },
  },
}
