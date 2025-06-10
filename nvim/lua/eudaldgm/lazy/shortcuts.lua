return {
	--errors shortcuts
	vim.keymap.set('n', '¡¡', function() vim.diagnostic.jump({ count = 1 }) end, {desc = "go to next error"}),
	vim.keymap.set('n', '¡l', function() vim.diagnostic.jump({ count = -1 }) end, {desc = "go to previous error"}),
	vim.keymap.set('n', '¡e', vim.diagnostic.open_float, { desc = 'Show line diagnostics' }),
	vim.keymap.set('n', '¡q', vim.diagnostic.setqflist, { desc = 'Open diagnostic quickfix list' }),

	--code shortcuts
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' }),
	vim.keymap.set('n', '<leader><C-g>', vim.lsp.buf.definition, { desc = 'Go to Definition' }),
	---vim.keymap.set('n', '<leader><C-b>', vim.lsp.buf.declaration, { desc = 'Go to Declaration' }),
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' }),

	--travel between buffers
	vim.keymap.set('n', '<leader><C-n>', ':bnext<CR>'),
	vim.keymap.set('n', '<leader><C-p>', ':bprevious<CR>'),
	vim.keymap.set('n', '<leader><C-w>', ':bdelete<CR>'),

	--miniPick shortcuts
	vim.keymap.set('n', '<leader>ff', function() require('mini.pick').builtin.files() end, { desc = 'Find Files' }),
	vim.keymap.set('n', '<leader>fg', function() require('mini.pick').builtin.grep() end, { desc = 'Grep Files' }),
	vim.keymap.set('n', '<leader>fb', function() require('mini.pick').builtin.buffers() end, { desc = 'List Buffers' }),

	--miniTabline
	-- vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' }),
	-- vim.keymap.set('n', '<leader>te', ':tabedit ', {desc = 'Edit file in new tab'}),
	-- vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { desc = 'Next tab' }),
	-- vim.keymap.set('n', '<leader>th', ':tabprevious<CR>', { desc = 'Previous tab' }),

	--Terminal
	vim.api.nvim_set_keymap('n', '<leader>t', ':below 15split | terminal<CR>', { noremap = true, silent = true }),
	vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

}
