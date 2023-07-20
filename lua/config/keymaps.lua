-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<leader>wm", "<C-W>o", { desc = "Maximize", remap = true })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Maximize", remap = true })
map("n", "<leader>gf", "<cmd>0Gclog<CR>", { desc = "File history" })
map("n", "<leader>gF", "<cmd>Telescope git_bcommits<CR>", { desc = "Telescope file history" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Branches" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Status" })
map("n", "<leader>gS", "<cmd>Telescope git_stash<CR>", { desc = "Stashes" })
map("n", "<leader>gg", "<cmd>G<CR>", { desc = "Fugitive" })
map("n", "<leader>gB", "<cmd>Git blame<CR>", { desc = "Blame" })
map("v", "<leader>gB", ":Git blame<CR>", { desc = "Blame" })
map("n", "<leader>:", "<cmd>Telescope commands<cr>", { desc = "Commands" })
map("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
