-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("i", "<C-v>", "<C-r><C-p>+", { desc = "Paste in Insert Mode" })

if vim.loop.os_uname().sysname == "Linux" then
  vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
  vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
end
