-- ~/.config/nvim/lua/custom/kitty_launch.lua

-- Function to launch a new Kitty tab or split in the current session
local function launch_kitty(mode)
-- Determine the command based on mode (tab or split)
local kitty_cmd = (mode == "split") and "new-window" or "new-tab"

-- Get the current Kitty socket from environment or fallback
local socket = os.getenv("KITTY_LISTEN_ON") or "unix:/tmp/kitty-socket"

-- Command to open a new tab/split in the current Kitty session
local cmd = {
    "kitty",
    "@",
    "--to=" .. socket,
    kitty_cmd,
    "--cwd=" .. vim.fn.getcwd(), -- Use current working directory
}

-- Execute the command
local status = vim.fn.system(table.concat(cmd, " "))

-- Fallback: Launch a new Kitty instance if remote control fails
if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({{"Failed to open Kitty " .. mode .. ". Launching new instance.", "WarningMsg"}}, true, {})
    vim.fn.jobstart({
        "kitty",
        "--detach",
        "--working-directory=" .. vim.fn.getcwd()
    }, { detach = true })
    end
    end

    -- Keybindings for tab and split
    vim.keymap.set("n", "<leader>kt", function() launch_kitty("tab") end, { noremap = true, silent = true, desc = "Launch Kitty tab" })
    vim.keymap.set("n", "<leader>ks", function() launch_kitty("split") end, { noremap = true, silent = true, desc = "Launch Kitty split" })
