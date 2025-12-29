---@module "lazy"
---@type LazySpec
return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  config = function()
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.filetype_extend("php", { "html" })
    luasnip.filetype_extend("blade", { "html" })
    luasnip.filetype_extend("javascriptreact", { "html", "jsdoc" })
    luasnip.filetype_extend("typescriptreact", { "html", "tsdoc" })
    luasnip.filetype_extend("javascript", { "jsdoc" })
    luasnip.filetype_extend("typescript", { "tsdoc" })
    luasnip.filetype_extend("lua", { "luadoc" })
    luasnip.filetype_extend("python", { "pydoc" })
    luasnip.filetype_extend("rust", { "rustdoc" })
    luasnip.filetype_extend("cs", { "csharpdoc" })
    luasnip.filetype_extend("c", { "cdoc" })
    luasnip.filetype_extend("cpp", { "cppdoc" })
    luasnip.filetype_extend("php", { "phpdoc" })
    luasnip.filetype_extend("kotlin", { "kdoc" })
    luasnip.filetype_extend("ruby", { "rdoc" })
    luasnip.filetype_extend("sh", { "shelldoc" })
  end,
  keys = {
    {
      "<M-l>",
      function()
        require("luasnip").jump(1)
      end,
      mode = { "i", "s" },
      desc = "Jump forward",
    },
    {
      "<M-h>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "i", "s" },
      desc = "Jump backward",
    },
    {
      "<M-L>",
      function()
        require("luasnip").change_choice(1)
      end,
      mode = { "i", "s" },
      desc = "Change choice forward",
    },
    {
      "<M-H>",
      function()
        require("luasnip").change_choice(-1)
      end,
      mode = { "i", "s" },
      desc = "Change choice backward",
    },
  },
}
