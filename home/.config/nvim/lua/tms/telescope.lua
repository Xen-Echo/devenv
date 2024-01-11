-- ========================================================= --
-- Telescope Config
-- ========================================================= --

-- Required for live_grep: https://github.com/BurntSushi/ripgrep
local telescope_actions = require "telescope.actions"
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<CR>"] = telescope_actions.select_vertical,
                ["<C-UP>"] = telescope_actions.preview_scrolling_up,
                ["<C-DOWN>"] = telescope_actions.preview_scrolling_down,
            },
            n = {
                ["<CR>"] = telescope_actions.select_vertical,
                ["<C-UP>"] = telescope_actions.preview_scrolling_up,
                ["<C-DOWN>"] = telescope_actions.preview_scrolling_down,
            }
        }
    },
    extensions = {
        file_browser = {
          theme = "ivy"
        },
    }
}

require("telescope").load_extension("file_browser")
