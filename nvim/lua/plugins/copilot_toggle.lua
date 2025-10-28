return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
     --   event = "InsertEnter", -- Load on InsertEnter to delay until needed
        opts = {
            suggestion = {
                enabled = false, -- Disable suggestions by default
                auto_trigger = false, -- No auto-trigger until toggled on
                hide_during_completion = vim.g.ai_cmp,
                keymap = {
                    accept = false, -- Handled by nvim-cmp / blink.cmp
                    next = "<M-]>",
                    prev = "<M-[>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
        keys = {
            {
                "<leader>cc",
                function()
                local any_component_loaded = false
                local status_message = ""

                -- Toggle core Copilot (copilot.lua)
                if package.loaded["copilot"] then
                    vim.cmd("Copilot toggle")
                    any_component_loaded = true
                    status_message = vim.g.copilot_enabled == 0 and "disabled 😴" or "enabled 🚀"
                    end

                    -- Toggle copilot-cmp (for nvim-cmp)
                    if package.loaded["copilot_cmp"] and package.loaded["cmp"] then
                        local cmp = require("cmp")
                        local sources = cmp.get_config().sources or {}
                        local copilot_source_index = nil
                        for i, source in ipairs(sources) do
                            if source.name == "copilot" then
                                copilot_source_index = i
                                break
                                end
                                end
                                if copilot_source_index then
                                    -- Remove copilot source to disable
                                    table.remove(sources, copilot_source_index)
                                    status_message = "disabled 😴"
                                    else
                                        -- Add copilot source back to enable
                                        table.insert(sources, 1, { name = "copilot", group_index = 1, priority = 100 })
                                        status_message = "enabled 🚀"
                                        end
                                        cmp.setup({ sources = sources })
                                        any_component_loaded = true
                                        end

                                        -- Toggle blink-cmp-copilot (for blink.cmp)
                                        if package.loaded["blink-cmp-copilot"] and package.loaded["blink.cmp"] then
                                            local blink_cmp = require("blink.cmp")
                                            -- Check if blink.cmp has a config or sources table
                                            local config = blink_cmp.config or { sources = { default = {}, providers = {} } }
                                            local providers = config.sources and config.sources.providers or {}
                                            local copilot_provider_index = nil
                                            for i, provider in ipairs(providers) do
                                                if provider.name == "copilot" then
                                                    copilot_provider_index = i
                                                    break
                                                    end
                                                    end
                                                    if copilot_provider_index then
                                                        -- Remove copilot provider to disable
                                                        table.remove(providers, copilot_provider_index)
                                                        status_message = "disabled 😴"
                                                        else
                                                            -- Add copilot provider back to enable
                                                            table.insert(providers, {
                                                                name = "copilot",
                                                                module = "blink-cmp-copilot",
                                                                kind = "Copilot",
                                                                score_offset = 100,
                                                                async = true,
                                                            })
                                                            status_message = "enabled 🚀"
                                                            end
                                                            -- Update blink.cmp config
                                                            blink_cmp.setup({ sources = { providers = providers } })
                                                            any_component_loaded = true
                                                            end

                                                            -- Show feedback
                                                            if any_component_loaded then
                                                                print("Copilot " .. status_message)
                                                                else
                                                                    print("No Copilot components loaded 🤔")
                                                                    end
                                                                    end,
                                                                    mode = "n",
                                                                    desc = "Toggle Copilot and integrations",
            },
        },
    },
}
