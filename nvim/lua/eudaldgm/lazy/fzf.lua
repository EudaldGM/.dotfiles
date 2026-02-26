-- ~/.config/nvim/lua/plugins/fzf-lua.lua
return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy", -- load on demand
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
  config = function()
    local keymap = vim.keymap
    local fzf = require("fzf-lua")

    -- Live grep in current file's folder
    keymap.set("n", "<leader>eg", function()
      fzf.grep({ cwd = vim.fn.expand("%:p:h") })
    end, { desc = "Live grep in current file folder" })

    -- Fuzzy find files in cwd
    keymap.set("n", "<leader>ff", function()
      fzf.files()
    end, { desc = "Fuzzy find files in cwd" })

    -- Fuzzy find recent files
    keymap.set("n", "<leader>fr", function()
      fzf.oldfiles()
    end, { desc = "Fuzzy find recent files" })

    -- Find string in cwd
    keymap.set("n", "<leader>fg", function()
      fzf.live_grep()
    end, { desc = "Find string in cwd" })

    -- Find string under cursor in cwd
    keymap.set("n", "<leader>fc", function()
      fzf.grep({ search = vim.fn.expand("<cword>") })
    end, { desc = "Find string under cursor" })

    -- Find todos
    keymap.set("n", "<leader>ft", function()
      fzf.grep({ search = "TODO" }) -- adjust pattern if needed
    end, { desc = "Find todos" })

    -- Find keymaps
    keymap.set("n", "<leader>fk", function()
      fzf.keymap()
    end, { desc = "Find keymaps" })

    -- Find hidden files
    keymap.set("n", "<leader>hf", function()
      fzf.files({ hidden = true, no_ignore = true })
    end, { desc = "Find hidden files" })

    -- Find string in hidden files
    keymap.set("n", "<leader>hg", function()
      fzf.grep({ hidden = true, no_ignore = true })
    end, { desc = "Find string in hidden files" })

    -- Buffer Nav
    keymap.set("n", "<leader>fb", function()
      fzf.buffers({ hidden = true, no_ignore = true })
    end, { desc = "Navigate buffers" })
  end,
}
