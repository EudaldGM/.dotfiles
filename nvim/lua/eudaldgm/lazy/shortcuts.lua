return {
	--errors shortcuts
	vim.keymap.set('n', '¡¡', function() vim.diagnostic.jump({ count = 1 }) vim.schedule(function() vim.diagnostic.open_float() end) end, {desc = "go to next error"}),
	vim.keymap.set('n', '¿¿', function() vim.diagnostic.jump({ count = -1 }) vim.schedule(function() vim.diagnostic.open_float() end) end, {desc = "go to previous error"}),
	vim.keymap.set('n', '¡e', vim.diagnostic.open_float, { desc = 'Show line diagnostics' }),
	vim.keymap.set('n', '¡q', vim.diagnostic.setqflist, { desc = 'Open diagnostic quickfix list' }),

	--code shortcuts
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' }),
	vim.keymap.set('n', '<leader><C-g>', vim.lsp.buf.definition, { desc = 'Go to Definition' }),

	---vim.keymap.set('n', '<leader><C-b>', vim.lsp.buf.declaration, { desc = 'Go to Declaration' }),
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' }),

	--travel between buffers
	vim.keymap.set('n', '<leader><C-w>', ':bdelete!<CR>', {silent = true, desc = "Close Current Tab"}),
	vim.keymap.set('n', '<leader><tab>', ':bnext<CR>', {silent = true, desc = "Next Tab"}),
	vim.keymap.set('n', '<S-tab>', ':bprevious<CR>', {silent = true, desc = "Previous Tab"}),

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
	vim.api.nvim_set_keymap('n', '<leader>t', ':lcd %:p:h | belowright 15split | terminal<CR> i', { noremap = true, silent = true }),
	vim.keymap.set('t', '<Esc>', '<C-\\><C-n>'),

	--miscSrtcts
	vim.keymap.set('n', '<leader>q', function() vim.fn.setreg( '+', vim.fn.expand('%:p')) end, {desc = "get path for current file"}),
	vim.keymap.set('n', '<leader>Q', function()
		local MiniFiles = require('mini.files')
		local fs_entry = MiniFiles.get_fs_entry()
  		if fs_entry then
    		vim.fn.setreg('+', fs_entry.path)
    		print('Copied: ' .. fs_entry.path)
  		else
    		print('Not in mini.files or no entry selected')
  		end
	end, {desc = "copy selected file path in mini.files"}),

	--Spectre shortcuts
	vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {desc = "Toggle Spectre"}),
	vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {desc = "Search current word"}),
	vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {desc = "Search on current file"}),
	vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {desc = "Search current word"}),

	--Gitsigns shortcuts
	vim.keymap.set('n', '<leader>Gb', ':Gitsigns blame<CR>', {silent = true, desc = "Open gitsigns gitblame"}),

	--DAP (debug)
    vim.keymap.set('n', '<F5>', function() require('dap').continue() end),
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end),
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end),
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end),
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end),
    vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end),
}
