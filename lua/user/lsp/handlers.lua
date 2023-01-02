local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
  local icons = require "user.icons"
  local signs = {

    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_lines = false,
    virtual_text = false,
    -- virtual_text = {
    --   -- spacing = 7,
    --   -- update_in_insert = false,
    --   -- severity_sort = true,
    --   -- prefix = "<-",
    --   prefix = " ●",
    --   source = "if_many", -- Or "always"
    --   -- format = function(diag)
    --   --   return diag.message .. "blah"
    --   -- end,
    -- },

    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      -- border = {"▄","▄","▄","█","▀","▀","▀","█"},
      source = "if_many", -- Or "always"
      header = "",
      prefix = "",
      -- width = 40,
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })
end

local function lsp_keymaps(client, bufnr)
    local set_keymap = vim.api.nvim_buf_set_keymap

    local opts = { noremap = true, silent = true }

    set_keymap(bufnr, "n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
    set_keymap(bufnr, "n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
    -- set_keymap(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
    set_keymap(bufnr, "n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
    -- set_keymap(bufnr, "n", "<C-k>", "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- set_keymap(bufnr, "n", "<leader>rn", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
    -- set_keymap(bufnr, "n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", opts)
    -- set_keymap(bufnr, "n", "<leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
    -- set_keymap(bufnr, "n", "[d", "<CMD>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", opts)
    -- set_keymap(bufnr, "n", "]d", "<CMD>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", opts)
    -- set_keymap(bufnr, "n", "gl", "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<CR>", opts)

    if client.resolved_capabilities.document_formatting then
        set_keymap(bufnr, "n", "<C-f>", "<CMD>lua vim.lsp.buf.format({async = true})<CR>", opts)
    else
        set_keymap(bufnr, "n", "<C-f>", "<CMD>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Lsp finder find the symbol definition implement reference
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    set_keymap(bufnr, "n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

    -- Code action
    set_keymap(bufnr, "n", "<leader>ca", "<CMD>Lspsaga code_action<CR>", { silent = true })
    set_keymap(bufnr, "v", "<leader>ca", "<CMD><C-U>Lspsaga range_code_action<CR>", { silent = true })

    -- Rename
    set_keymap(bufnr, "n", "<Leader>rn", "<CMD>Lspsaga rename<CR>", { silent = true })

    -- Show line diagnostics
    -- set_keymap(bufnr, "n", "<leader>cd", "<CMD>Lspsaga show_line_diagnostics<CR>", { silent = true })

    -- Show cursor diagnostic
    set_keymap(bufnr, "n", "<leader>cd", "<CMD>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

    -- Diagnsotic jump can use `<c-o>` to jump back
    set_keymap(bufnr, "n", "[d", "<CMD>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
    set_keymap(bufnr, "n", "]d", "<CMD>Lspsaga diagnostic_jump_next<CR>", { silent = true })

    -- Outline
    set_keymap(bufnr, "n","<leader>o", "<CMD>LSoutlineToggle<CR>",{ silent = true })

    -- Hover Doc
    set_keymap(bufnr, "n", "K", "<CMD>Lspsaga hover_doc<CR>", { silent = true })
end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]],
        false)
    end
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(client, bufnr)
  lsp_highlight_document(client)
end

return M
