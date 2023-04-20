return require('packer').startup(function(use)
    --  == Plugins ==

    -- Packer
    use 'wbthomason/packer.nvim'

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = {
            {
                "williamboman/mason.nvim",
                config = function() require('mason').setup() end,
                run = ":MasonUpdate"
            },
            { "williamboman/mason-lspconfig.nvim" },
            { "j-hui/fidget.nvim",                        config = function() require("fidget").setup() end },
            { "folke/neodev.nvim" },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' }
        }
    }

    -- GCC
    use {
        'terrortylor/nvim-comment',
        config = function() require('nvim_comment').setup() end
    }

    -- Open Close Brackets
    use 'rstacruz/vim-closer'

    -- Use % to goto start / end of definitions / groups
    use { 'andymass/vim-matchup', event = 'VimEnter' }

    -- Vim ALE
    use {
        'w0rp/ale',
        ft = {
            'bash',
            'html',
            'markdown',
            'python',
            'rust',
            'vim',
            'zsh',
        },
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }

    -- Completion
    -- May need to run :COQdeps to install dependencies
    -- Run :COQnow to start it
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        run = ':COQnow --shut-up'
    }

    -- Syntax tree parser
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "python",
                    "rust",
                    "lua",
                    "vim"
                },
                highlight = {
                    enable = true
                }
            }
        end
    }

    -- Vim Tree
    use {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require('nvim-tree').setup {}
        end
    }

    -- Inline GitBlame
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 500
                },
                signs = {
                    change = { text = '~' },
                    delete = { text = '_' }
                }
            }
        end
    }

    -- Indent line guides
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("indent_blankline").setup {
                char = '┊',
                show_trailing_blankline_ident = true
            }
        end
    }


    -- Theme
    use {
        "navarasu/onedark.nvim",
        config = function()
            require('onedark').setup {
                style = "darker",
                transparent = true,
                code_style = {
                    comments = "none"
                }
            }
            vim.cmd.colorscheme 'onedark'
        end
    }

    -- Lua Line
    use {
        "nvim-lualine/lualine.nvim",
        require = { "nvim-tree/nvim-web-devicons" },
        -- opt = true,
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'onedark'
                }
            }
        end
    }

    -- Indent Detection --
    use { 'tpope/vim-sleuth' }

    -- Fuzzy Finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    }

    -- Rust Debugger
    use { 'simrat39/rust-tools.nvim' }

    -- Improved Hover
    use { "ray-x/lsp_signature.nvim" }

    -- Spell Checker
    use { "jose-elias-alvarez/null-ls.nvim" }
end)
