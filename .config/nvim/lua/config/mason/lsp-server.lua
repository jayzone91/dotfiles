return {
  lua_ls = {},
  gopls = {},
  html = {
    filetypes = { "html", "templ" },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
  templ = {},
  taplo = {},
  tailwindcss = {},
  powershell_es = {
    settings = {
      powershell = {
        codeFormatting = { Preset = "OTBS" },
      },
    },
  },
}
