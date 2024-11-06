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
        -- Unset `tagfunc`, this gets set to `v:lua.vim.lsp.tagfunc`, unsetting this allows `C-]` to use tags instead of LSP
        vim.bo[ev.buf].tagfunc = nil
        -- Enable inlay hints (e.g., type hints)
        -- For some reason you need to edit the buffer before this takes effect?
        -- vim.lsp.inlay_hint.enable(true)

        local opts = { buffer = ev.buf }
        -- Go to
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- This is obviously correct but conflicts with the builtin `<C-w>d` binding to show the diagnostic float
        -- vim.keymap.set('n', '<C-w>d', function()
        --   vim.lsp.buf.definition()
        --   vim.cmd('split')
        -- end, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', '<C-w>D', function()
          vim.lsp.buf.declaration()
          vim.cmd('split')
        end, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'grd', vim.diagnostic.setqflist, opts)
        -- These are supposed to be built in but aren't working without this
        vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
        -- Provide access to default implementations
        vim.keymap.set('n', '<localleader>gd', 'gd', opts)
        vim.keymap.set('n', '<localleader>gD', 'gD', opts)
        -- Show palette
        vim.keymap.set('n', '<localleader><C-k>', vim.lsp.buf.signature_help, opts)
        -- Actions
        vim.keymap.set('n', '<localleader>=', function() vim.lsp.buf.format { async = true } end, opts)
        -- Hints
        vim.keymap.set('n', 'yoph', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })) end, opts)

        -- Highlight current cursor symbol
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client then
          local cap = client.server_capabilities
          if cap then
            if cap.documentHighlightProvider then
              vim.cmd([[
                augroup lsp_document_highlight
                  autocmd! * <buffer>
                  autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
                  autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
              ]])
            end
          end
        end

      end,
    })

    local lspconfig = require('lspconfig')
    -- Languages
    lspconfig.bashls.setup {}
    lspconfig.cssls.setup {}
    lspconfig.html.setup {}
    lspconfig.jsonls.setup {}
    lspconfig.marksman.setup {}
    lspconfig.marksman.setup {}
    lspconfig.pyright.setup {}
    lspconfig.rust_analyzer.setup {}
    lspconfig.solargraph.setup {}
    lspconfig.ts_ls.setup {}
    -- Special
    -- Apple recommends `dynamicRegistration` to watch files like the package manifest
    lspconfig.sourcekit.setup {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    }
    local f=io.open(vim.env.HOME .. '/.nvim_local.lua')
    if f==nil then
      lspconfig.clangd.setup {
        -- Suppress a `Multiple different client offset_encodings detected` error on attach
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      }
    end
    lspconfig.lua_ls.setup {
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
  end
}
