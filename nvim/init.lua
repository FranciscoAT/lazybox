--- ##########################################################
--- #                      ____        _                     #
--- #   /\  /\_____      _|___ \/\   /(_)_ __ ___  _ __ ___  #
--- #  / /_/ / _ \ \ /\ / / __) \ \ / / | '_ ` _ \| '__/ __| #
--- # / __  / (_) \ V  V / / __/ \ V /| | | | | | | | | (__  #
--- # \/ /_/ \___/ \_/\_/ |_____| \_/ |_|_| |_| |_|_|  \___| #
--- #                                                        #
--- ##########################################################
--
-- Heavily Derived from: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- +++ Leader +++
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- +++ Configurations +++
-- Common Configs
vim.wo.rnu = true
vim.wo.number = true
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 0


-- COQ Settings
vim.g.coq_settings = {
    ['auto_start'] = 'shut-up',
    ['display.pum.source_context'] = { '[', ']' },
    ['display.ghost_text.context'] = { '[ ', ' ]' },
    ['display.pum.kind_context'] = { ' ', ' ' }
}

--- ++ Custom Filetypes ---
vim.cmd [[autocmd BufRead,BufNewFile *.zsh-theme setfiletype zsh]]

-- +++ Load Plugins +++
require('plugins')

-- +++ Key Binds +++

-- Nvim Tree
vim.keymap.set('n', '<leader>o', "<cmd>NvimTreeToggle<CR>", { desc = 'Toggle Tree' })
vim.keymap.set('n', '<leader>O', "<cmd>NvimTreeFindFile<CR>", { desc = 'Find File in Tree' })

-- Telescope
vim.keymap.set('n', '<leader><leader>', "<cmd>Telescope oldfiles<CR>", { desc = 'Recent files' })
vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<CR>", { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<C-p>', "<cmd>Telescope find_files<CR>", { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<CR>", { desc = '[F]ind [G]rep' })

-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

-- Clipboard Copy-paste
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })

-- Clear Search
vim.keymap.set('n', '<CR>', ':noh<CR><CR>', { desc = 'Clear Search' })

-- Re-Source init.lua
vim.keymap.set('n', '<leader>S', '<cmd>source $MYVIMRC<CR>', { desc = 'Source init.lua' })

-- Tabs
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = 'Close Tab' })

-- Save
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })

-- LSP
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- LSP Commands
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [Action]')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gdt', "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", '[G]oto [D]efinition New Tab')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    require("lsp_signature").on_attach(
        {
            bind = true,
            hint_prefix = "> ",
            floating_window_above_cur_line = true
        },
        bufnr
    )
end

-- +++ LSP Configuration +++

-- Format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

local servers = {
    rust_analyzer = {
        on_attach = on_attach
    },
    pyright = {
        on_attach = on_attach
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
        on_attach = on_attach
    }
}

require('neodev').setup()
require('mason').setup()

require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers)
}

-- Packages can be found at: https://github.com/mason-org/mason-registry/tree/main/packages
require('mason-tool-installer').setup {
    ensure_installed = {
        -- Python
        'black',
        'isort',
        'autopep8',
        'mypy',
        'flake8',
        'pylint',
        -- Rust
        'codelldb',
        'rustfmt'
    }
}

local lspconfig = require 'lspconfig'
local coq = require 'coq'
lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities(servers['lua_ls']))
lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities(servers['rust_analyzer']))
lspconfig.pyright.setup(coq.lsp_ensure_capabilities(servers['pyright']))

-- Rust
require('rust-tools').setup {
    server = {
        on_attach = on_attach
    }
}

-- Spell Checker
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
-- local null_ls = require("null-ls")
-- null_ls.setup({
--     sources = {
--         null_ls.builtins.diagnostics.cspell,
--         null_ls.builtins.code_actions.cspell
--     }
-- })
