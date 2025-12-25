---@param mode string | string[]
---@param lhs string
---@param rhs string | function
---@param desc? string
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map("", "<Space>", "<NOP>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- It's in my habit and faster
map("n", "<Leader>w", "<cmd>write<cr>")

-- Use alt + hjkl to resize windows
map("n", "<M-Down>", "<cmd>resize -1<cr>")
map("n", "<M-Up>", "<cmd>resize +1<cr>")
map("n", "<M-Right>", "<cmd>vertical resize +1<cr>")
map("n", "<M-Left>", "<cmd>vertical resize -1<cr>")

-- Set command to enter visual block mode (since <C-v> always do paste)
vim.cmd("command! Vb normal! <C-v>")

-- Escape from terminal mode
map("t", "<esc><esc>", "<C-\\><c-n>")

-- -- Useful for switching between floating windows
map("n", "<M-]>", "<cmd>cnext<CR>")
map("n", "<M-[>", "<cmd>cprevious<CR>")

-- <TAB> Completion
map("i", "<expr> <TAB>", 'pumvisible() ? "\\<C-n>" : "\\<TAB>"')
map("i", "<expr> <S-TAB>", 'pumvisible() ? "\\<C-p>" : "\\<TAB>"')

-- Keep it centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Keep the last thing yanked on the register
map("v", "p", '"_dP')

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move selecter line /block of text in visual mode
map("x", "<M-j>", "<cmd>move '>+1<CR>gv-gv")
map("x", "<M-k>", "<cmd>move '<-2<CR>gv-gv")
map("i", "<C-j>", "<esc><cmd>move .+1<CR>==i")
map("i", "<C-k>", "<esc><cmd>move .-2<CR>==i")
map("n", "<M-j>", "<cmd>move .+1<CR>==")
map("n", "<M-k>", "<cmd>move .-2<CR>==")

-- Undo break point
map("i", ".", ".<C-g>u")
map("i", ",", ",<C-g>u")
map("i", "=", "=<C-g>u")
map("i", "+", "+<C-g>u")
map("i", "-", "-<C-g>u")
map("i", "*", "*<C-g>u")
map("i", "%", "%<C-g>u")
map("i", "<", "<<C-g>u")
map("i", ">", "><C-g>u")
map("i", "(", "(<C-g>u")
map("i", "{", "{<C-g>u")
map("i", "[", "[<C-g>u")
map("i", '"', '"<C-g>u')
map("i", "'", "'<C-g>u")
map("i", "`", "`<C-g>u")
map("i", "/", "/<C-g>u")
map("i", "|", "|<C-g>u")
map("i", "?", "?<C-g>u")
map("i", "!", "!<C-g>u")
map("i", ";", ";<C-g>u")
map("i", ":", ":<C-g>u")
map("i", " ", " <C-g>u")

map("n", "<leader>h", "<CMD>set hlsearch!<CR>", "Hightlight text toggle")

-- bare minimum essentials for navigation
vim.keymap.set(
  "n",
  "<Leader>=",
  "<cmd>setlocal relativenumber number signcolumn=yes<cr>",
  { noremap = true, silent = true, desc = "Set essential options for current buffer" }
)

-- LSP Stuff
map("n", "grd", function()
  vim.lsp.buf.definition()
end, "Go to definition(s)")
map("n", "grf", function()
  vim.lsp.buf.format()
end, "Format the current buffer")
map("n", "grI", "<CMD>LspInlayHintsToggle<CR>", "Toggle LSP inlay hints")
map("n", "grl", function()
  require("telescope.builtin").diagnostics()
end, "Open diagnostic list")
map("n", "grL", "<cmd>DiagnosticVirtualLineToggle<cr>", "Toggle Diagnostic Virtual Line")
map("n", "grT", "<cmd>DiagnosticVirtualTextToggle<cr>", "Toggle Diagnostic Virtual Text")
