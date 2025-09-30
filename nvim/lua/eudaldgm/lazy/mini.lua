return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()

        require('mini.icons').setup()
	  	require('mini.comment').setup()
		require('mini.indentscope').setup()
		require('mini.tabline').setup() --change
		require('mini.pairs').setup()
		require('mini.statusline').setup() --change
		require("mini.align").setup()
		require('mini.surround').setup()
	end,
}
