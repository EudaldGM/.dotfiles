-- =============================================================================
-- plugins.lua
-- Plugin management via Neovim 0.12's built-in vim.pack
--
-- Directory layout expected under stdpath("data") .. "/site/pack/":
--
--   pack/
--   └── plugins/
--       ├── start/          ← auto-loaded on startup
--       │   ├── nvim-web-devicons/
--       │   ├── mini.nvim/
--       │   ├── vim-tmux-navigator/
--       │   ├── which-key.nvim/
--       │   └── ...
--       └── opt/            ← loaded on demand via `packadd`
--           ├── nvim-lspconfig/
--           ├── nvim-treesitter/
--           ├── nvim-cmp/
--           └── ...
--
-- To install / update all plugins, run the helper at the bottom:
--   :luafile %    (from this file, or)
--   :lua require("eudaldgm.plugins").install()
-- =============================================================================

local M = {}

-- ---------------------------------------------------------------------------
-- Plugin registry
-- Each entry: { "author/repo", opt = bool, branch = string|nil }
-- opt=true  → placed in pack/plugins/opt/  (loaded below with packadd)
-- opt=false → placed in pack/plugins/start/ (auto-loaded by Neovim)
-- ---------------------------------------------------------------------------
local plugins = {
  -- Icons (start: needed by many others)
  { "nvim-tree/nvim-web-devicons" },

  -- UI / Navigation
  { "folke/which-key.nvim" },
  { "christoomey/vim-tmux-navigator" },
  { "karb94/neoscroll.nvim" },

  -- Mini suite (icons, pairs, surround, align, indentscope)
  { "echasnovski/mini.nvim" },

  -- File tree
  { "nvim-tree/nvim-tree.lua" },

  -- Fuzzy finder
  { "ibhagwan/fzf-lua" },

  -- Harpoon 2
  { "nvim-lua/plenary.nvim" },
  { "ThePrimeagen/harpoon", branch = "harpoon2" },

  -- Git
  { "lewis6991/gitsigns.nvim" },

  -- Treesitter (opt: heavy, loaded on BufReadPre)
  { "nvim-treesitter/nvim-treesitter",                opt = true, },
  { "nvim-treesitter/nvim-treesitter-textobjects",    opt = true, },

  -- LSP
  { "neovim/nvim-lspconfig",                          opt = true },
  { "folke/neodev.nvim",                              opt = true },
  { "antosha417/nvim-lsp-file-operations",            opt = true },

  -- Mason
  { "williamboman/mason.nvim",                        opt = true },
  { "williamboman/mason-lspconfig.nvim",              opt = true },
  { "WhoIsSethDaniel/mason-tool-installer.nvim",      opt = true },

  -- Completion
  { "hrsh7th/nvim-cmp",                               opt = true },
  { "hrsh7th/cmp-nvim-lsp",                           opt = true },
  { "hrsh7th/cmp-buffer",                             opt = true },
  { "hrsh7th/cmp-path",                               opt = true },
  { "saadparwaiz1/cmp_luasnip",                       opt = true },
  { "L3MON4D3/LuaSnip",                               opt = true },
  { "rafamadriz/friendly-snippets",                   opt = true },
  { "onsails/lspkind.nvim",                           opt = true },
}

-- ---------------------------------------------------------------------------
-- Install helper  (git clone / pull)
-- Run once to bootstrap, then :lua require("eudaldgm.plugins").install()
-- ---------------------------------------------------------------------------
local pack_root = vim.fn.stdpath("data") .. "/site/pack/plugins"

function M.install()
  for _, p in ipairs(plugins) do
    local name = p[1]:match("[^/]+$")
    local dir  = pack_root .. (p.opt and "/opt/" or "/start/") .. name
    local branch_flag = p.branch and ("--branch " .. p.branch .. " ") or ""
    if vim.fn.isdirectory(dir) == 0 then
      vim.notify("Installing " .. p[1] .. " …", vim.log.levels.INFO)
      vim.fn.system(
        "git clone --filter=blob:none --depth=1 "
        .. branch_flag
        .. "https://github.com/" .. p[1] .. ".git "
        .. dir
      )
    else
      -- pull latest on the correct branch
      vim.fn.system("git -C " .. dir .. " pull --ff-only")
    end
  end
  vim.notify("Plugins up to date.", vim.log.levels.INFO)
