return {
  'neovim/nvim-lspconfig',
  -- `VeryLazy` or `ft` disrupts connecting to existing LSP
  config = function()
    -- Disable virtual text (error messages at the ends of lines)
    -- This is for code that we don't have full control over, we don't want to have to properly setup LSP for all code bases we touch, so this makes the messages less intrusive in those cases
    vim.diagnostic.config({
      virtual_text = false,
    })
    -- Use the `vim.diagnostic.setqflist` binding instead
    -- vim.api.nvim_create_user_command('LspDiagnostic', 'lua vim.diagnostic.setqflist()', {})
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- Enable inlay hints (e.g., type hints)
        -- For some reason you need to edit the buffer before this takes effect?
        -- vim.lsp.inlay_hint.enable(false, { bufnr = ev.bufnr })
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.bufnr })

        local opts = { buffer = ev.buf }

        -- Go to
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
        -- Provide access to default implementations
        vim.keymap.set('n', '<localleader>gd', 'gd', opts)
        vim.keymap.set('n', '<localleader>gD', 'gD', opts)
        -- Show palette
        vim.keymap.set('n', '<localleader><C-k>', vim.lsp.buf.signature_help, opts)
        -- Allow use of default `K` binding when LSP is enabled
        -- Not sure if we actually need this
        -- vim.keymap.set('n', '<localleader>K', 'K', opts)
        -- Actions
        vim.keymap.set('n', '<localleader>ar', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<localleader>ac', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<localleader>=', function() vim.lsp.buf.format { async = true } end, opts)
        -- Quickfix
        vim.keymap.set('n', '<localleader>cr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<localleader>cd', vim.diagnostic.setqflist, opts)
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
