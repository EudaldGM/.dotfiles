return {
  {
    "github/copilot.vim",
    config = function()
      -- Disable default tab mapping if you want to use your own
      vim.g.copilot_no_tab_map = true

      -- Custom keymaps
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion"
      })

      vim.keymap.set("i", "<C-K>", "<Plug>(copilot-dismiss)", {
        desc = "Dismiss Copilot suggestion"
      })

      vim.keymap.set("i", "<C-N>", "<Plug>(copilot-next)", {
        desc = "Next Copilot suggestion"
      })

      vim.keymap.set("i", "<C-P>", "<Plug>(copilot-previous)", {
        desc = "Previous Copilot suggestion"
      })
	  vim.keymap.set("i", "<C-L>", "<Plug>(copilot-suggest)", {
        desc = "Trigger Copilot suggestion"
      })
	  vim.keymap.set("n", "<leader>cop", "<cmd>Copilot enable<cr>", {
		desc = "Enable Copilot"
	  })
	  --disabled by default
      vim.g.copilot_enabled = false
    end,
  },
}
