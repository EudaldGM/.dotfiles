-- Replace blink.cmp with this nvim-cmp configuration
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
	local allowed_filetypes = { 'go', 'python', 'lua', 'yaml', 'terraform', 'tf', 'zig', 'sql'}
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
			luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
	  enabled = function()
		return vim.tbl_contains(allowed_filetypes, vim.bo.filetype)
	  end,

      -- Key mappings for completion
      mapping = cmp.mapping.preset.insert({

        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Manually trigger a completion from nvim-cmp.
        ['<C-space>'] = cmp.mapping.complete({}),

       -- Enter key accepts completion
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),

        -- Tab and Shift-Tab for navigation
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),

      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
      },
    })
  end,
}
