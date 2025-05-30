return {
  --errors shortcuts
  vim.keymap.set('n', '¡¡', function() vim.diagnostic.jump({ count = 1 }) end, {desc = "go to next error"}),
  vim.keymap.set('n', '¡l', function() vim.diagnostic.jump({ count = -1 }) end, {desc = "go to previous error"}),
  vim.keymap.set('n', '¡e', vim.diagnostic.open_float, { desc = 'Show line diagnostics' }),
  vim.keymap.set('n', '¡q', vim.diagnostic.setqflist, { desc = 'Open diagnostic quickfix list' }),

  --code shortcuts
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' }),
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' }),
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' }),
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' }),

  --travel between buffers
  vim.keymap.set('n', '<C-n>', ':bnext<CR>'),
  vim.keymap.set('n', '<C-p>', ':bprevious<CR>'),
  vim.keymap.set('n', '<C-w>', ':bdelete<CR>'),
}
