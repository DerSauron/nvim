vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
        vim.cmd [[
            set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
        ]]
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "term://*" },
    callback = function()
        vim.cmd "startinsert!"
        vim.cmd "set cmdheight=1"
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
