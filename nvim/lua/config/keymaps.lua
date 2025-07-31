-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- ~/.config/nvim/lua/config/keymaps.lua

-- Existing Keymaps (from previous interactions, keep them or adjust as needed)
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit Neovim" })
vim.keymap.set("n", "<leader>Q", ":quit!<CR>", { desc = "Quit Neovim (Force)" })
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and Quit Neovim" })
vim.keymap.set("n", "<leader>ss", ":write<CR>", { desc = "Save File" })

-- Buffer Navigation (Leader + 1-9, and Leader + 0 for buffer 10)
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go to Buffer " .. i })
end
vim.keymap.set("n", "<leader>0", ":BufferLineGoToBuffer 10<CR>", { desc = "Go to Buffer 10" })

-- Window Movement (Shift + Arrow Keys)
-- These use default Neovim commands for moving windows
vim.keymap.set("n", "<S-Up>", "<C-W>K", { desc = "Move Window Up" })
vim.keymap.set("n", "<S-Down>", "<C-W>J", { desc = "Move Window Down" })
vim.keymap.set("n", "<S-Left>", "<C-W>H", { desc = "Move Window Left" })
vim.keymap.set("n", "<S-Right>", "<C-W>L", { desc = "Move Window Right" })

-- Change Focus Between Windows (Shift + Tab for clockwise)
-- This maps to the default Neovim command for cycling windows.
-- Note: <C-w>w cycles through windows in "natural" order (usually clockwise).
vim.keymap.set("n", "<S-Tab>", "<C-W>w", { desc = "Cycle Windows (Clockwise)" })
vim.keymap.set("i", "<S-Tab>", "<Esc><C-W>w", { desc = "Cycle Windows (Clockwise)", remap = true }) -- Also in insert mode

-- Keybinding to open terminal in a vertical split with the current file's directory
vim.keymap.set("n", "<leader>t", function()
  -- Get the directory of the current file
  local current_file_dir = vim.fn.expand("%:p:h")
  -- If there's no file (e.g., new buffer), fall back to the current working directory
  local cwd = current_file_dir ~= "" and current_file_dir or vim.fn.getcwd()
  -- Open a vertical split and start a terminal in the correct directory
  vim.cmd("vsplit | lcd " .. cwd .. " | term")
  -- Optional: Switch to insert mode in the terminal for immediate typing
  vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Open terminal in vertical split with current file dir" })
