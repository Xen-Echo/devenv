-- ========================================================= --
-- Keybindings
-- ========================================================= --

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.copilot_no_tab_map = true

map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>")                     -- Clear Search
map("n", "<C-c>", ":y*<CR>")                                       -- Copy to Clipboard
map("v", "<C-c>", "\"*y")                                          -- Copy to Clipboard
map("n", "<C-s>", ":w<CR>")                                        -- Write Normal
map("i", "<C-s>", "<ESC>:w<CR>")                                   -- Write Insert
map("i", "<C-y>", "copilot#Accept(\"\\<CR>\")", { expr = true })   -- Copilot Accept
map("n", "<C-z>", ":u<CR>")                                        -- Undo Normal
map("i", "<C-z>", "<ESC>:u<CR>")                                   -- Undo Insert
map("n", "<C-a>", ":%y*<CR>")                                      -- Yank All
map("n", "<C-UP>", "<C-w><UP>")                                    -- Move Up
map("n", "<C-DOWN>", "<C-w><DOWN>")                                -- Move Down
map("n", "<C-RIGHT>", "<C-w><RIGHT>")                              -- Move Right
map("n", "<C-LEFT>", "<C-w><LEFT>")                                -- Move Left
map("n", "<C-M-l>", "<cmd>lua vim.lsp.buf.format()<CR>")           -- Reformat Code
map("n", "<M-CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>")       -- Reformat Code
map("t", "<ESC>", "<C-\\><C-n>")                                   -- Exit Terminal Mode
