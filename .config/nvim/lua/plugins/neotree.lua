-- ~/.config/nvim/lua/plugins/neotree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Optional, for file icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Disable netrw to avoid conflicts
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Set up neo-tree with custom keymaps and settings
    require("neo-tree").setup({
      close_if_last_window = true, -- Close neo-tree if it's the last window
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          visible = false, -- Hidden files are hidden by default
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = { ".git", "node_modules" },
        },
        follow_current_file = {
          enabled = true, -- Auto-focus the current file
          leave_dirs_open = false,
        },
        use_libuv_file_watcher = true, -- Auto-refresh on file changes
        window = {
          position = "left",
          width = 30,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<C-f>"] = "filter_on_submit", -- Fuzzy find files with neo-tree's built-in filter
            ["a"] = { "add", config = { show_path = "relative" } }, -- Create file/dir
            ["d"] = "delete", -- Delete with confirmation
            ["r"] = "rename", -- Rename file/dir
            ["y"] = "copy_to_clipboard", -- Copy file/dir
            ["x"] = "cut_to_clipboard", -- Cut file/dir
            ["p"] = "paste_from_clipboard", -- Paste file/dir
            ["H"] = "toggle_hidden", -- Toggle hidden files (Shift+H)
            ["<C-p>"] = { "toggle_preview", config = { use_float = true } }, -- Preview in floating window
            ["s"] = { "toggle_preview", config = { use_float = true } }, -- Alternative preview key
          },
        },
      },
      window = {
        mappings = {
          --   ["j"] = "navigate_down", -- Navigate down
          --   ["k"] = "navigate_up", -- Navigate up
        },
      },
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function()
            -- Enable preview by default after neo-tree window is fully opened
            local state = require("neo-tree.sources.manager").get_state("filesystem")
            if state.tree then
              require("neo-tree.sources.filesystem.commands").toggle_preview({})
            end
          end,
        },
      },
    })

    -- Keymaps for opening neo-tree
    vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left dir=%:p:h<CR>", { desc = "Open Neo-tree in CWD" })
    vim.keymap.set("n", "<leader>E", ":Neotree filesystem reveal left dir=~<CR>", { desc = "Open Neo-tree in Home" })
  end,
}
