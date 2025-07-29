-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load custom folder scripts
local custom_path = vim.fn.stdpath('config') .. '/lua/custom'
package.path = package.path .. ';' .. custom_path .. '/?.lua'

-- Require output.lua (or image_display.lua if you named it that)
pcall(require, 'custom.output')

for _, file in ipairs(vim.fn.glob(custom_path .. '/*.lua', true, true)) do
    local module = file:match("^.+/(.+)%.lua$")
    pcall(require, 'custom.' .. module)
    end
