return {
  'neovim/nvim-lspconfig',
  event = "VeryLazy",
  config = function()
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    vim.diagnostic.config({
      virtual_text = false,
    })

    -- Echo diagnostics, but this forces hitting enter for longer messages
    -- function PrintDiagnostics(opts, bufnr, line_nr, client_id)
    --   bufnr = bufnr or 0
    --   line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
    --   opts = opts or {['lnum'] = line_nr}
    --
    --   local line_diagnostics = vim.diagnostic.get(bufnr, opts)
    --   if vim.tbl_isempty(line_diagnostics) then return end
    --
    --   local diagnostic_message = ""
    --   for i, diagnostic in ipairs(line_diagnostics) do
    --     diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    --     print(diagnostic_message)
    --     if i ~= #line_diagnostics then
    --       diagnostic_message = diagnostic_message .. "\n"
    --     end
    --   end
    --   vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
    -- end
    -- vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]

    local on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local options = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          -- Show in a floating window, but this conflicts with other popups
          -- vim.diagnostic.open_float(nil, opts)
        end
      })
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, bufopts)
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', '=', function() vim.lsp.buf.format { async = true } end, bufopts)
      vim.api.nvim_echo({{"LSP attached"}}, false, {})
    end

    -- Languages

    require'lspconfig'.bashls.setup{
      on_attach = on_attach,
    }

    require'lspconfig'.clangd.setup{
      on_attach = on_attach,
    }

    require'lspconfig'.cssls.setup{
      on_attach = on_attach,
    }

    require'lspconfig'.html.setup{
      on_attach = on_attach,
    }

    require'lspconfig'.solargraph.setup{
      on_attach = on_attach,
    }

    require('lspconfig').sumneko_lua.setup {
      on_attach = on_attach,
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

    require('lspconfig').pyright.setup{
      on_attach = on_attach,
    }

    require('lspconfig').rust_analyzer.setup{
      on_attach = on_attach,
    }

    require('lspconfig').tsserver.setup{
      on_attach = on_attach,
    }
  end
}
