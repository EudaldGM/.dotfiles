return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'rafamadriz/friendly-snippets',
    'tzachar/cmp-ai',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    --local cmp_ai = require('cmp_ai.config')

    local allowed_filetypes = { 'go', 'python', 'lua', 'yaml', 'terraform', 'tf', 'zig', 'sql', 'rust' }

    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup({})

    -- Configure cmp-ai for Ollama with debugging
    -- cmp_ai:setup({
    --   max_lines = 1000,
    --   provider = 'Ollama',
    --   provider_options = {
    --     model = 'codellama:7b-code',
    --     url = 'http://localhost:11434',
    --     -- Alternative models to try:
    --     -- model = 'deepseek-coder:6.7b',
    --     -- model = 'codeqwen:7b',
    --   },
    --   notify = true,
    --   notify_callback = function(msg)
    --     vim.notify("CMP-AI: " .. tostring(msg), vim.log.levels.INFO)
    --   end,
    --   run_on_every_keystroke = false,
    --   ignored_file_types = {
    --     -- file types to ignore
    --   },
    --   -- Add debug logging
    --   debug = true,
    -- })

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
      formatting = {
        format = function(entry, vim_item)
          local kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          }

          local menu_map = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            path = "[Path]",
            cmp_ai = "[AI]",
          }

          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or "", vim_item.kind)
          vim_item.menu = menu_map[entry.source.name] or ""

          -- Highlight AI suggestions differently
          if entry.source.name == 'cmp_ai' then
            vim_item.kind_hl_group = 'CmpItemKindAI'
          end

          return vim_item
        end,
      },
      -- Key mappings for completion
      mapping = cmp.mapping.preset.insert({
        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- Manually trigger a completion from nvim-cmp
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
      sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        --{ name = 'cmp_ai', priority = 900, max_item_count = 3 }, -- Limit AI suggestions
        { name = 'luasnip', priority = 800 },
        { name = 'path', priority = 700 },
        { name = 'buffer', priority = 600, max_item_count = 5 },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = true,
      },
    })

    vim.api.nvim_set_hl(0, 'CmpItemKindAI', { fg = '#00ff00', bold = true })
  end,
}
