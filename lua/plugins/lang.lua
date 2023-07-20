return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "HiPhish/nvim-ts-rainbow2",
      },
    },
    opts = function(_, opts)
      vim.list_extend(
        opts.ensure_installed,
        { "c", "dhall", "elixir", "fennel", "haskell", "json", "markdown", "python", "racket", "rust", "scala", "yaml" }
      )
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gti",
          node_incremental = "gti",
          scope_incremental = false,
          node_decremental = "gtd",
        },
      }
    end,
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      local rainbow = require("ts-rainbow")
      opts.rainbow = {
        enable = true,
        query = "rainbow-parens",
        -- Highlight the entire buffer all at once
        strategy = rainbow.strategy.global,
      }
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
    end,
    opts = {
      servers = {
        clangd = {},
        clojure_lsp = {},
        dhall_lsp_server = {},
        fennel_language_server = {},
        pyright = {},
        racket_langserver = {},
        unison = {},
      },
      setup = {
        clangd = function(_, opts)
          require("lspconfig").clangd.setup({ opts })
        end,
        clojure_lsp = function(_, opts)
          require("lspconfig").clojure_lsp.setup({ opts })
        end,
        dhall_lsp_server = function(_, opts)
          require("lspconfig").dhall_lsp_server.setup({ opts })
        end,
        fennel_language_server = function(_, opts)
          require("lspconfig").fennel_language_server.setup({ opts })
        end,
        pyright = function(_, opts)
          require("lspconfig").pyright.setup({ opts })
        end,
        racket_langserver = function(_, opts)
          require("lspconfig").racket_langserver.setup({ opts })
        end,
        unison = function(_, opts)
          require("lspconfig").unison.setup({ opts })
        end,
      },
    },
  },
  {
    "amrbashir/nvim-docs-view",
    keys = {
      { "<leader>ck", "<cmd>DocsViewToggle<cr>", desc = "Toggle docs" },
    },
    cmd = "DocsViewToggle",
    config = function()
      require("docs-view").setup({
        position = "bottom",
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.diagnostics.clj_kondo,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.cljstyle,
          null_ls.builtins.formatting.fnlfmt,
          null_ls.builtins.formatting.joker,
          null_ls.builtins.formatting.isort,
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "clang-format",
        "clj-kondo",
        "isort",
        "joker",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      space_char_blankline = " ",
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      },
    }
  },
  { "andymass/vim-matchup" },
}
