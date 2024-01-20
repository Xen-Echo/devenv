-- ========================================================= --
-- Whitespace Settings
-- ========================================================= --

local hooks = require "ibl.hooks"

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }

-- ========================================================= --
-- Todo Comments
-- ========================================================= --

-- TODO: Test 
-- HACK: Test
-- BUG: Test
-- PERF: Test
-- NOTE: Test
-- WARNING: Test

require("todo-comments").setup {
    colors = {
        error = { "#E06C75" },
        warning = { "#E5C07B" },
        info = { "#61AFEF" },
        hint = { "#98C379" },
        default = {  "#61AFEF" },
        test = { "#C678DD" }
    }
}

-- ========================================================= --
-- Vim Illuminate
-- ========================================================= --

require('illuminate').configure()

-- ========================================================= --
-- Colour Picker
-- ========================================================= --

require("color-picker").setup()

-- ========================================================= --
-- Colorizer
-- ========================================================= --

require('colorizer').setup()

-- ========================================================= --
-- Trouble
-- ========================================================= --

require("trouble").setup()

-- ========================================================= --
-- Status Bar Config
-- ========================================================= --

require('lualine').setup()

-- ========================================================= --
-- ScratchPad Config
-- ========================================================= --

vim.g["scratchpad_autostart"] = 0

-- ========================================================= --
-- Floaterm
-- ========================================================= --

vim.g["floaterm_shell"] = "nu"
vim.g["floaterm_autoinsert"] = false

-- ========================================================= --
-- Surround Config
-- ========================================================= --

require("nvim-surround").setup()

-- ========================================================= --
-- Autoclose
-- ========================================================= --

require('nvim-ts-autotag').setup()
