-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================

local plugins = {
  -- UI
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/karb94/neoscroll.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/rebelot/kanagawa.nvim",

  -- Navigation
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/ibhagwan/fzf-lua",
  { src = "https://github.com/theprimeagen/harpoon", branch = "harpoon2" },

  -- LSP
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

  -- Completion
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/onsails/lspkind.nvim",

  -- Snippets
  { src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.5.0", build = "make install_jsregexp" },
  "https://github.com/rafamadriz/friendly-snippets",

  -- Treesitter
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",

  -- DAP
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/leoluz/nvim-dap-go",
  "https://github.com/mfussenegger/nvim-dap-python",
  "https://github.com/mrcjkb/rustaceanvim",
  -- -- LLM
  -- "https://github.com/huggingface/llm.nvim",
}

vim.pack.add(plugins)

for _, plugin in ipairs(plugins) do
  local src = type(plugin) == "string" and plugin or plugin.src
  local name = src:match("/([^/]+)$")
  vim.cmd("packadd " .. name)
end

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

require('kanagawa').setup({
  overrides = function(colors)
    return {
      DiagnosticError            = { fg = "#ed4040" },
      DiagnosticVirtualTextError = { fg = "#ed4040", bg = "#2D1414" },
      DiagnosticUnderlineError   = { sp = "#ed4040", undercurl = true },
    }
  end,
})
vim.cmd("colorscheme kanagawa")

--==================================
-- TREESITTER
--==================================

require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require('nvim-treesitter').install {
  'json',
  'yaml',
  'html',
  'css',
  'bash',
  'lua',
  'vim',
  'dockerfile',
  'gitignore',
  'vimdoc',
  'python',
  'toml',
  'go',
  'rust',
  'hcl',
  'terraform',
  'zig'
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
--==================================
-- TMUX NAVIGATOR
--==================================
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>TmuxNavigatePrevious<CR>")

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
          arrow_closed = "", -- arrow when folder is closed
          arrow_open = "", -- arrow when folder is open
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
require("fzf-lua").setup()

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
vim.keymap.set('n', '<leader>fN', ':e %:p:h/', {desc = "Edit new file in current directory"})

-- ============================================================================
-- MINI
-- ============================================================================
require("mini.ai").setup({
  mappings = {
    goto_left = '+',
  },
  custom_textobjects = {
    f = require("mini.ai").gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    c = require("mini.ai").gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
    y = require("mini.ai").gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
    o = require("mini.ai").gen_spec.treesitter({ a = '@loop.outer', i = '@loop.inner' }),
    g = require("mini.ai").gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }),
    m = require("mini.ai").gen_spec.treesitter({ a = '@call.outer', i = '@call.inner' }),
    p = require("mini.ai").gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
    e = require("mini.ai").gen_spec.treesitter({ a = '@assignment.outer', i = '@assignment.inner' }),
  }
})
require("mini.comment").setup()
require("mini.move").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require('mini.indentscope').setup()
require("mini.notify").setup()
require("mini.icons").setup()
require('mini.align').setup()

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
vim.keymap.set('n', '<leader>Gb', ':Gitsigns toggle_current_line_blame<CR>', { silent = true, desc = "Open Gitsigns gitblame" })
vim.keymap.set("n", "<leader>Go", function()
  vim.cmd("!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\\#L" .. vim.fn.line(".") .. " | xargs open")
end, { silent = true })
vim.keymap.set('n', '<leader>Gd', ':Gitsigns diffthis', {silent = true, desc = "Diffs this file before changes"})

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
    "codelldb",
    "delve",
    "debugpy",
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
    keymap.set("n", "¿¿", function() vim.diagnostic.jump({ count = -1 }) end, opts)

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "¡¡", function() vim.diagnostic.jump({ count = 1 }) end, opts)

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

-- ============================================================================
-- DAP
-- ============================================================================
-- Dap configs and keymaps
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

local dap, dapui = require('dap'), require('dapui')

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
 dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
 dapui.open()
end

vim.keymap.set('n', '<leader>dw', function() dapui.close()           end, { desc = "Close  dap  ui"})
vim.keymap.set('n', '<leader>t',  function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint"})
vim.keymap.set('n', '<leader>5',  function() dap.continue()          end, { desc = "Dap  Cont"})
vim.keymap.set('n', '<leader>8',  function() dap.step_over()         end, { desc = "Dap  Step Over"})
vim.keymap.set('n', '<leader>9',  function() dap.step_into()         end, { desc = "Dap  Step Into"})
vim.keymap.set('n', '<leader>0',  function() dap.step_out()          end, { desc = "Dap  Step Out"})
vim.keymap.set('n', '<leader>dt', function() dap.terminate()         end, { desc = "Dap  Terminate"})
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open()         end, { desc = "Open Dap  repl"})
vim.keymap.set('n', '<Leader>dl', function() dap.run_last()          end, { desc = "Run  last command"})


vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "Log point message"})

vim.keymap.set('n', '<leader>dL', function()
  require('dap.ext.vscode').load_launchjs(nil, {
    codelldb    = { 'rust' },
    python      = { 'python' },
    go          = { 'go' },
  })
  vim.notify('launch.json reloaded', vim.log.levels.INFO)
end, { desc = "Reload launch.json" })

-- Language debug prots
-- Go: requires delve
require('dap-go').setup({
  dap_configurations = {
    {
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  },
})

-- Python: requires debugpy
-- ###
-- python3 -m venv ~/debugpy
-- ~/debugpy/bin/python -m pip install debugpy
require("dap-python").setup("~/debugpy/bin/python")

-- Rust
local codelldb_path = vim.fn.stdpath('data') .. '/mason/bin/codelldb'

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = codelldb_path,
    args = { '--port', '${port}' },
  },
}

dap.configurations.rust = {
  {
    name    = 'Launch binary',
    type    = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd            = '${workspaceFolder}',
    stopOnEntry    = false,
    args           = {},
  },
  {
    name    = 'Launch binary (with args)',
    type    = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd            = '${workspaceFolder}',
    stopOnEntry    = false,
    args           = function()
      local args = vim.fn.input('Arguments: ')
      return vim.split(args, ' ')
    end,
  },
  {
    name    = 'Attach to process',
    type    = 'codelldb',
    request = 'attach',
    pid     = require('dap.utils').pick_process,
    args    = {},
  },
}

-- ============================================================================
-- LLM
-- ============================================================================

-- vim.keymap.set('i', '<c-j>', function()
--   require('llm.completion').complete()
-- end, { desc = 'complete' })
--
-- require('llm').setup({
--   lsp_timeout = 10000,
--   lsp = {
--     bin_path = '/etc/profiles/per-user/s1n7ax/bin/llm-ls',
--     cmd_env = { LLM_LOG_LEVEL = 'DEBUG' },
--   },
--   backend = 'ollama',
--   model = 'deepseek-coder:1.3b-base',
--   url = 'http://localhost:11434',
--   fim = {
--     enabled = true,
--     prefix = '<｜fim▁begin｜>',
--     suffix = '<｜fim▁hole｜>',
--     middle = '<｜fim▁end｜>',
--   },
--   request_body = {
--     options = {
--       temperature = 0.2,
--       top_p = 0.95,
--     },
--     stream = false,
--   },
-- })
