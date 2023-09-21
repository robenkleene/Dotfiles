return {
  'neovim/nvim-lspconfig',
  -- `VeryLazy` or `ft` disrupts connecting to existing LSP
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }

        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<localleader>d', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<localleader>r', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<localleader>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<localleader>k', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<localleader>f', function() vim.lsp.buf.format { async = true } end, opts)
      end,
    })

    -- Languages

    require 'lspconfig'.bashls.setup {}

    require 'lspconfig'.clangd.setup {}

    require 'lspconfig'.cssls.setup {}

    require 'lspconfig'.html.setup {}

    require 'lspconfig'.solargraph.setup {}

    require('lspconfig').lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = runtime_path,
          },
          diagnostics = {
            globals = { 'vim', 'capabilities', 'runtime_path', },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            -- Disable message about configuring `luassert` workspace
            checkThirdParty = false
          },
          telemetry = { enable = false },
        },
      },
    }

    require('lspconfig').pyright.setup {
    }

    require('lspconfig').rust_analyzer.setup {
    }

    require('lspconfig').tsserver.setup {
    }

    require 'lspconfig'.jsonls.setup {
    }

    require 'lspconfig'.marksman.setup {
    }
  end
}
