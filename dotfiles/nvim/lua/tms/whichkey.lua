local which_key = require("which-key")

which_key.setup {
    spelling = {
        enabled = true,
        suggestions = 20,
    }
}

-- TOOD: Continue new keymaps here
which_key.register({
    ["<Leader>"] = { "<CMD>Telescope git_files<CR>", "Fuzzy File Search" },
    ["<ESC>"] = { ":q<CR>", "Exit" },
    s = { ":wr<CR>", "Save" },
    e = {
        name = "Editor",
        cc = { ":ColorizerToggle<CR>", "Toggle Colourizer" },
        cp = { ":PickColor<CR>", "Colour Picker" },
        n = { "<CMD>lua require('todo-comments').jump_next()<CR>", "Next TODO" },
        p = { "<CMD>lua require('todo-comments').jump_prev()<CR>", "Prev TODO" },
        t = { ":TodoTelescope<CR>", "Telescope TODO" },
        q = { ":TodoQuickFix<CR>", "Quickfix TODO" },
        e = { ":TroubleToggle<CR>", "Code Analysis" },
        gd = { ":DiffviewOpen<CR>", "Open Diff" },
        gc = { ":DiffviewClose<CR>", "Close Diff" },
    },
    t = {
        name = "Terminal",
        t = { ":FloatermToggle<CR>", "Toggle Terminal" },
        n = { ":FloatermNew --name=node node<CR>", "Node Repl" },
        d = { ":FloatermNew --name=deno deno<CR>", "Deno Repl" },
        p = { ":FloatermNew --name=python python<CR>", "Python Repl" },
        k = { ":FloatermKill<CR>", "Close Terminal" },
        ["["] = { ":FloatermPrev<CR>", "Previous Terminal" },
        ["]"] = { ":FloatermNext<CR>", "Next Terminal" }
    },
    w = {
        name = "Window",
        h = { ":tabp<CR>", "Prev Tab" },
        l = { ":tabn<CR>", "Next Tab" },
        n = { ":tabnew<CR>", "New Tab" },
        s = { ":ScratchPad<CR>", "Scratch Pad" }
    },
    f = {
        name = "File",
        f = { "<CMD>Telescope find_files<CR>", "Fuzzy File Search" },
        r = { "<CMD>Telescope oldfiles<CR>", "Open Recent File" },
        g = { "<CMD>Telescope live_grep<CR>", "Grep Search Files" },
        t = { "<CMD>Telescope file_browser<CR>", "Show File Browser" },
        b = { "<CMD>Telescope buffers<CR>", "Show Buffers" },
        e = { "<CMD>Sexplore<CR>", "File Explorer" },
    },
    l = {
        name = "LSP",
        f = { "<CMD>lua vim.diagnostic.open_float()<CR>", "Show Diagnostics" },
        n = { "<CMD>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
        p = { "<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
        g = {
            name = "Goto",
            d = { require('telescope.builtin').lsp_definitions, "[G]oto [D]efinition" },
            r = { require('telescope.builtin').lsp_references, "[G]oto [R]eferences" },
            i = { require('telescope.builtin').lsp_implementations, "[G]oto [I]mplementations" },
        },
        s = {
            name = "Symbols",
            d = { require('telescope.builtin').lsp_document_symbols, "[S]ymbols in [D]ocument" },
            w = { require('telescope.builtin').lsp_dynamic_workspace_symbols, "[S]ymbols in [W]orkspace" },
        },
        q = { "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
        r = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
        a = { "<CMD>lua vim.lsp.buf.references()<CR>", "References" },
        h = { "<CMD>lua vim.lsp.buf.hover()<CR>", "Hover" },
        c = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        l = {
            name = "Server",
            i = { ":LspInfo<CR>", "LSP Info" },
            r = { ":LspRestart<CR>", "LSP Restart Server" }
        }
    },
}, { prefix = "<Leader>" })
