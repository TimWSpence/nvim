return {"renerocksai/telekasten.nvim", dependencies = {"nvim-telescope/telescope.nvim"}, opts = {home = vim.fn.expand("~/dev/bucket/notes"), tag_notation = "yaml-bare"}, keys = {{"<leader>n", "<cmd>Telekasten panel<CR>", desc = "Notes"}}}