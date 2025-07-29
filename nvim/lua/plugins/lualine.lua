-- ~/.config/nvim/lua/config/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto", -- Matches your gruvbox setup
      globalstatus = true, -- Single statusline
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = {
        function()
          local clients = vim.lsp.get_active_clients()
          local client_names = {}
          for _, client in pairs(clients) do
            table.insert(client_names, client.name)
          end
          return next(client_names) and "󰒍 LSP: " .. table.concat(client_names, ", ") or "󰒍 LSP not attached"
        end,
        "fileformat",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "location" },
    },
  },
}
