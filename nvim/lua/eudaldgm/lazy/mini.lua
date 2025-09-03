return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()

        require('mini.icons').setup()
		require("mini.ai").setup({})
		require("mini.jump").setup()
		require("mini.jump2d").setup({
			allowed_lines = {
				blank = false,

			},
		})
	  	require('mini.comment').setup()
		require('mini.indentscope').setup()
		require('mini.tabline').setup()
		require('mini.pairs').setup()
		require('mini.statusline').setup()
		require("mini.git").setup()
		require("mini.align").setup()
		require('mini.surround').setup()
		require("mini.operators").setup()
		require("mini.extra").setup()
		--miniFiles Config

	end,
}