end

-- ---------------------------------------------------------------------------
-- Load opt plugins immediately (they are opt only to avoid re-ordering
-- issues; packadd is instant for already-installed plugins)
-- ---------------------------------------------------------------------------
local opt_packs = {
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-lspconfig",
  "neodev.nvim",
  "nvim-lsp-file-operations",
  "mason.nvim",
  "mason-lspconfig.nvim",
  "mason-tool-installer.nvim",
  "nvim-cmp",
  "cmp-nvim-lsp",
  "cmp-buffer",
  "cmp-path",
  "cmp_luasnip",
  "LuaSnip",
  "friendly-snippets",
  "lspkind.nvim",
}

for _, name in ipairs(opt_packs) do
  pcall(vim.cmd, "packadd " .. name)
end

-- =============================================================================
-- PLUGIN CONFIGURATIONS
-- =============================================================================

-- ---------------------------------------------------------------------------
-- which-key
-- ---------------------------------------------------------------------------
local ok, wk = pcall(require, "which-key")
if ok then
  wk.setup({})
end

-- ---------------------------------------------------------------------------
-- vim-tmux-navigator  (keys defined by the plugin itself via g: vars)
-- ---------------------------------------------------------------------------
vim.g.tmux_navigator_no_mappings = 0   -- let it set default <C-h/j/k/l>

-- ---------------------------------------------------------------------------
-- mini.nvim
-- ---------------------------------------------------------------------------
ok = pcall(function()
  require("mini.icons").setup()
  require("mini.indentscope").setup()
  require("mini.pairs").setup()
  require("mini.align").setup()
  require("mini.surround").setup()
  -- NOTE: mini.statusline intentionally skipped; custom statusline in vconf.lua
end)

-- ---------------------------------------------------------------------------
-- neoscroll
-- ---------------------------------------------------------------------------
ok = pcall(function()
  local neoscroll = require("neoscroll")
  neoscroll.setup({})
  local keymap = {
    ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250 }) end,
    ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250 }) end,
    ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end,
    ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end,
    ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor = true, duration = 100 }) end,
    ["<C-e>"] = function() neoscroll.scroll(0.1,  { move_cursor = true, duration = 100 }) end,
    ["zt"]    = function() neoscroll.zt({ half_win_duration = 250 }) end,
    ["zz"]    = function() neoscroll.zz({ half_win_duration = 250 }) end,
    ["zb"]    = function() neoscroll.zb({ half_win_duration = 250 }) end,
  }
  for key, func in pairs(keymap) do
    vim.keymap.set({ "n", "v", "x" }, key, func)
  end
end)

-- ---------------------------------------------------------------------------
-- nvim-tree
-- ---------------------------------------------------------------------------
ok = pcall(function()
  vim.g.loaded_netrw       = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup({
    view = { width = 60, relativenumber = true },
    renderer = {
      indent_markers = { enable = true },
      icons = {
        glyphs = {
          folder = { arrow_closed = "", arrow_open = "" },
        },
      },
    },
    actions = { open_file = { window_picker = { enable = false } } },
    filters = { custom = { ".DS_Store" } },
    git    = { ignore = false },
  })

  vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>",          { desc = "Toggle file explorer" })
  vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>",  { desc = "Toggle file explorer on current file" })
  vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>",        { desc = "Collapse file explorer" })
  vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>",         { desc = "Refresh file explorer" })
end)

