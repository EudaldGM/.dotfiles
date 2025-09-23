return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
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
	  pickers = {
		find_files = {
		  hidden = true
		}
	  },
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

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Open keymaps in telescope" })

	-- basic telescope configuration
	-- local conf = require("telescope.config").values
	-- local function toggle_telescope(harpoon_files)
	-- 	local finder = function()
	-- 		local paths = {}
	-- 		for _, item in ipairs(harpoon_files.items) do
	-- 			table.insert(paths, item.value)
	-- 		end
	--
	-- 		return require("telescope.finders").new_table({
	-- 			results = paths,
	-- 		})
	-- 	end
	--
	-- 	require("telescope.pickers").new({}, {
	-- 		prompt_title = "Harpoon",
	-- 		finder = finder(),
	-- 		previewer = conf.file_previewer({}),
	-- 		sorter = conf.generic_sorter({}),
	-- 		layout_config = {
	-- 			height = 0.4,
	-- 			width = 0.5,
	-- 			prompt_position = "top",
	-- 			preview_cutoff = 120,
	-- 		},
	-- 		attach_mappings = function(prompt_bufnr, map)
	-- 			map("i", "<C-d>", function()
	-- 				local state = require("telescope.actions.state")
	-- 				local selected_entry = state.get_selected_entry()
	-- 				local current_picker = state.get_current_picker(prompt_bufnr)
	--
	-- 				table.remove(harpoon_files.items, selected_entry.index)
	-- 				current_picker:refresh(finder())
	-- 			end)
	-- 			return true
	-- 		end,
	-- 	}):find()
	-- end
	--
	-- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
	-- 	{ desc = "Open harpoon window" })
  end,
}


