return {
  "SmiteshP/nvim-navic",
  init = function()
    vim.g.navic_silence = true
  end,
  opts = function()
    Snacks.util.lsp.on(
      { method = "textDocument/documentSymbol" },
      function(buffer, client)
        require("nvim-navic").attach(client, buffer)
      end
    )
    return {
      separator = " ",
      highlight = true,
      depth_limit = 5,
      lazy_update_context = true,
      icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      },
    }
  end,
}
