-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- vim.keymap.set("n", "<leader>E", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", {})
-- vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)
require("nvim-tree").setup({
  auto_reload_on_write = true,
  reload_on_bufenter = true,
  view = {
    centralize_selection = true,
    width = 25,
    side = "left",
  },
  renderer = {
    indent_width = 0,
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "all",
    root_folder_label = function(path)
      return "| " .. vim.fn.fnamemodify(path, ":t")
    end,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "after",
    },
  },
  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 400,
  },
  sync_root_with_cwd = false,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
})
