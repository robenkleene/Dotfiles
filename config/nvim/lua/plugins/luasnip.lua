return {
  'L3MON4D3/LuaSnip',
  -- Requires 'v2.*' for blink compatability
  version = 'v2.*',
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load({
      paths = { '~/.config/Code/User/snippets' }
    })
    local file=io.open(vim.env.HOME .. '/.local_snippets/package.json')
    if file~=nil then io.close(file)
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.local_snippets/" } })
    end

    local ls = require 'luasnip'
    local f = ls.function_node

    -- Snippets
    local s = ls.snippet
    -- fmt allows return multi-line output from shell scripts and parsing it easily (otherwise each line needs to be separate "node")
    local fmt = require("luasnip.extras.fmt").fmt

    -- Keymaps
    vim.api.nvim_set_keymap('i', '<Tab>', 'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"', { expr = true, silent = true })
    vim.keymap.set({'s'}, '<Tab>', function() ls.jump(1) end, { silent = true })
    vim.keymap.set({'i', 's'}, '<S-Tab>', function() ls.jump(-1) end, { silent = true })

    -- File Types
    ls.filetype_extend("zsh", { "sh" })
    ls.filetype_extend("typescript", { "javascript" })
    ls.filetype_extend("objc", { "objective-c" })

    -- Define a `compfunc`
    local function snippet_to_completion(snippet)
      return {
        word      = snippet.trigger,
        -- Using `snippet.name` just results in the trigger showing twice in the popup menu
        -- menu      = snippet.name,
        -- Using `"Snippet"` is consistent with how it works for `omnifunc`, it shows the type (e.g., `Function`, `Variable`, etc...)
        menu      = "Snippet",
        -- This preview gets stuck
        info      = vim.trim(table.concat(vim.tbl_flatten({snippet.dscr or "", "", snippet:get_docstring()}), "\n")),
        dup       = true,
        user_data = "luasnip"
      }
    end
    local function snippet_filter(line_to_cursor, base)
      return function(snippet)
        return not snippet.hidden and vim.startswith(snippet.trigger, base) and snippet.show_condition(line_to_cursor)
      end
    end
    function LuasnipCompleteFunc(findstart, base)
      local line, col = vim.api.nvim_get_current_line(), vim.api.nvim_win_get_cursor(0)[2]
      local line_to_cursor = line:sub(1, col)

      if findstart == 1 then
        return vim.fn.match(line_to_cursor, '\\k*$')
      end

      local snippets = vim.list_extend(vim.list_slice(ls.get_snippets("all")), ls.get_snippets(vim.bo.filetype))
      snippets = vim.tbl_filter(snippet_filter(line_to_cursor, base), snippets)
      snippets = vim.tbl_map(snippet_to_completion, snippets)
      table.sort(snippets, function(s1, s2) return s1.word < s2.word end)
      return snippets
    end
    vim.opt.completefunc = "v:lua.LuasnipCompleteFunc"
  end
}