-- ---------------------------------------------------------------------------
-- fzf-lua
-- ---------------------------------------------------------------------------
ok = pcall(function()
  local fzf = require("fzf-lua")

  vim.keymap.set("n", "<leader>eg", function() fzf.grep({ cwd = vim.fn.expand("%:p:h") }) end,          { desc = "Live grep in current file folder" })
  vim.keymap.set("n", "<leader>ff", function() fzf.files() end,                                          { desc = "Fuzzy find files in cwd" })
  vim.keymap.set("n", "<leader>fr", function() fzf.oldfiles() end,                                       { desc = "Fuzzy find recent files" })
  vim.keymap.set("n", "<leader>fg", function() fzf.live_grep() end,                                      { desc = "Find string in cwd" })
  vim.keymap.set("n", "<leader>fc", function() fzf.grep({ search = vim.fn.expand("<cword>") }) end,      { desc = "Find string under cursor" })
  vim.keymap.set("n", "<leader>ft", function() fzf.grep({ search = "TODO" }) end,                        { desc = "Find todos" })
  vim.keymap.set("n", "<leader>fk", function() fzf.keymaps() end,                                        { desc = "Find keymaps" })
  vim.keymap.set("n", "<leader>hf", function() fzf.files({ hidden = true, no_ignore = true }) end,       { desc = "Find hidden files" })
  vim.keymap.set("n", "<leader>hg", function() fzf.grep({ hidden = true, no_ignore = true }) end,        { desc = "Find string in hidden files" })
  vim.keymap.set("n", "<leader>fb", function() fzf.buffers({ hidden = true, no_ignore = true }) end,     { desc = "Navigate buffers" })
end)

-- ---------------------------------------------------------------------------
-- harpoon 2
-- ---------------------------------------------------------------------------
ok = pcall(function()
  local harpoon = require("harpoon")
  harpoon:setup()

  vim.keymap.set("n", "<leader>ta", function() harpoon:list():add() end,                              { desc = "Harpoon add file" })
  vim.keymap.set("n", "<leader>te", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,     { desc = "Harpoon menu" })
  vim.keymap.set("n", "<leader>t1", function() harpoon:list():select(1) end,                         { desc = "Harpoon file 1" })
  vim.keymap.set("n", "<leader>t2", function() harpoon:list():select(2) end,                         { desc = "Harpoon file 2" })
  vim.keymap.set("n", "<leader>t3", function() harpoon:list():select(3) end,                         { desc = "Harpoon file 3" })
  vim.keymap.set("n", "<leader>t4", function() harpoon:list():select(4) end,                         { desc = "Harpoon file 4" })
  vim.keymap.set("n", "<leader>TT", function() harpoon:list():prev() end,                            { desc = "Harpoon prev" })
  vim.keymap.set("n", "<leader>tt", function() harpoon:list():next() end,                            { desc = "Harpoon next" })
  vim.keymap.set("n", "<leader>tr", function() harpoon:list():remove() end,                          { desc = "Harpoon remove file" })
end)

-- ---------------------------------------------------------------------------
-- gitsigns
-- ---------------------------------------------------------------------------
ok = pcall(function()
  local gitsigns = require("gitsigns")
  gitsigns.setup({ current_line_blame_opts = { delay = 10 } })

  vim.keymap.set("n", "<leader>Gl", function() gitsigns.toggle_current_line_blame() end, { desc = "Toggle inline git blame" })
  vim.keymap.set("n", "<leader>Gb", ":Gitsigns blame<CR>", { silent = true, desc = "Open Gitsigns blame" })
  vim.keymap.set("n", "<leader>o", function()
    vim.cmd("!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\\#L" .. vim.fn.line(".") .. " | xargs open")
  end, { silent = true, desc = "Open file in remote git" })
end)

