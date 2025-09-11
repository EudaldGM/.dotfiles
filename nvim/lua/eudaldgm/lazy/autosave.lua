return{
	'Pocco81/auto-save.nvim',
	config = function()
		require('auto-save').setup({
			enabled = false,
			events = {'InsertLeave'},
		})
	end
}
