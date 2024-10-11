local which_key = require("which-key")

which_key.setup {
    spelling = {
        enabled = true,
        suggestions = 20,
    }
}

-- Simple function to check if the current directory is a git repo
local function check_if_git_repo()
    local git_dir = vim.fn.finddir(".git/.", ";")
    if git_dir ~= "" then
        return true
    else
        return false
    end
end

-- Function to get the default file browser, fall back to find_files if not in a git repo
local function get_default_file_browser()
    if check_if_git_repo() then
        return ":Telescope git_files<CR>"
    else
        return ":Telescope find_files<CR>"
    end
end

-- Function to ask copilot for a quick chat
local function copilot_quick_chat()
    local input = vim.fn.input("Copilot Query: ")
    if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
    end
end

which_key.add({
    { "<Leader><ESC>",    ":q<CR>",                                                                desc = "Exit" },
    { "<Leader><Leader>", get_default_file_browser(),                                              desc = "File Search" },
    { "<Leader>c",        group = "Copilot" },
    { "<Leader>cc",       ":Copilot<CR>",                                                          desc = "Copilot" },
    { "<Leader>cq",       copilot_quick_chat,                                                      desc = "Copilot Question" },
    { "<Leader>e",        group = "Editor" },
    { "<Leader>ecc",      ":ColorizerToggle<CR>",                                                  desc = "Toggle Colourizer" },
    { "<Leader>ecp",      ":PickColor<CR>",                                                        desc = "Colour Picker" },
    { "<Leader>ee",       ":TroubleToggle<CR>",                                                    desc = "Code Analysis" },
    { "<Leader>egc",      ":DiffviewClose<CR>",                                                    desc = "Close Diff" },
    { "<Leader>egd",      ":DiffviewOpen<CR>",                                                     desc = "Open Diff" },
    { "<Leader>en",       "<CMD>lua require('todo-comments').jump_next()<CR>",                     desc = "Next TODO" },
    { "<Leader>ep",       "<CMD>lua require('todo-comments').jump_prev()<CR>",                     desc = "Prev TODO" },
    { "<Leader>eq",       ":TodoQuickFix<CR>",                                                     desc = "Quickfix TODO" },
    { "<Leader>et",       ":TodoTelescope<CR>",                                                    desc = "Telescope TODO" },
    { "<Leader>f",        group = "File" },
    { "<Leader>fb",       "<CMD>Telescope buffers<CR>",                                            desc = "Show Buffers" },
    { "<Leader>fe",       "<CMD>Sexplore<CR>",                                                     desc = "File Explorer" },
    { "<Leader>ff",       "<CMD>Telescope find_files<CR>",                                         desc = "Fuzzy File Search" },
    { "<Leader>fg",       "<CMD>Telescope live_grep<CR>",                                          desc = "Grep Search Files" },
    { "<Leader>fr",       "<CMD>Telescope oldfiles<CR>",                                           desc = "Open Recent File" },
    { "<Leader>ft",       "<CMD>Telescope file_browser<CR>",                                       desc = "Show File Browser" },
    { "<Leader>l",        group = "LSP" },
    { "<Leader>la",       "<CMD>lua vim.lsp.buf.references()<CR>",                                 desc = "References" },
    { "<Leader>lc",       "<CMD>lua vim.lsp.buf.code_action()<CR>",                                desc = "Code Action" },
    { "<Leader>lf",       "<CMD>lua vim.diagnostic.open_float()<CR>",                              desc = "Show Diagnostics" },
    { "<Leader>lg",       group = "Goto" },
    { "<Leader>lgd",      ":lua require('telescope.builtin').lsp_definitions{}<CR>",               desc = "[G]oto [D]efinition" },
    { "<Leader>lgi",      ":lua require('telescope_builtin').lsp_implementations{}<CR>",           desc = "[G]oto [I]mplementations" },
    { "<Leader>lgr",      ":lua require('telescope_builtin').lsp_references{}<CR>",                desc = "[G]oto [R]eferences" },
    { "<Leader>lh",       "<CMD>lua vim.lsp.buf.hover()<CR>",                                      desc = "Hover" },
    { "<Leader>ll",       group = "Server" },
    { "<Leader>lli",      ":LspInfo<CR>",                                                          desc = "LSP Info" },
    { "<Leader>llr",      ":LspRestart<CR>",                                                       desc = "LSP Restart Server" },
    { "<Leader>ln",       "<CMD>lua vim.lsp.diagnostic.goto_next()<CR>",                           desc = "Next Diagnostic" },
    { "<Leader>lp",       "<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>",                           desc = "Prev Diagnostic" },
    { "<Leader>lq",       "<CMD>lua vim.lsp.buf.signature_help()<CR>",                             desc = "Signature Help" },
    { "<Leader>lr",       "<CMD>lua vim.lsp.buf.rename()<CR>",                                     desc = "Rename" },
    { "<Leader>ls",       group = "Symbols" },
    { "<Leader>lsd",      ":lua require('telescope.builtin').lsp_document_symbols{}<CR>",          desc = "[S]ymbols in [D]ocument" },
    { "<Leader>lsw",      ":lua require('telescope.builtin').lsp_dynamic_workspace_symbols{}<CR>", desc = "[S]ymbols in [W]orkspace" },
    { "<Leader>s",        ":wr<CR>",                                                               desc = "Save" },
    { "<Leader>t",        group = "Terminal" },
    { "<Leader>t[",       ":FloatermPrev<CR>",                                                     desc = "Previous Terminal" },
    { "<Leader>t]",       ":FloatermNext<CR>",                                                     desc = "Next Terminal" },
    { "<Leader>tk",       ":FloatermKill<CR>",                                                     desc = "Close Terminal" },
    { "<Leader>tn",       ":FloatermNew<CR>",                                                      desc = "New Terminal" },
    { "<Leader>tt",       ":FloatermToggle<CR>",                                                   desc = "Toggle Terminal" },
    { "<Leader>w",        group = "Window" },
    { "<Leader>wh",       ":tabp<CR>",                                                             desc = "Prev Tab" },
    { "<Leader>wl",       ":tabn<CR>",                                                             desc = "Next Tab" },
    { "<Leader>wn",       ":tabnew<CR>",                                                           desc = "New Tab" },
    { "<Leader>ws",       ":ScratchPad<CR>",                                                       desc = "Scratch Pad" },
})
