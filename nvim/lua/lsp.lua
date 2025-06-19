-- [[ Configure LSP ]]
-- Taken from https://github.com/nvim-lua/kickstart.nvim
-- This function gets run when an LSP connects to a particular buffer.

local nmap = function(keys, func, desc)
if desc then
  desc = 'LSP: ' .. desc
end

vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ts', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ps', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    nmap('<leader>sd', require('telescope.builtin').diagnostics, '[S]how [D]iagnostics')

    -- switch between c++ header and source
    nmap('<leader>h', ':ClangdSwitchSourceHeader<CR>', 'Switch between c++ [H]eader and Source')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>sp', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    -- nmap('<leader>wl', function()
    -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    nmap('<leader>rf', ':Format<CR>', '[B]uffer [F]ormat')
end

-- Control Diagnostics
vim.diagnostic.config(
    {
        virtual_text = {
            source = false,
        },
        signs = false,
    }
)
nmap('<leader>df', function () vim.diagnostic.open_float({ scope = "line" }) end,
    '[D]iagnostics open in [F]loat window')
nmap('<leader>dl', function () vim.diagnostic.open_float({ scope = "buffer" }) end,
    '[D]iagnostics [L]ist in float window')
nmap('<leader>ds', vim.diagnostic.show, '[D]iagnostics [H]ide')
nmap('<leader>dh', vim.diagnostic.hide, '[D]iagnostics [S]how')

-- document existing key chains (do not have which-key)
-- require('which-key').register {
--   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--   ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--   ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
--   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--   ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
--   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- }
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
-- require('which-key').register({
--   ['<leader>'] = { name = 'VISUAL <leader>' },
--   ['<leader>h'] = { 'Git [H]unk' },
-- }, { mode = 'v' })

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {
    cmd = {
        '/usr/bin/clangd-19',
        -- '--log=verbose',
    },
    filetypes = {
        'cpp',
        'c',
        'hpp',
        'h',
    },
  },
  -- gopls = {},
  pyright = {},
  -- pylsp = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  -- lua_ls = {
  --   Lua = {
  --     workspace = { checkThirdParty = false },
  --     telemetry = { enable = false },
  --     -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
  --     -- diagnostics = { disable = { 'missing-fields' } },
  --   },
  -- },
}

-- Setup neovim lua configuration
-- require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_enable = false,
}

for name, config in pairs(servers) do
    require('lspconfig')[name].setup {
      cmd = config.cmd,
      capabilities = capabilities,
      on_attach = on_attach,
      settings = config,
      filetypes = config.filetypes,
    }
end

