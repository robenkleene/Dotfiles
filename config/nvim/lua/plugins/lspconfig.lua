return {
  'neovim/nvim-lspconfig',
  -- `VeryLazy` disrupts connecting to existing LSP
  -- event = "VeryLazy",
  config = function()
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    -- Disable showing "virtual text" (diagnostic messages at the end of lines)
    -- Re-enabling these because they're helpful for Rust messages that often
    -- have multiple parts in the file, e.g.:
    -- 1. `<variable> does not live long enough`
    -- 2. `<variable> variable is borrowed here`
    -- vim.diagnostic.config({
    --   virtual_text = false,
    -- })

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
      -- Show on hover a floating window, but this conflicts with other popups
      -- vim.api.nvim_create_autocmd("CursorHold", {
      --   buffer = bufnr,
      --   callback = function()
      --     local options = {
      --       focusable = false,
      --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      --       border = 'rounded',
      --       source = 'always',
      --       prefix = ' ',
      --       scope = 'cursor',
      --     }
      --   end
      --   -- Show in a a floating window, but this conflicts with other popups
      --   -- vim.diagnostic.open_float(nil, opts)
      -- })
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
      -- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, bufopts)
      -- Run the command twice to automatically focus the float
      vim.keymap.set('n', '<localleader>d', vim.diagnostic.open_float, bufopts)
      -- Open and focus the float
      -- vim.keymap.set('n', '<leader>d', ":lua vim.diagnostic.open_float()<CR>:lua vim.diagnostic.open_float()<CR>", bufopts)
      vim.keymap.set('n', '<localleader>r', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<localleader>a', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<localleader>k', vim.lsp.buf.hover, bufopts)
      -- Open and focus the float
      -- vim.keymap.set('n', '<leader>k', ":lua vim.lsp.buf.hover()<CR>:lua vim.lsp.buf.hover()<CR>", bufopts)
      -- Really this should be a motion not a direct command
      -- e.g., so we can do =`] to format the last pasted text
      -- vim.keymap.set('n', '=', function() vim.lsp.buf.format { async = true } end, bufopts)
      vim.keymap.set('n', '<localleader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      -- This sometimes fires twice which causes the "press enter to continue prompt", and I usually don't care anyway
      -- vim.api.nvim_echo({{"LSP attached"}}, false, {})
    end

-- Doesn't appear this is necessary with `VeryLazy` removed, also wouldn't work
-- *with* `VeryLazy`, because it means the `autocmd` wouldn't fire because it
-- would be defined too late
--     vim.cmd([[
-- augroup lsp_start
--   autocmd!
--   autocmd FileType rust :LspStart
-- augroup END 
--     ]])

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

    require('lspconfig').lua_ls.setup {
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

    require'lspconfig'.jsonls.setup {
      on_attach = on_attach,
    }
  end
}
