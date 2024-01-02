return {
  "LunarVim/breadcrumbs.nvim",
  enabled = false,
  dependencies = {
    { "SmiteshP/nvim-navic" },
  },
  config = function()
    require("breadcrumbs").setup()
  end,
}