-- ---------------------------------------------------------------------------
-- treesitter
-- ---------------------------------------------------------------------------
ok = pcall(function()
  require("nvim-treesitter.configs").setup({
    highlight           = { enable = true },
    indent              = { enable = true },
    ensure_installed    = {
      "json", "yaml", "html", "css", "bash", "helm", "lua", "vim",
      "dockerfile", "gitignore", "vimdoc", "python", "toml", "go",
      "rust", "hcl", "terraform", "zig",
    },
    incremental_selection = {
      enable  = true,
      keymaps = {
        init_selection    = "<C-space>",
        node_incremental  = "<C-space>",
        scope_incremental = false,
        node_decremental  = "<bs>",
      },
    },
    textobjects = {
      select = {
        enable    = true,
        lookahead = true,
        keymaps   = {
          ["a="] = { query = "@assignment.outer",  desc = "Select outer part of an assignment" },
          ["i="] = { query = "@assignment.inner",  desc = "Select inner part of an assignment" },
          ["l="] = { query = "@assignment.lhs",    desc = "Select left hand side of an assignment" },
          ["r="] = { query = "@assignment.rhs",    desc = "Select right hand side of an assignment" },
          ["aa"] = { query = "@parameter.outer",   desc = "Select outer part of a parameter/argument" },
          ["ia"] = { query = "@parameter.inner",   desc = "Select inner part of a parameter/argument" },
          ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
          ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
          ["al"] = { query = "@loop.outer",        desc = "Select outer part of a loop" },
          ["il"] = { query = "@loop.inner",        desc = "Select inner part of a loop" },
          ["am"] = { query = "@call.outer",        desc = "Select outer part of a function call" },
          ["im"] = { query = "@call.inner",        desc = "Select inner part of a function call" },
          ["af"] = { query = "@function.outer",    desc = "Select outer part of a method/function def" },
          ["if"] = { query = "@function.inner",    desc = "Select inner part of a method/function def" },
          ["ac"] = { query = "@class.outer",       desc = "Select outer part of a class" },
          ["ic"] = { query = "@class.inner",       desc = "Select inner part of a class" },
          ["ag"] = { query = "@comment.outer",     desc = "Select outer part of a comment" },
          ["aP"] = { query = "@parameter_list.outer", desc = "Select all parameters" },
          ["ap"] = { query = "@parameter.outer",   desc = "Select outer part of a parameter" },
          ["ip"] = { query = "@parameter.inner",   desc = "Select inner part of a parameter" },
          ["an"] = { query = "@receiver.outer",    desc = "Select outer part of a method receiver" },
          ["ar"] = { query = "@return.outer",      desc = "Select outer part of a method return" },
          ["ir"] = { query = "@return.inner",      desc = "Select inner part of a method return" },
          ["at"] = { query = "@result.outer",      desc = "Select outer part of a result" },
        },
      },
      swap = {
        enable       = true,
        swap_next    = {
          ["<leader>na"] = "@parameter.inner",
          ["<leader>nf"] = "@function.outer",
        },
        swap_previous = {
          ["<leader>pa"] = "@parameter.inner",
          ["<leader>pf"] = "@function.outer",
        },
      },
      move = {
        enable     = true,
        set_jumps  = true,
        goto_next_start = {
          ["+m"] = { query = "@call.outer",        desc = "Next function call start" },
          ["+f"] = { query = "@function.outer",    desc = "Next method/function def start" },
          ["+c"] = { query = "@class.outer",       desc = "Next class start" },
          ["+i"] = { query = "@conditional.outer", desc = "Next conditional start" },
          ["+l"] = { query = "@loop.outer",        desc = "Next loop start" },
          ["+r"] = { query = "@return.outer",      desc = "Next return start" },
          ["+p"] = { query = "@parameter.inner",   desc = "Next function parameter" },
          ["+w"] = { query = "@receiver.outer",    desc = "Next method receiver" },
          ["+t"] = { query = "@result.outer",      desc = "Next result" },
        },
        goto_next_end = {
          ["+M"] = { query = "@call.outer",        desc = "Next function call end" },
          ["+F"] = { query = "@function.outer",    desc = "Next method/function def end" },
          ["+C"] = { query = "@class.outer",       desc = "Next class end" },
          ["+I"] = { query = "@conditional.outer", desc = "Next conditional end" },
          ["+L"] = { query = "@loop.outer",        desc = "Next loop end" },
          ["+R"] = { query = "@return.outer",      desc = "Next return end" },
          ["+P"] = { query = "@parameter.inner",   desc = "Next function parameter end" },
          ["+W"] = { query = "@receiver.outer",    desc = "Next method receiver end" },
        },
        goto_previous_start = {
          ["*m"] = { query = "@call.outer",        desc = "Prev function call start" },
          ["*f"] = { query = "@function.outer",    desc = "Prev method/function def start" },
          ["*c"] = { query = "@class.outer",       desc = "Prev class start" },
          ["*i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
          ["*l"] = { query = "@loop.outer",        desc = "Prev loop start" },
          ["*r"] = { query = "@return.outer",      desc = "Prev return start" },
          ["*p"] = { query = "@parameter.inner",   desc = "Prev function parameter" },
          ["*w"] = { query = "@receiver.outer",    desc = "Prev method receiver" },
          ["*t"] = { query = "@result.outer",      desc = "Prev result" },
        },
        goto_previous_end = {
          ["*M"] = { query = "@call.outer",        desc = "Prev function call end" },
          ["*F"] = { query = "@function.outer",    desc = "Prev method/function def end" },
          ["*C"] = { query = "@class.outer",       desc = "Prev class end" },
          ["*I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
          ["*L"] = { query = "@loop.outer",        desc = "Prev loop end" },
          ["*R"] = { query = "@return.outer",      desc = "Prev return end" },
          ["*P"] = { query = "@parameter.inner",   desc = "Prev function parameter end" },
          ["*W"] = { query = "@receiver.outer",    desc = "Prev method receiver end" },
        },
      },
    },
  })

  -- Use bash parser for zsh files
  vim.treesitter.language.register("bash", "zsh")
end)

-- ---------------------------------------------------------------------------
-- Mason
-- ---------------------------------------------------------------------------
ok = pcall(function()
  require("mason").setup({
    ui = {
      icons = {
        package_installed   = "✓",
        package_pending     = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls", "pyright", "bashls", "gopls",
      "jsonls", "zls", "tflint", "rust_analyzer",
    },
  })

  require("mason-tool-installer").setup({
    ensure_installed = {
      "prettier", "stylua", "isort", "black", "pylint",
      "goimports", "gotests", "terraform", "terraform-ls",
    },
  })
end)

-- ---------------------------------------------------------------------------
-- nvim-cmp
-- ---------------------------------------------------------------------------
ok = pcall(function()
  local cmp     = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    completion = { completeopt = "menu,menuone,preview,noselect" },
    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
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
      format = lspkind.cmp_format({ maxwidth = 50, ellipsis_char = "..." }),
    },
  })
end)

