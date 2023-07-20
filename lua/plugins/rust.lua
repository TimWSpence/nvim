return {
  "simrat39/rust-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
  ft = { "rust" },
  config = function(_, opts)
    local settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          command = "cargo clippy",
          extraArgs = { "--no-deps" },
        },
      },
      on_attach = function(_, bufnr)
        local wk = require("which-key")
        wk.register({
          ["<localleader>"] = {
            d = {
              "<cmd>RustOpenExternalDocs<CR>",
              "Open docs for cursor"
            }
          },
        }, {
          buffer = bufnr,
        })
      end
    }

    require("rust-tools").setup({ server = settings })
  end,
}
