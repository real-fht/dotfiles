return {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.tbl_extend("keep", vim.api.nvim_get_runtime_file("", true), {
          [vim.fn.expand("~/.config/awesome")] = true,
          [vim.fn.expand("~/Documents/repos/gh-clone/awesome/lib")] = vim.fn.getcwd():match(".config/awesome"),
        }),
        check3rdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
