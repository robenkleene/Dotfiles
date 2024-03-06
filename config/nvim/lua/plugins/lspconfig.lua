return {
  'neovim/nvim-lspconfig',
  -- `VeryLazy` or `ft` disrupts connecting to existing LSP
  config = function()
    -- Disable virtual text (error messages at the ends of lines)
    -- This is for code that we don't have full control over, we don't want to have to properly setup LSP for all code bases we touch, so this makes the messages less intrusive in those cases
    vim.diagnostic.config({
      virtual_text = false,
    })
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }

        vim.keymap.set('n', '<localleader>gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<localleader>gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', '<localleader>gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<localleader>gy', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<localleader>d', vim.diagnostic.open_float, opts)
        -- Use one of these instead:
        -- `:lua vim.diagnostic.setqflist()`
        -- `:lua vim.diagnostic.setloclist()`
        -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<localleader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<localleader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<localleader>gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<localleader><C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<localleader>K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<localleader>=', function() vim.lsp.buf.format { async = true } end, opts)
      end,
    })

    -- Languages
    local f=io.open(vim.env.HOME .. '/.nvim_local.lua')
    if f==nil then
      require 'lspconfig'.clangd.setup {}
    end

    require 'lspconfig'.bashls.setup {}

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
