-- [[ Configure Treesitter ]]
-- Taken from https://github.com/nvim-lua/kickstart.nvim
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'

vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'lua', 'python', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, bufnr) -- Disable in large C++ buffers
            return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 50000
        end,
    },
    indent = { enable = false },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
        -- init_selection = '<c-space>',
        -- node_incremental = '<c-space>',
        -- scope_incremental = '<c-s>',
        -- node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ['<leader>gB'] = '@function.outer',
          ['<leader>gcB'] = '@class.outer',
        },
        goto_next_end = {
          ['<leader>ge'] = '@function.outer',
          ['<leader>gce'] = '@class.outer',
        },
        goto_previous_start = {
          ['<leader>gb'] = '@function.outer',
          ['<leader>gcb'] = '@class.outer',
        },
        goto_previous_end = {
          ['<leader>gE'] = '@function.outer',
          ['<leader>gcE'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        -- swap_next = {
        --   ['<leader>a'] = '@parameter.inner',
        -- },
        -- swap_previous = {
        --   ['<leader>A'] = '@parameter.inner',
        -- },
      },
    },
  }
end, 0)

vim.o.background = "dark"

vim.g.codeschool_contrast_dark = "medium"

require('lush')(require('codeschool').setup({
  plugins = {
    -- "buftabline",
    -- "coc",
    -- "cmp", -- nvim-cmp
    "fzf",
    -- "gitgutter",
    -- "gitsigns",
    "lsp",
    -- "lspsaga",
    -- "nerdtree",
    -- "netrw",
    "nvimtree",
    -- "neogit",
    -- "packer",
    -- "signify",
    -- "startify",
    -- "syntastic",
    "telescope",
    "treesitter"
  },
  langs = {
    "c",
    -- "clojure",
    -- "coffeescript",
    -- "csharp",
    -- "css",
    -- "elixir",
    -- "golang",
    -- "haskell",
    -- "html",
    -- "java",
    -- "js",
    "json",
    -- "jsx",
    "lua",
    "markdown",
    -- "moonscript",
    -- "objc",
    -- "ocaml",
    "purescript",
    "python",
    -- "ruby",
    -- "rust",
    -- "scala",
    -- "typescript",
    "viml",
    -- "xml"
  }
}))

vim.api.nvim_set_hl(0, "@type.builtin.cpp", { link = "Type" })
vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
vim.api.nvim_set_hl(0, "DiagnosticError", { link = "CodeschoolError" })
vim.cmd('hi CodeschoolError guifg=#db0a0a')
vim.api.nvim_set_hl(0, "DiagnosticWarn", { link = "CodeschoolWarning" })
vim.api.nvim_set_hl(0, "@keyword.import.cpp", { link = "CodeschoolRed" })

-- Enable spell check
vim.wo.spell = true

-- Do not fix EOL
vim.o.fixeol = false

