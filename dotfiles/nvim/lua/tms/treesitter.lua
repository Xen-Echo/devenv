-- ========================================================= --
-- Tresitter Config
-- ========================================================= --
local ts = require('nvim-treesitter')

ts.install({
    'lua',
    'go',
    'templ',
    'rust',
    'python',
    'javascript',
    'typescript',
    'html',
    'css',
    'json',
    'markdown'
}):wait(30000)
