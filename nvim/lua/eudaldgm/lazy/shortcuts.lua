return {
	--travel between buffers
	vim.keymap.set('n', '<C-x>', ':bdelete!<CR>', {silent = true, desc = "Close Current Tab"}),
	vim.keymap.set('n', '<leader><tab>', ':bnext<CR>', {silent = true, desc = "Next Tab"}),
	vim.keymap.set('n', '<S-tab>', ':bprevious<CR>', {silent = true, desc = "Previous Tab"}),
	vim.keymap.set('n', '<tab>', ':bnext<CR>', {silent = true, desc = "Next Tab"}),
	--Terminal
	-- vim.api.nvim_set_keymap('n', '<leader>t', ':belowright 15split | terminal<CR> i', { noremap = true, silent = true }),
	-- vim.keymap.set('t', '<Esc>', '<C-\\><C-n>'),

	--miscSrtcts
	vim.keymap.set('n', '<leader>q', function() vim.fn.setreg( '+', vim.fn.expand('%:p')) end, {desc = "get path for current file"}),
	vim.keymap.set('n', '<leader>ww', '<cmd>set wrap!<CR>', {desc = "Toggle wrap", silent = true, noremap = true}),
	vim.keymap.set('i', 'pp', '<Esc>', {desc = "Escape insert mode", noremap = true}),
	vim.keymap.set('n', 'C-l', ':nohup<CR>', {silent = true}),

	vim.keymap.set('n', '<leader>fN', ':e %:p:h/')
}
