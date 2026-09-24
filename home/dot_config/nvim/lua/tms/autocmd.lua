vim.api.nvim_create_autocmd('FileType', {
    pattern = { 
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
