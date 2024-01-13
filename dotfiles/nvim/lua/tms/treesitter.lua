-- ========================================================= --
-- Tresitter Config
-- ========================================================= --

require('nvim-treesitter.install').compilers = { 'zig' }
require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua" },
    auto_install = true,
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "Function Outer" },
                ["if"] = { query = "@function.inner", desc = "Function Inner" },
                ["ac"] = { query = "@class.outer", desc = "Class Outer" },
                ["ic"] = { query = "@class.inner", desc = "Class Inner" },
                ["ab"] = { query = "@block.outer", desc = "Block Inner"  },
                ["ib"] = { query = "@block.inner", desc = "Block Inner"  }
            },
            selection_modes = {
                ['@parameter.outer'] = 'v', -- Charwise
                ['@function.outer'] = 'V', -- Linewise
                ['@class.outer'] = '<c-v>', -- Blockwise
            },
            include_surrounding_whitespace = true,
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]s"] = { query = "@scope.outer", desc = "Next Scope Start" },
                ["]m"] = { query = "@function.outer", desc = "Next Method Start" },
            },
            goto_next_end = {
                ["]s"] = { query = "@scope.outer", desc = "Next Scope End" },
                ["]M"] = { query = "@function.outer", desc = "Next Method End" },
            },
            goto_previous_start = {
                ["[s"] = { query = "@scope.outer", desc = "Prev Scope Start" },
                ["[m"] = { query = "@function.outer", desc = "Prev Method Start" },
            },
            goto_previous_end = {
                ["[S"] = { query = "@scope.outer", desc = "Prev Scope End" },
                ["[M"] = { query = "@function.outer", desc = "Prev Method End" },
            }
        }
    },
}
