local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local function title()
  return [[-‘๑’-]]
end

local function lspGen()
  local msg = "No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    disabled_filetypes = { "NvimTree", "aerial", "Telescope" },
    -- component_separators = { left = "（", right = "）" },
    -- section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      {
        title,
        separator = { left = "", right = "" },
      },
    },
    lualine_b = {

      {
        "filename",
        cond = conditions.buffer_not_empty,

        separator = { right = "" },
      },

      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        separator = { right = "" },
      },
    },
    lualine_c = {

      {
        "branch",
      },
      {
        "diff",
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        separator = { right = "）" }
      },
    },
    lualine_x = {

      {
        lspGen,
        icon = " LSP:",
        separator = { left = "（" },
      },

    },

    lualine_y = {
      {
        "searchcount",
        separator = { left = "" },
      },
      {
        "location",
        separator = { left = "" },
      },
      {
        "progress",
        separator = { left = "" },
      },
    },
    lualine_z = {

      {
        "filetype",
        separator = { left = "", right = "" },
      },
    },
  },
})
