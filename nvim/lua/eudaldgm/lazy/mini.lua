return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()

        require('mini.icons').setup()
		require("mini.ai").setup()
	  	require('mini.comment').setup()
		require('mini.indentscope').setup()
		require('mini.pairs').setup()
		require('mini.statusline').setup()
		require("mini.git").setup()
		require("mini.align").setup()
		require("mini.ai").setup()
		require('mini.surround').setup()
		require("mini.snippets").setup()
		require("mini.extra").setup()
		--miniFiles Config
		require('mini.files').setup({
			options = {use_as_default_explorer = true,},
		})

		vim.keymap.set('n', '<leader>o',function()
			require('mini.files').open()
			end,
			{desc = 'Open miniFiles'})


		-- miniPickConfig	
   		require('mini.pick').setup()

		--vim.ui.select = vim.schedule_wrap(MiniPick.ui_select)
		--miniTabline
		require('mini.tabline').setup({
     		show_numbers = true,
     	 	show_icons = true,
    	})

	end,
}
