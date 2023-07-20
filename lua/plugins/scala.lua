return {
  "scalameta/nvim-metals",
  dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
  ft = { "scala", "sbt" },
  event = "BufEnter *.worksheet.sc",
  config = function()
    local api = vim.api
    ----------------------------------
    -- OPTIONS -----------------------
    ----------------------------------
    -- global
    vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
    vim.opt_global.shortmess:remove("F")
    vim.opt_global.shortmess:append("c")
    -- LSP Setup ---------------------
    ----------------------------------
    local metals_config = require("metals").bare_config()

    -- Example of settings
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
      superMethodLensesEnabled = true,
      showImplicitConversionsAndClasses = true,
    }

    -- *READ THIS*
    -- I *highly* recommend setting statusBarProvider to true, however if you do,
    -- you *have* to have a setting to display this in your statusline or else
    -- you'll not see any messages from metals. There is more info in the help
    -- docs about this
    metals_config.init_options.statusBarProvider = "on"

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Debug settings if you're using nvim-dap
    local dap = require("dap")

    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "RunOrTest",
        metals = {
          runType = "runOrTestFile",
          --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
        },
      },
      {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
          runType = "testTarget",
        },
      },
    }

    metals_config.on_attach = function(client, bufnr)
      local metals = require("metals")
      metals.setup_dap()

      local wk = require("which-key")
      wk.register({
        ["<localleader>"] = {
          h = {
            name = "hover",
            c = {
              function()
                metals.toggle_setting("showImplicitConversionsAndClasses")
              end,
              "Toggle show implicit conversions and classes",
            },
            i = {
              function()
                metals.toggle_setting("showImplicitArguments")
              end,
              "Toggle show implicit arguments",
            },
            t = {
              function()
                metals.toggle_setting("showInferredType")
              end,
              "Toggle show inferred type",
            },
          },
          t = {
            name = "Tree view",
            t = {
              function()
                require("metals.tvp").toggle_tree_view()
              end,
              "Toggle tree view",
            },
            r = {
              function()
                require("metals.tvp").reveal_in_tree()
              end,
              "Review in tree view",
            },
          },
          w = {
            function()
              metals.hover_worksheet({ border = "single" })
            end,
            "Hover worksheet",
          },
        },
      }, {
        buffer = bufnr,
      })
      wk.register({
        ["<localleader>t"] = {
          function()
            metals.type_of_range()
          end,
          "Type of range",
        },
      }, {
        mode = "v",
        buffer = bufnr,
      })
    end

    require("metals").initialize_or_attach(metals_config)
  end,
}
