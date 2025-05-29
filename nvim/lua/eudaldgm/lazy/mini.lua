return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()

        require('mini.icons').setup()
		require('mini.files').setup({
			options = {use_as_default_explorer = true,},
		})
	  	require('mini.comment').setup()
		require('mini.statusline').setup()
		require('mini.indentscope').setup()
		require('mini.pairs').setup()
		require('mini.pick').setup()
		require('mini.tabline').setup({
     		show_numbers = true,
     	 	show_icons = true,
     	 	set_vim_settings = true,
    	})

		vim.keymap.set('n', '<leader>o',function()
			require('mini.files').open()
		end)

		vim.keymap.set('n', '<space>f',function()
			require('mini.pick').pick()
		end)
		

		-- miniPickConfig	
	    vim.ui.select = vim.schedule_wrap(MiniPick.ui_select)
		
		vim.keymap.set('n', '<leader>ff', function()
	  		require('mini.pick').builtin.files()
		end, { desc = 'Find Files' })
	
		vim.keymap.set('n', '<leader>fg', function()
	 		require('mini.pick').builtin.grep()
		end, { desc = 'Grep Files' })
	
		vim.keymap.set('n', '<leader>fb', function()
	  		require('mini.pick').builtin.buffers()
		end, { desc = 'List Buffers' })

		--miniTabline
		vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
		vim.keymap.set('n', '<leader>te', ':tabedit ', {desc = 'Edit file in new tab'})
		vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { desc = 'Next tab' })
		vim.keymap.set('n', '<leader>th', ':tabprevious<CR>', { desc = 'Previous tab' })
		--file in new tab from minifiles

	end,
}
