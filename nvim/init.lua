vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")

local function set_transparent() 
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

set_transparent()

-- ============================================================================
-- OPTIONS
-- ============================================================================

vim.opt.number = true 
vim.opt.relativenumber = true 
vim.opt.cursorline = true 
vim.opt.wrap = false
vim.opt.scrolloff = 10 
vim.opt.sidescrolloff = 10 

vim.opt.tabstop = 2 
vim.opt.shiftwidth = 2 
vim.opt.softtabstop = 2 
vim.opt.expandtab = true 
vim.opt.smartindent = true 
vim.opt.autoindent = true 

vim.opt.ignorecase = true 
vim.opt.smartcase = true 
vim.opt.hlsearch = true 
vim.opt.incsearch = true 

vim.opt.signcolumn = "yes" 
vim.opt.colorcolumn = "100" 
vim.opt.showmatch = true 
vim.opt.cmdheight = 1 
vim.opt.completeopt = "menuone,noinsert,noselect" 
vim.opt.showmode = false 
vim.opt.pumheight = 10 
vim.opt.pumblend = 10 
vim.opt.winblend = 0 
vim.opt.conceallevel = 0 
vim.opt.concealcursor = "" 
vim.opt.lazyredraw = true 
vim.opt.synmaxcol = 300 
vim.opt.fillchars = { eob = " " } 

local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false 
vim.opt.writebackup = false 
vim.opt.swapfile = false 
vim.opt.undofile = true 
vim.opt.undodir = undodir 
vim.opt.updatetime = 300 
vim.opt.timeoutlen = 500 
vim.opt.ttimeoutlen = 0 
vim.opt.autoread = true 
vim.opt.autowrite = false 

vim.opt.hidden = true 
vim.opt.errorbells = false 
vim.opt.backspace = "indent,eol,start" 
vim.opt.autochdir = false 
vim.opt.iskeyword:append("-") 
vim.opt.path:append("**") 
vim.opt.selection = "inclusive" 
vim.opt.mouse = "a" 
vim.opt.clipboard:append("unnamedplus") 
vim.opt.modifiable = true 
vim.opt.encoding = "utf-8" 


vim.opt.foldmethod = "expr" 
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" 
vim.opt.foldlevel = 99 

vim.opt.splitbelow = true 
vim.opt.splitright = true 

vim.opt.wildmenu = true 
vim.opt.wildmode = "longest:full,full" 
vim.opt.diffopt:append("linematch:60") 
vim.opt.redrawtime = 10000 
vim.opt.maxmempattern = 20000 

-- ============================================================================
-- STATUSLINE
-- ============================================================================

local cached_branch = ""
local last_check = 0
local function git_branch()
	local now = vim.loop.now()
	if now - last_check > 5000 then 
		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
		last_check = now
	end
	if cached_branch ~= "" then
		return " \u{e725} " .. cached_branch .. " " 
	end
	return ""
end


local function file_type()
	local ft = vim.bo.filetype
	local icons = {
		lua = "\u{e620} ", 
		python = "\u{e73c} ", 
		javascript = "\u{e74e} ", 
		typescript = "\u{e628} ", 
		html = "\u{e736} ", 
		css = "\u{e749} ", 
		json = "\u{e60b} ", 
		markdown = "\u{e73e} ", 
		vim = "\u{e62b} ", 
		sh = "\u{f489} ", 
		bash = "\u{f489} ",
		zsh = "\u{f489} ",
		rust = "\u{e7a8} ", 
		go = "\u{e724} ", 
		c = "\u{e61e} ", 
		cpp = "\u{e61d} ", 
		sql = "\u{e706} ",
		yaml = "\u{f481} ",
		toml = "\u{e615} ",
		xml = "\u{f05c} ",
		dockerfile = "\u{f308} ", 
		gitcommit = "\u{f418} ", 
		gitconfig = "\u{f1d3} ", 
	}

	if ft == "" then
		return " \u{f15b} " 
	end

    local icon = icons[ft] or "\u{f15b}" 
    return icon .. "" 
