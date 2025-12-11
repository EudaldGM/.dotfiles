return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
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

	local util = require("lspconfig.util")

	vim.lsp.enable("zls", {
	  cmd = { "zls" },
	  filetypes = { "zig", "zir" },
	  root_dir = util.root_pattern("build.zig", ".git") or vim.loop.cwd(),
	  single_file_support = true,
	})
	vim.lsp.enable("gopls", {
	  settings = {
		gopls = {
		  analyses = {
			unusedparams = true,
		  },
		  staticcheck = true,
		  gofumpt = true,
		},
	  },
	})


	vim.api.nvim_create_autocmd("BufWritePre", {
	  pattern = "*.go",
	  callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = {only = {"source.organizeImports"}}
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
		  for _, r in pairs(res.result or {}) do
			if r.edit then
			  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
			  vim.lsp.util.apply_workspace_edit(r.edit, enc)
			end
		  end
		end
		vim.lsp.buf.format({async = false})
	  end
	})
	vim.api.nvim_set_hl(0, "@lsp.type.comment", { link = "@comment" })
	vim.api.nvim_set_hl(0, "@lsp.comment", { link = "@comment" })

  end,
}
