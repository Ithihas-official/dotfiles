require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {
      config = {
        icon_preset = "basic",
        icons = {
          code_block = {
            conceal = true
          },
        },

      }
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          my_notes = "~/notes",
        },
        default_workspace = "my_notes",
      },
    },
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp", name = "[Norg]"
      },

      sources = {
        { name = "neorg" }
      }
    },
  }
})
