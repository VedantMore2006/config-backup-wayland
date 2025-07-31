-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- ~/.config/nvim/lua/config/keymaps.lua

-- Existing Keymaps (from previous interactions, keep them or adjust as needed)
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit Neovim" })
vim.keymap.set("n", "<leader>Q", ":quit!<CR>", { desc = "Quit Neovim (Force)" })
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and Quit Neovim" })
vim.keymap.set("n", "<leader>ss", ":write<CR>", { desc = "Save File" })

-- ~/.config/nvim/init.lua or lua/keybindings.lua

-- IMPORTANT: These mappings will ONLY work if nvim-cmp
-- or your completion plugin detects them and uses them for navigation.
-- nvim-cmp specifically uses its own 'mapping' table for these,
-- so direct global mappings like these might be overridden or not used
-- by the completion plugin itself for list navigation.

-- 1. Tab to accept the selected auto-suggestion
-- This mapping assumes your completion plugin is set up to accept
-- on <Tab> or will use a common completion action.
-- In nvim-cmp, this is typically handled within its own mapping.
-- This general 'insert mode' mapping will just insert a tab if no completion is active.
vim.api.nvim_set_keymap("i", "<Tab>", "<C-y>", { noremap = true, silent = true, desc = "Accept Completion" })
-- <C-y> is the standard Vim command to accept the currently displayed completion.
-- This is a generic way, but nvim-cmp often has more sophisticated handling for <Tab>.

-- 2. Shift-Tab to go down in the auto-suggestion list
-- As explained, plain 'Shift' cannot be mapped. '<S-Tab>' is the combination.
vim.api.nvim_set_keymap(
  "i",
  "<S-Tab>",
  "<C-n>",
  { noremap = true, silent = true, desc = "Next Completion Item (Down)" }
)
-- <C-n> is the standard Vim command to go to the next completion item.

-- Optional: Shift-J for down, Shift-K for up (more Vim-like for navigation)
-- vim.api.nvim_set_keymap('i', '<S-j>', '<C-n>', { noremap = true, silent = true, desc = 'Next Completion Item (Shift-J)' })
-- vim.api.nvim_set_keymap('i', '<S-k>', '<C-p>', { noremap = true, silent = true, desc = 'Previous Completion Item (Shift-K)' })

-- Add descriptions for better discoverability with plugins like 'which-key'

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
