-- ========================================================= --
-- Tresitter Config
-- ========================================================= --
local ts = require('nvim-treesitter')

ts.install({
    'lua',
    'go',
    'rust',
    'python',
    'javascript',
    'typescript',
    'html',
    'css',
    'json'
}):wait(30000)
