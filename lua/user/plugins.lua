local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    -- snapshot = "july-24",
    snapshot_path = fn.stdpath "config" .. "/snapshots",
    max_jobs = 50,
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
        prompt_border = "rounded", -- Border style of prompt popups.
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- Plugin Mangager
    use { "wbthomason/packer.nvim" }

    -- Lua Development
    use { "nvim-lua/plenary.nvim" }
    use { "nvim-lua/popup.nvim" }

    -- LSP Auto installer
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }

    -- LSP
    use { "neovim/nvim-lspconfig" }
    use { "jose-elias-alvarez/null-ls.nvim" }
    use { "RRethy/vim-illuminate" }
    use { "ray-x/lsp_signature.nvim" }
    use { "glepnir/lspsaga.nvim" }
    use { "j-hui/fidget.nvim" }

    -- Completion
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-cmdline" }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-nvim-lua" }

    -- Snippet
    use { "L3MON4D3/LuaSnip" }
    use { "rafamadriz/friendly-snippets" }

    -- Syntax/Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
    end }
    use { "nvim-treesitter/nvim-treesitter-textobjects", after = 'nvim-treesitter' }
    use { "nvim-treesitter/playground" }
    use { "p00f/nvim-ts-rainbow" }

    -- Fuzzy Finder/Telescope
    use { "nvim-telescope/telescope.nvim" }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    -- Project
    use { "ahmedkhalf/project.nvim" }

    -- Helpers
    use { 'moll/vim-bbye' }

    -- Colorschemes
    use { "lunarvim/onedarker.nvim" }
    use { "lunarvim/darkplus.nvim" }

    -- Icon
    use { "kyazdani42/nvim-web-devicons" }

    -- Statusline
    use { "nvim-lualine/lualine.nvim" }

    -- File Explorer
    use { "kyazdani42/nvim-tree.lua" }

    -- Comment
    use { "numToStr/Comment.nvim" }

    -- Terminal
    use { "akinsho/toggleterm.nvim" }

    -- Git
    use { "lewis6991/gitsigns.nvim" }

    -- Editing Support
    use { "windwp/nvim-autopairs" }
    use { "tpope/vim-sleuth" }

    -- Indent
    use { "lukas-reineke/indent-blankline.nvim" }

    -- Keybinding
    use { "folke/which-key.nvim" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