end



local function mode_icon()
	local mode = vim.fn.mode()
	local modes = {
		n = " \u{f121}  NORMAL",
		i = " \u{f11c}  INSERT",
		v = " \u{f0168} VISUAL",
		V = " \u{f0168} V-LINE",
		["\22"] = " \u{f0168} V-BLOCK",
		c = " \u{f120} COMMAND",
		s = " \u{f0c5} SELECT",
		S = " \u{f0c5} S-LINE",
		["\19"] = " \u{f0c5} S-BLOCK",
		R = " \u{f044} REPLACE",
		r = " \u{f044} REPLACE",
		["!"] = " \u{f489} SHELL",
		t = " \u{f120} TERMINAL",
	}
	return modes[mode] or (" \u{f059} " .. mode)
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])


local function setup_dynamic_statusline()
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			vim.opt_local.statusline = table.concat({
				"  ",
				"%#StatusLineBold#",
				"%{v:lua.mode_icon()}",
				"%#StatusLine#",
				" \u{e0b1} ", 
				"%{v:lua.file_type()} %f %h%m%r",
				"\u{e0b1}", 
				"%{v:lua.git_branch()}",
				"%=", 
				"%l:%c  %P ", 
			})
		end,
	})
	vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = "  %f %h%m%r \u{e0b1} %{v:lua.file_type()} %=  %l:%c   %P "
		end,
	})
end

setup_dynamic_statusline()

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " " 
-- vim.g.maplocalleader = " " 

vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

--miscSrtcts
vim.keymap.set('n', '<leader>q', function() 
    vim.fn.setreg( '+', vim.fn.expand('%:p')) 
    vim.notify("Copied path to clipboard!")
end, {desc = "get path for current file"})

vim.keymap.set('n', '<leader>ww', '<cmd>set wrap!<CR>', {desc = "Toggle wrap", silent = true, noremap = true})
vim.keymap.set('i', 'pp', '<Esc>', {desc = "Escape insert mode", noremap = true})
vim.keymap.set('n', '<C-c>', ':nohlsearch<CR>', {silent = true, desc = "Clear search highlights"})
vim.keymap.set('n', '<leader>fN', ':e %:p:h/', {desc = "Edit new file in current directory"})
vim.keymap.set('n', '<C-s>', ':w<CR>', {desc = "Save file"})

--movement
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

--travel between buffers
vim.keymap.set('n', '<C-x>', ':bdelete!<CR>', {silent = true, desc = "Close Current Tab"})
vim.keymap.set('n', '<leader><tab>', ':bnext<CR>', {silent = true, desc = "Next Tab"})
vim.keymap.set('n', '<S-tab>', ':bprevious<CR>', {silent = true, desc = "Previous Tab"})
vim.keymap.set('n', '<tab>', ':bnext<CR>', {silent = true, desc = "Next Tab"})

--selection
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })


