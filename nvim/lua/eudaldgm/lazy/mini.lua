return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()

        require('mini.icons').setup()
	  	require('mini.comment').setup()
		require('mini.indentscope').setup()
		require('mini.pairs').setup()


		--miniSurround
		require('mini.surround').setup({
			mappings = {
				add = 'ssa',
				delete = 'ssd',
				replace = 'ssr',
				find = 'ssf',
				highlight = 'ssh',
			}
		})

		--miniFiles Config
		require('mini.files').setup({
			options = {use_as_default_explorer = true,},
		})

		vim.keymap.set('n', '<leader>o',function()
			require('mini.files').open()
		end)


		-- miniPickConfig	
   		require('mini.pick').setup()

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
		require('mini.tabline').setup({
     		show_numbers = true,
     	 	show_icons = true,
    	})

		vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
		vim.keymap.set('n', '<leader>te', ':tabedit ', {desc = 'Edit file in new tab'})
		vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { desc = 'Next tab' })
		vim.keymap.set('n', '<leader>th', ':tabprevious<CR>', { desc = 'Previous tab' })
	end,
}
