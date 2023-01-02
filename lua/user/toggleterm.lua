local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup {
    size = 20,
    open_mapping = [[<m-0>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
}

local Terminal = require("toggleterm.terminal").Terminal

local float_term = Terminal:new {
    direction = "float",
    on_open = function(term)
        vim.cmd "startinsert!"
        vim.api.nvim_buf_set_keymap(
            term.bufnr,
            "n",
            "<C-\\>",
            "<CMD>1ToggleTerm direction=float<CR>",
            { noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
            term.bufnr,
            "t",
            "<C-\\>",
            "<CMD>1ToggleTerm direction=float<CR>",
            { noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
            term.bufnr,
            "i",
            "<C-\\>",
            "<CMD>1ToggleTerm direction=float<CR>",
            { noremap = true, silent = true }
        )
    end,
    count = 1,
}

function _FLOAT_TERM()
    float_term:toggle()
end

nmap("<C-\\>", "<CMD>lua _FLOAT_TERM()<CR>")
