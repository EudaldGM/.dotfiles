
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      {
        'whoissethdaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = {
            'lua_ls',
			'gopls',
			'htmx',
			-- 'pylsp',
			'black',
			'kube-linter',
			'terraform',
			'terraform-ls',
			'yamlls',
			'yamlfmt',
			'bashls',
			'just-lsp',
			'json-lsp',
			'helm-ls',
			'zls',
			'pgformatter',
			'postgrestools',
			'pylyzer',
			'pyrefly',
			'bacon',
          },
          auto_update = true,
        },
      },
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },

      config = function()
	  require('mason').setup()
      require('mason-lspconfig').setup()
	  -- Setup LSP capabilities for nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })


    end,
  },

}
