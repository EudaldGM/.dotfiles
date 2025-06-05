return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()

        require('mini.icons').setup()
	  	require('mini.comment').setup()
		require('mini.indentscope').setup()
		require('mini.pairs').setup()
		require('mini.statusline').setup()

		--miniSurround
		require('mini.surround').setup({
			mappings = {
				add = '<leader>sa',
				delete = '<leader>sd',
				replace = '<leader>sr',
				find = '<leader>sf',
				highlight = '<leader>sh',
			}
		})

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

		vim.ui.select = vim.schedule_wrap(MiniPick.ui_select)
		--miniTabline
		require('mini.tabline').setup({
     		show_numbers = true,
     	 	show_icons = true,
    	})

	end,
}