local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Format on save (ONLY real file buffers, ONLY when efm is attached)
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = {
		"*.lua",
		"*.py",
		"*.go",
		"*.js",
		"*.ts",
		"*.json",
		"*.css",
		"*.html",
		"*.sh",
		"*.bash",
		"*.zsh",
		"*.c",
		"*.cpp",
	},
	callback = function(args)
		-- avoid formatting non-file buffers (helps prevent weird write prompts)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		if not vim.bo[args.buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(args.buf) == "" then
			return
		end

		local has_efm = false
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.name == "efm" then
				has_efm = true
				break
			end
		end
		if not has_efm then
			return
		end

		pcall(vim.lsp.buf.format, {
			bufnr = args.buf,
			timeout_ms = 2000,
			filter = function(c)
				return c.name == "efm"
			end,
		})
	end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================
vim.pack.add({
	"https://www.github.com/lewis6991/gitsigns.nvim",
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/nvim-tree/nvim-tree.lua",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/antosha417/nvim-lsp-file-operations",
  "https://github.com/christoomey/vim-tmux-navigator",
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end
packadd("nvim-treesitter")
packadd("gitsigns.nvim")
packadd("mini.nvim")
packadd("fzf-lua")
packadd("nvim-tree.lua")
packadd("nvim-web-devicons")
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("blink.cmp")
packadd("nvim-cmp")
packadd("LuaSnip")
packadd("nvim-lsp-file-operations")
packadd("vim-tmux-navigator")

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

--Treesitter
local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
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
    "zig",
	}

	local config = require("nvim-treesitter.config")

	local already_installed = config.get_installed()
	local parsers_to_install = {}

	for _, parser in ipairs(ensure_installed) do
		if not vim.tbl_contains(already_installed, parser) then
			table.insert(parsers_to_install, parser)
		end
	end

	if #parsers_to_install > 0 then
		treesitter.install(parsers_to_install)
	end

	local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

setup_treesitter()

-- NvimTree 
require("nvim-tree").setup({
  view = {
    width = 40,
    relativenumber = true,
  },
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

-- NvimTree Keymap
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

-- fzf
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


-- require("mini.comment").setup({})
-- require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})

require("gitsigns").setup({
	signs = {
		add = { text = "\u{2590}" }, -- ▏
		change = { text = "\u{2590}" }, -- ▐
		delete = { text = "\u{2590}" }, -- ◦
		topdelete = { text = "\u{25e6}" }, -- ◦
		changedelete = { text = "\u{25cf}" }, -- ●
		untracked = { text = "\u{25cb}" }, -- ○
	},
	signcolumn = true,
	current_line_blame = true,
})
vim.keymap.set("n", "<leader>Gb", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline blame" })

cmd = {
  "TmuxNavigateLeft",
  "TmuxNavigateDown",
  "TmuxNavigateUp",
  "TmuxNavigateRight",
  "TmuxNavigatePrevious",
  "TmuxNavigatorProcessList",
}
keys = {
  { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
  { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
  { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
  { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  { "<C-p>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
}

-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
config = function()
  -- import cmp-nvim-lsp plugin
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  local keymap = vim.keymap -- for conciseness
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf, silent = true }

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "¡D", "<cmd>FzfLua diagnostics_workspace<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "¡d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "¿¿", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "¡¡", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end,
  })

  -- used to enable autocompletion (assign to every lsp server config)
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
  virtual_text = true
  })

  vim.lsp.config("*", {
    capabilities = capabilities,
  })

---@class PluginLspOpts
opts = {
  servers = {
  terraformls = {},
  tflint = {},
  },
}

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
end


-- cmp
config = function()
  local cmp = require("cmp")

  local luasnip = require("luasnip")

  local lspkind = require("lspkind")

  -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,preview,noselect",
    },
    snippet = { -- configure how nvim-cmp interacts with snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-q>"] = cmp.mapping.abort(), -- close completion window
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    -- sources for autocompletion
    sources = cmp.config.sources({
      { name = "nvim_lsp"},
      { name = "luasnip" }, -- snippets
      { name = "buffer" }, -- text within current buffer
      { name = "path" }, -- file system paths
    }),

    -- configure lspkind for vs-code like pictograms in completion menu
    formatting = {
      format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
      }),
    },
  })
end

-- Mason
config = function()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_tool_installer = require("mason-tool-installer")
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  mason_lspconfig.setup({
    -- list of servers for mason to install
    ensure_installed = {
      "lua_ls",
      "pyright",
  "bashls",
  "gopls",
  "jsonls",
  "zls",
  "tflint",
  "rust_analyzer"
    },
  })

  mason_tool_installer.setup({
    ensure_installed = {
      "prettier", -- prettier formatter
      "stylua", -- lua formatter
      "isort", -- python formatter
      "black", -- python formatter
      "pylint",
  "goimports",
  "gotests",
  "terraform",
  "terraform-ls",
  "llm-ls",
    },
  })
end
