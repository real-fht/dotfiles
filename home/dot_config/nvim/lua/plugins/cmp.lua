---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'plugins.cmp'
---------------------------------------------------------------------------------

local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "saadparwaiz1/cmp_luasnip",
      event = "InsertEnter",
      dependencies = "L3MON4D3/LuaSnip",
    },
    { "hrsh7th/cmp-nvim-lsp", dependencies = "neovim/nvim-lspconfig" },
    "hrsh7th/cmp-path",
  },
}

M.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local cmp_kinds = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = " ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  }

  ---Checks if there's a word/term before the cursor.
  ---@return boolean
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        -- An expand function is required so snippets provided by the LSP servers
        -- can be expanded and jumped to it's nodes
        require("luasnip").lsp_expand(args.body)
      end,
    },
    window = {
      --[[ cmp.config.window.bordered ]]
      completion = {
        winhighlight = "Normal:CmpCompletionNormal,FloatBorder:CmpCompletionBorder,CursorLine:CmpDocumentationNormal",
        col_offset = -3,
        side_padding = 1,
      },
      --[[ cmp.config.window.bordered ]]
      documentation = {
        winhighlight = "Normal:CmpDocumentationNormal,FloatBorder:CmpDocumentationBorder",
      },
    },

    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete({}),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 10 },
      { name = "luasnip", priority = 7 }, -- For luasnip users.
    }, {
      { name = "path" },
    }),
    formatting = {
      fields = { "kind", "abbr" },
      format = function(entry, item)
        -- Add icon for entry if it's a file (path source)
        if vim.tbl_contains({ "path" }, entry.source.name) then
          if item.kind == "Folder" then
            item.abbr = item.abbr:gsub("/", "")
            item.kind = "ﱮ"
            item.kind_hl_group = "CmpFolderIcon"
            return item
          elseif item.kind == "File" then
            item.abbr = item.abbr:gsub("/", "")
            item.kind = ""
            item.kind_hl_group = "CmpFileIcon"
            return item
          end
          local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
          if icon then
            item.kind = icon
            item.kind_hl_group = hl_group
            return item
          end
        else
          item.kind = (cmp_kinds[item.kind] or "")
          return item
        end
        -- Otherwise default to LSPkind icons.
        return item
      end,
    },
  })

  -- Integration with nvim-autopairs.
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  require("theme").load_skeleton("cmp")
end

return M
