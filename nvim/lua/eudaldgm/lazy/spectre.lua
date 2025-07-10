return{
	"nvim-pack/nvim-spectre",
	config = function()
		require('spectre').setup({
			open_cmd = 'vertical botright new'
		})
	end
}
