return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
			current_line_blame_opts = {
				delay = 10,
			}
		})

    -- Keymap to show full blame in a floating window
    vim.keymap.set('n', '<leader>Gl', function()
      gitsigns.toggle_current_line_blame()
    end, { desc = "Toggle inline gitblame" })

    -- Keymap to trigger Gitsigns blame command
    vim.keymap.set('n', '<leader>Gb', ':Gitsigns blame<CR>', { silent = true, desc = "Open Gitsigns gitblame" })
  end
}
