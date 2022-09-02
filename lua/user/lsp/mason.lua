local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
    return
end

local servers = {
    "cssls",
    "cssmodules_ls",
    "html",
    "jsonls",
    "sumneko_lua",
    "yamlls",
    "bashls",
    "clangd",
    "intelephense"
}

local settings = {
    ui = {
        border = "rounded",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

mason_lspconfig.setup_handlers({
    function(server_name)
        local handlers = require("user.lsp.handlers")

        local opts = {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
        }

        local ook, server_opts = pcall(require, "user.lsp.settings." .. server_name)
        if ook then
            opts = vim.tbl_deep_extend("force", server_opts, opts)
        end

        local eok, env_server_opts = pcall(require, "env.lsp." .. server_name)
        if eok then
            opts = vim.tbl_deep_extend("force", env_server_opts, opts)
        end

        lspconfig[server_name].setup(opts)
    end
})
