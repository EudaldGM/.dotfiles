-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================
vim.pack.add({
	"https://www.github.com/lewis6991/gitsigns.nvim",
  "https://github.com/christoomey/vim-tmux-navigator",
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	-- Language Server Protocols
	"https://www.github.com/neovim/nvim-lspconfig",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/mason-org/mason.nvim",
  {
    src = 	"https://github.com/L3MON4D3/LuaSnip",
    version = "v2.5.0",
    build = "make install_jsregexp",
  },
  "https://github.com/folke/which-key.nvim",
  {
    src = "https://github.com/theprimeagen/harpoon",
    branch = "harpoon2"
  },
  "https://github.com/karb94/neoscroll.nvim",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/onsails/lspkind.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end

packadd("nvim-treesitter")
packadd("nvim-treesitter-textobjects")
packadd("nvim-web-devicons")
packadd("gitsigns.nvim")
packadd("mini.nvim")
packadd("vim-tmux-navigator")
packadd("fzf-lua")
packadd("nvim-tree.lua")
packadd("which-key.nvim")
packadd("harpoon")
packadd("neoscroll.nvim")
-- LSP
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("LuaSnip")
packadd("nvim-cmp")
packadd("cmp-nvim-lsp")
packadd("cmp-buffer")
packadd("cmp-path")
packadd("cmp_luasnip")
packadd("friendly-snippets")
packadd("lspkind.nvim")
packadd("mason-lspconfig.nvim")
packadd("mason-tool-installer.nvim")

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

--==================================
-- TMUX NAVIGATOR
--==================================
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>TmuxNavigatePrevious<CR>")

-- ============================================================================
-- TREESITTER
-- ============================================================================
require('nvim-treesitter').setup {
  highlight = {
    enable = true,
  },
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
}


--==================================
-- NVIM-TREE
--==================================
require("nvim-treesitter-textobjects").setup {
  select = {
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,
    -- You can choose the select mode (default is charwise 'v')
    --
    -- Can also be a function which gets passed a table with the keys
    -- * query_string: eg '@function.inner'
    -- * method: eg 'v' or 'o'
    -- and should return the mode ('v', 'V', or '<c-v>') or a table
    -- mapping query_strings to modes.
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V', -- linewise
      -- ['@class.outer'] = '<c-v>', -- blockwise
    },
    -- If you set this to `true` (default is `false`) then any textobject is
    -- extended to include preceding or succeeding whitespace. Succeeding
    -- whitespace has priority in order to act similarly to eg the built-in
    -- `ap`.
    --
    -- Can also be a function which gets passed a table with the keys
    -- * query_string: eg '@function.inner'
    -- * selection_mode: eg 'v'
    -- and should return true of false
    include_surrounding_whitespace = false,
  },
  move = {
    -- whether to set jumps in the jumplist
    set_jumps = true,
  },
}

vim.keymap.set({ "x", "o" }, "af", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "+f", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "+c", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
vim.keymap.set({ "n", "x", "o" }, "+l", function()
  require("nvim-treesitter-textobjects.move").goto_next_start({"@loop.inner", "@loop.outer"}, "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "+z", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end)

vim.keymap.set({ "n", "x", "o" }, "+F", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "+C", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "*f", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "*c", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "*F", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "*C", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end)

--==================================
-- NVIM-TREE
--==================================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  view = {
    width = 60,
    relativenumber = true,
  },
  renderer = {
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "",
          arrow_open  = "",
        },
      },
    },
  },
  actions = {
    open_file = {
      window_picker = { enable = false },
    },
  },
  filters = {
    custom = { ".DS_Store" },
  },
  git = { ignore = false },
})

vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>",          { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>",  { desc = "Toggle on current file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>",        { desc = "Collapse file explorer" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>",         { desc = "Refresh file explorer" })

-- ============================================================================
-- FZFLUA
-- ============================================================================
require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })


-- ============================================================================
-- MINI
-- ============================================================================
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})

--==================================
-- NEOSCROLL
--==================================
require("neoscroll").setup({})

local neoscroll = require("neoscroll")
local modes = { "n", "v", "x" }

for key, func in pairs({
  ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250 }) end,
  ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250 }) end,
  ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end,
  ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end,
  ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor = true, duration = 100 }) end,
  ["<C-e>"] = function() neoscroll.scroll(0.1,  { move_cursor = true, duration = 100 }) end,
  ["zt"]    = function() neoscroll.zt({ half_win_duration = 250 }) end,
  ["zz"]    = function() neoscroll.zz({ half_win_duration = 250 }) end,
  ["zb"]    = function() neoscroll.zb({ half_win_duration = 250 }) end,
}) do
  vim.keymap.set(modes, key, func)
end

--==================================
-- GITSIGNS
--==================================
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
vim.keymap.set("n", "<leader>o", function()
  vim.cmd("!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\\#L" .. vim.fn.line(".") .. " | xargs open")
end, { silent = true })

--==================================
-- MASON
--==================================
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "bashls",
    "gopls",
    "jsonls",
    "zls",
    "tflint",
    "rust_analyzer",
  },
  handlers = {
    function(server_name)
      vim.lsp.enable(server_name)
    end,
  },
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "isort",
    "black",
    "pylint",
    "goimports",
    "gotests",
    "terraform",
    "terraform-ls",
  },
})


-- ============================================================================
-- LSP, Linting, Formatting 
-- ============================================================================
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local keymap = vim.keymap

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    opts.desc = "Show LSP references"
    keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts)

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts)

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts)

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "¡D", "<cmd>FzfLua diagnostics_workspace<CR>", opts) -- fixed: added <CR>

    opts.desc = "Show line diagnostics"
    keymap.set("n", "¡d", vim.diagnostic.open_float, opts)

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "¿¿", vim.diagnostic.goto_prev, opts)

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "¡¡", vim.diagnostic.goto_next, opts)

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
  end,
})

local capabilities = cmp_nvim_lsp.default_capabilities()

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  virtual_text = true,
})

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      completion = { callSnippet = "Replace" },
    },
  },
})

-- Enable servers (was defined but never applied before)
vim.lsp.enable({ "terraformls", "tflint", "lua_ls" })

-- ============================================================================
-- COMPLETION
-- ============================================================================
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-q>"] = cmp.mapping.abort(),
    ["<CR>"]  = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})
