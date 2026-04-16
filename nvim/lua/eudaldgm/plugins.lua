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

require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V', -- linewise
      -- ['@class.outer'] = '<c-v>', -- blockwise
    },
    include_surrounding_whitespace = false,
  },
}

--==================================
-- TREESITTER TEXTOBJECTS
--==================================
local select  = require("nvim-treesitter-textobjects.select")
local swap    = require("nvim-treesitter-textobjects.swap")
local move    = require("nvim-treesitter-textobjects.move")
local repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    include_surrounding_whitespace = false,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"]  = "V",
    },
  },
  move = { set_jumps = true },
})

-- Repeatable movements with ; and ,
vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", repeat_move.repeat_last_move_previous)
-- Make f/F/t/T repeatable too
vim.keymap.set({ "n", "x", "o" }, "f", repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", repeat_move.builtin_T_expr, { expr = true })

-- SELECT
local function sel(query) return function() select.select_textobject(query, "textobjects") end end
local xo = { "x", "o" }
vim.keymap.set(xo, "a=", sel("@assignment.outer"),    { desc = "Outer assignment" })
vim.keymap.set(xo, "i=", sel("@assignment.inner"),    { desc = "Inner assignment" })
vim.keymap.set(xo, "l=", sel("@assignment.lhs"),      { desc = "Assignment LHS" })
vim.keymap.set(xo, "r=", sel("@assignment.rhs"),      { desc = "Assignment RHS" })
vim.keymap.set(xo, "aa", sel("@parameter.outer"),     { desc = "Outer parameter" })
vim.keymap.set(xo, "ia", sel("@parameter.inner"),     { desc = "Inner parameter" })
vim.keymap.set(xo, "ai", sel("@conditional.outer"),   { desc = "Outer conditional" })
vim.keymap.set(xo, "ii", sel("@conditional.inner"),   { desc = "Inner conditional" })
vim.keymap.set(xo, "al", sel("@loop.outer"),          { desc = "Outer loop" })
vim.keymap.set(xo, "il", sel("@loop.inner"),          { desc = "Inner loop" })
vim.keymap.set(xo, "am", sel("@call.outer"),          { desc = "Outer call" })
vim.keymap.set(xo, "im", sel("@call.inner"),          { desc = "Inner call" })
vim.keymap.set(xo, "af", sel("@function.outer"),      { desc = "Outer function" })
vim.keymap.set(xo, "if", sel("@function.inner"),      { desc = "Inner function" })
vim.keymap.set(xo, "ac", sel("@class.outer"),         { desc = "Outer class" })
vim.keymap.set(xo, "ic", sel("@class.inner"),         { desc = "Inner class" })
vim.keymap.set(xo, "ag", sel("@comment.outer"),       { desc = "Outer comment" })
vim.keymap.set(xo, "an", sel("@receiver.outer"),      { desc = "Outer receiver" })
vim.keymap.set(xo, "ar", sel("@return.outer"),        { desc = "Outer return" })
vim.keymap.set(xo, "ir", sel("@return.inner"),        { desc = "Inner return" })
vim.keymap.set(xo, "at", sel("@result.outer"),        { desc = "Outer result" })

-- SWAP
vim.keymap.set("n", "<leader>na", function() swap.swap_next("@parameter.inner") end, { desc = "Swap next parameter" })
vim.keymap.set("n", "<leader>nf", function() swap.swap_next("@function.outer") end,  { desc = "Swap next function" })
vim.keymap.set("n", "<leader>pa", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap prev parameter" })
vim.keymap.set("n", "<leader>pf", function() swap.swap_previous("@function.outer") end,  { desc = "Swap prev function" })

-- MOVE
local nxo = { "n", "x", "o" }
local function ns(query) return function() move.goto_next_start(query,     "textobjects") end end
local function ne(query) return function() move.goto_next_end(query,       "textobjects") end end
local function ps(query) return function() move.goto_previous_start(query, "textobjects") end end
local function pe(query) return function() move.goto_previous_end(query,   "textobjects") end end

vim.keymap.set(nxo, "+m", ns("@call.outer"),          { desc = "Next call start" })
vim.keymap.set(nxo, "+f", ns("@function.outer"),      { desc = "Next function start" })
vim.keymap.set(nxo, "+c", ns("@class.outer"),         { desc = "Next class start" })
vim.keymap.set(nxo, "+i", ns("@conditional.outer"),   { desc = "Next conditional start" })
vim.keymap.set(nxo, "+l", ns("@loop.outer"),          { desc = "Next loop start" })
vim.keymap.set(nxo, "+r", ns("@return.outer"),        { desc = "Next return start" })
vim.keymap.set(nxo, "+p", ns("@parameter.inner"),     { desc = "Next parameter" })
vim.keymap.set(nxo, "+w", ns("@receiver.outer"),      { desc = "Next receiver" })
vim.keymap.set(nxo, "+t", ns("@result.outer"),        { desc = "Next result" })

vim.keymap.set(nxo, "+M", ne("@call.outer"),          { desc = "Next call end" })
vim.keymap.set(nxo, "+F", ne("@function.outer"),      { desc = "Next function end" })
vim.keymap.set(nxo, "+C", ne("@class.outer"),         { desc = "Next class end" })
vim.keymap.set(nxo, "+I", ne("@conditional.outer"),   { desc = "Next conditional end" })
vim.keymap.set(nxo, "+L", ne("@loop.outer"),          { desc = "Next loop end" })
vim.keymap.set(nxo, "+R", ne("@return.outer"),        { desc = "Next return end" })
vim.keymap.set(nxo, "+P", ne("@parameter.inner"),     { desc = "Next parameter end" })
vim.keymap.set(nxo, "+W", ne("@receiver.outer"),      { desc = "Next receiver end" })

vim.keymap.set(nxo, "*m", ps("@call.outer"),          { desc = "Prev call start" })
vim.keymap.set(nxo, "*f", ps("@function.outer"),      { desc = "Prev function start" })
vim.keymap.set(nxo, "*c", ps("@class.outer"),         { desc = "Prev class start" })
vim.keymap.set(nxo, "*i", ps("@conditional.outer"),   { desc = "Prev conditional start" })
vim.keymap.set(nxo, "*l", ps("@loop.outer"),          { desc = "Prev loop start" })
vim.keymap.set(nxo, "*r", ps("@return.outer"),        { desc = "Prev return start" })
vim.keymap.set(nxo, "*p", ps("@parameter.inner"),     { desc = "Prev parameter" })
vim.keymap.set(nxo, "*w", ps("@receiver.outer"),      { desc = "Prev receiver" })
vim.keymap.set(nxo, "*t", ps("@result.outer"),        { desc = "Prev result" })

vim.keymap.set(nxo, "*M", pe("@call.outer"),          { desc = "Prev call end" })
vim.keymap.set(nxo, "*F", pe("@function.outer"),      { desc = "Prev function end" })
vim.keymap.set(nxo, "*C", pe("@class.outer"),         { desc = "Prev class end" })
vim.keymap.set(nxo, "*I", pe("@conditional.outer"),   { desc = "Prev conditional end" })
vim.keymap.set(nxo, "*L", pe("@loop.outer"),          { desc = "Prev loop end" })
vim.keymap.set(nxo, "*R", pe("@return.outer"),        { desc = "Prev return end" })
vim.keymap.set(nxo, "*P", pe("@parameter.inner"),     { desc = "Prev parameter end" })
vim.keymap.set(nxo, "*W", pe("@receiver.outer"),      { desc = "Prev receiver end" })

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
require("mini.ai").setup({})
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
