vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.formatting_sync(nil, 1000)
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 
        'lua',
        'go',
        'rust',
        'python',
        'javascript',
        'typescript',
        'html',
        'css',
        'json',
        'markdown'
    },
    callback = function() 
        vim.treesitter.start()
        local opt = vim.wo[0][0]
        opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        opt.foldmethod = 'expr'
        opt.foldlevel = 99
        opt.foldcolumn = '0'
        opt.foldtext = ""
    end,
})

