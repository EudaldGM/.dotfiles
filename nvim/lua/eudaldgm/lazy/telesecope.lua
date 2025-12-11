return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    telescope.load_extension("fzf")

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
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find todos" })
	keymap.set("n", "<leader>hf", function() require("telescope.builtin").find_files { hidden = true } end, { desc = "Find hidden files" })
	keymap.set("n", "<leader>hg", function() require("telescope.builtin").live_grep { hidden = true } end, { desc = "Find hidden files" })

  end,
}
