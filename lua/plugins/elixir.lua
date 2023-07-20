return {
  "elixir-tools/elixir-tools.nvim",
  ft = { "elixir" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    elixir.setup {
      credo = {},
      elixirls = {
        enable = true,
        settings = elixirls.settings {
          dialyzerEnabled = false,
          enableTestLenses = false,
        },
        on_attach = function(client, bufnr)
        end,
      }
    }
  end,
}
