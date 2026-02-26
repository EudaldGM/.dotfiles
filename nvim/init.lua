require("eudaldgm")

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

