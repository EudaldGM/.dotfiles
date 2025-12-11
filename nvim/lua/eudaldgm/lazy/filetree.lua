return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 40,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })
	

	-- Telescope live_grep in folder under cursor
	local function live_grep_in_folder()
	  local api = require("nvim-tree.api")
	  local node = api.tree.get_node_under_cursor()

	  if not node then
		print("No node under cursor")
		return
	  end

	  -- Determine target directory
	  local directory = node.absolute_path
	  if node.type ~= "directory" then
		directory = vim.fn.fnamemodify(node.absolute_path, ":h")
	  end

	  require("telescope.builtin").live_grep({
		cwd = directory,
		prompt_title = "Live Grep: " .. directory,
	  })
	end


    -- set keymaps
    local keymap = vim.keymap -- for conciseness

	keymap.set("n", "<leader>eg", live_grep_in_folder, {
	  desc = "Live grep in selected nvim-tree folder",
	})

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
