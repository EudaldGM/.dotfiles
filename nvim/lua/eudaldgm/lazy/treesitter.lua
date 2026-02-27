return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
<<<<<<< HEAD
  lazy = false,
=======
  event = { "BufReadPre", "BufNewFile"},
>>>>>>> parent of a2d434e (fixes)
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
<<<<<<< HEAD
    local treesitter = require("nvim-treesitter.config")
    treesitter.setup({
=======
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
>>>>>>> parent of a2d434e (fixes)
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "yaml",
        "html",
        "css",
        "bash",
		"helm",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "vimdoc",
		"python",
		"toml",
		"go",
		"rust",
		"hcl",
		"terraform",
		"zig"
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    -- use bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
  end,
}
