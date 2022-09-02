function _G.map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function _G.nmap(lhs, rhs, opts)
    map("n", lhs, rhs, opts)
end

function _G.imap(lhs, rhs, opts)
    map("i", lhs, rhs, opts)
end

function _G.vmap(lhs, rhs, opts)
    map("v", lhs, rhs, opts)
end

function _G.xmap(lhs, rhs, opts)
    map("x", lhs, rhs, opts)
end

function _G.tmap(lhs, rhs, opts)
    map("t", lhs, rhs, opts)
end

function _G.reload_config()
    for name,_ in pairs(package.loaded) do
        if name:match("^user%.") then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    print("Config reloaded")
end

function _G.close_all_buffers()
    local function filter(buffer)
        local valid = vim.api.nvim_buf_is_valid(buffer)
            and vim.api.nvim_buf_get_option(buffer, "buflisted")
        if not valid then return false end

        local exclude_names = { "NvimTree", "toggleterm" }
        local buffer_name = vim.api.nvim_buf_get_name()
        for _, n in ipairs(exclude_names) do
            if string.find(buffer_name, n) then return false end
        end

        return true
    end

    local buffers = vim.tbl_filter(filter, vim.api.nvim_list_bufs())

    for _, buffer in ipairs(buffers) do
        vim.api.nvim_buf_delete(buffer)
    end
end
