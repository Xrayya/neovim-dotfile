local set = vim.opt

vim.g.wraptext = false

set.hidden = true
set.whichwrap:append("<,>,[,],h,l")
set.wrap = vim.g.wraptext
set.wrapscan = false
set.linebreak = true
set.encoding = "utf-8"
set.fileencoding = "utf-8"
set.pumheight = 10
set.ruler = true
set.cmdheight = 1
set.shell = vim.fn.has("win32") == 1 and "pwsh"
  or vim.fn.has("unix") and (vim.fn.executable("nu") == 1 and "nu" or vim.fn.executable("fish") == 1 and "fish")
  or "bash"
set.iskeyword:append("-")
set.mouse = "a"
set.splitbelow = true
set.splitright = true
set.conceallevel = 3
set.signcolumn = "yes:2"
set.foldcolumn = "0"
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.smarttab = true
set.expandtab = true
set.smartindent = true
set.autoindent = true
set.number = true
set.relativenumber = true
set.cursorline = true
set.scrolloff = 9
set.sidescrolloff = 20
set.showtabline = 1
set.laststatus = 3
set.showmode = false
set.backup = false
set.smartcase = true
set.writebackup = false
set.updatetime = 300
set.timeoutlen = 300
set.clipboard:append({ "unnamedplus" })
set.shortmess:append("c")
set.termguicolors = true
set.foldlevel = 99
set.foldlevelstart = 99

local statuscol_cache = {}

-- Clear the cache when text changes or when switching buffers
vim.api.nvim_create_autocmd({
  "DiagnosticChanged", -- Wipes cache instantly when LSP diagnostics update
  "User",
  "TextChanged",
  "TextChangedI",
  "BufEnter",
}, {
  group = vim.api.nvim_create_augroup("StatusColCacheClear", { clear = true }),
  callback = function()
    statuscol_cache = {}
  end,
})

_G.my_statuscolumn = function()
  if vim.v.virtnum ~= 0 then
    return "%=" -- Prevent duplicate signs on wrapped line screens
  end

  local lnum = vim.v.lnum
  local bufnr = vim.api.nvim_get_current_buf()

  local cache_key = string.format("%d_%d", bufnr, lnum)
  if statuscol_cache[cache_key] then
    return statuscol_cache[cache_key]
  end

  local left_sign = ""
  local lsp_sign = ""
  local git_sign = ""

  local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, -1, { lnum - 1, 0 }, { lnum - 1, -1 }, { details = true })

  for _, extmark in ipairs(extmarks) do
    local details = extmark[4]

    if details and details.sign_text then
      local ns_id = extmark[2]
      local ns_name = vim.api.nvim_get_namespaces()[ns_id] or ""
      local hl_group = details.sign_hl_group or "Normal"

      -- Format the character safely with its intended color highlight group
      local formatted_sign = string.format("%%#%s#%s%%*", hl_group, details.sign_text)

      if ns_name:find("gitsigns") or hl_group:find("GitSigns") then
        git_sign = formatted_sign
      elseif ns_name:find("diagnostic") or hl_group:find("Diagnostic") then
        lsp_sign = formatted_sign
      else
        left_sign = formatted_sign
      end
    end
  end

  local left_pad = (left_sign ~= "") and left_sign or "  "
  local lsp_pad = (lsp_sign ~= "") and lsp_sign or "  "
  local git_pad = (git_sign ~= "") and git_sign or " "

  local result = string.format("%s %%l %s%%=%s", left_pad, lsp_pad, git_pad)

  statuscol_cache[cache_key] = result
  return result
end

vim.opt.signcolumn = "no"
vim.opt.statuscolumn = "%!v:lua.my_statuscolumn()"

vim.opt.fillchars:append({
  fold = "·",
  foldopen = "",
  foldclose = "",
  foldsep = "│",
  foldinner = "│",
})

vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.filetype.add({
  pattern = {
    [".*/%.vscode/tasks%.json"] = "jsonc",
    [".*/%.vscode/launch%.json"] = "jsonc",
  },
})
