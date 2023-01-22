require("nvim-tree").setup({
  sort_by = "case_insensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "l", action = "<CR>", action_cb = edit_or_open },
        { key = "h", action = "dir_up" },
      --  { key = "H", action = "collapse_all", action_cb = collapse_all }
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    open_file = {
        quit_on_open = true
    }
  }
})
