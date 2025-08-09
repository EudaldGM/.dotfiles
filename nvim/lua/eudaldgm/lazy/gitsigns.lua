return{
	"lewis6991/gitsigns.nvim",
	config = function()
		require('gitsigns').setup({
		})
	end,
	vim.keymap.set('n', '<leader>Gb', ':Gitsigns blame<CR>', {silent = true, desc = "Open gitsigns gitblame"}),

}
