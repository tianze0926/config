return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typst_lsp = {
          mason = false,
          root_dir = require("lspconfig.util").root_pattern('main.typ'),
          settings = {
            exportPdf = "never",
          },
        },
      },
    },
  },
  -- {
  --   "kaarmu/typst.vim",
  --   ft = "typst",
  --   lazy = false,
  -- },
}