-- ---------------------------------------------------------------------------
-- LSP
-- ---------------------------------------------------------------------------
ok = pcall(function()
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local capabilities = cmp_nvim_lsp.default_capabilities()

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local opts = { buffer = ev.buf, silent = true }

      opts.desc = "Show LSP references"
      vim.keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts)

      opts.desc = "Show LSP implementations"
      vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      vim.keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts)

      opts.desc = "See available code actions"
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Show buffer diagnostics"
      vim.keymap.set("n", "¡D", "<cmd>FzfLua diagnostics_workspace<CR>", opts)

      opts.desc = "Show line diagnostics"
      vim.keymap.set("n", "¡d", vim.diagnostic.open_float, opts)

      opts.desc = "Go to previous diagnostic"
      vim.keymap.set("n", "¿¿", vim.diagnostic.goto_prev, opts)

      opts.desc = "Go to next diagnostic"
      vim.keymap.set("n", "¡¡", vim.diagnostic.goto_next, opts)

      opts.desc = "Show documentation"
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end,
  })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN]  = " ",
        [vim.diagnostic.severity.HINT]  = "󰠠 ",
        [vim.diagnostic.severity.INFO]  = " ",
      },
    },
    virtual_text = true,
  })

  vim.lsp.config("*", { capabilities = capabilities })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        completion  = { callSnippet = "Replace" },
      },
    },
  })
end)

return M
