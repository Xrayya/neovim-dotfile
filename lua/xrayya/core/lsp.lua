local diagnostic_signs = require("xrayya.icons").diagnostics

vim.g.diag_virtual_text_enabled = true
vim.g.diag_virtual_line_enabled = true

vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.outlined.Error,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.outlined.Warning,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.outlined.Hint,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.outlined.Information,
    },
  },
  float = {
    border = "rounded",
    source = true,
  },
  virtual_text = vim.g.diag_virtual_text_enabled,
  virtual_lines = {
    current_line = vim.g.diag_virtual_line_enabled,
  },
})

vim.api.nvim_create_user_command("DiagnosticVirtualTextToggle", function(_)
  if vim.g.diag_virtual_text_enabled then
    vim.diagnostic.config({ virtual_text = false })
    vim.g.diag_virtual_text_enabled = false
  else
    vim.diagnostic.config({ virtual_text = true })
    vim.g.diag_virtual_text_enabled = true
  end
end, {})

vim.api.nvim_create_user_command("DiagnosticVirtualLineToggle", function(_)
  if vim.g.diag_virtual_line_enabled then
    vim.diagnostic.config({ virtual_lines = false })
    vim.g.diag_virtual_line_enabled = false
  else
    vim.diagnostic.config({ virtual_lines = { current_line = true } })
    vim.g.diag_virtual_line_enabled = true
  end
end, {})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({
  border = "rounded",
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({
  border = "rounded",
})

vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_user_command("LspInlayHintsToggle", function(_)
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end, {})
