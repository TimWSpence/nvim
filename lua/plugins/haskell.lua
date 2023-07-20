return {
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    branch = '1.x.x',
    ft = { "haskell" },
    config = function(_, _)
      local wk = require("which-key")
      local ht = require("haskell-tools")
      ht.setup({
        hls = {
          on_attach = function(client, bufnr)
            wk.register({
              ["<localleader>"] = {
                r = {
                  name = "Repl",
                  p = {
                    function()
                      ht.repl.toggle()
                    end,
                    "Current package"
                  },
                  b = {
                    function()
                      ht.repl.toggle(vim.api.nvim_buf_get_name(0))
                    end,
                    "Current buffer"
                  }
                },
                h = {
                  function()
                    ht.hoogle.hoogle_signature()
                  end,
                  "Hoogle"
                }
              },
            }, {
              buffer = bufnr,
            })
          end,
        },
      })
    end,
  },
}
