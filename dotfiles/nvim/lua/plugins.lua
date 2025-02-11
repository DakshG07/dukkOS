local plugins =  {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          mocha = {
            mantle = "#1e1e2e",
            crust = "#1e1e2e",
          },
        }
      })
    end,
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind.nvim',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Extra Language Servers
      'pmizio/typescript-tools.nvim'
    },
    config = function()
      local lsp = require('lsp-zero')
      local lspconfig = require('lspconfig')
      lsp.preset('lsp-compe')
      local enableInlay = function (client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
      lspconfig.rust_analyzer.setup({
        on_attach = enableInlay,
        settings = {
          ["rust-analyzer"] = {
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
            cargo = {
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true
            },
          },
        },
      })
      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
        lsp.buffer_autoformat()
      end)
      lsp.setup()
      local cmp = require('cmp')
      local cmp_config = lsp.defaults.cmp_config({
        window = {
          completion = cmp.config.window.bordered()
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50, symbol_map = { Copilot = "" }, })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"
            return kind
          end,
        },
        sources = {
          -- Copilot
          { name = "copilot" },
          -- Defaults
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'buffer', keyword_length = 3 },
          { name = 'luasnip', keyword_length = 2 },
        },
        mapping = {
          ['<tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end),
          ['<S-tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end),
          ['<CR>'] = cmp.mapping.confirm({select = false}),
        }
      })
      cmp.setup(cmp_config)
      require('mason').setup()
      require('typescript-tools').setup {}
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({
        with_sync = true
      })
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'go', 'python', 'lua', 'rust'},
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require("bufferline").setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
          diagnostics = "nvim_lsp"
        },
      })
      require('nvim-web-devicons').setup({
        override = {
          nim = {
            icon = "👑",
          }
        }
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          theme = "catppuccin"
        },
      })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    config = function()
      require('lspsaga').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup()
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        highlights = {
          Normal = {
            guibg = "#181825", -- Slightly darker background
          },
        },
        shade_terminals = false,
      })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup({
        indent = {
          char = "▏",
          highlight = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
          },
        }
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function() 
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = {
      'zbirenbaum/copilot.lua',
    },
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'alaviss/nim.nvim',
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
}
-- Install plugins
require("lazy").setup(plugins, {
  install = { colorscheme = { "catppuccin" } }
})
