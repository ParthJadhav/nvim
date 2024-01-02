return {
  "lukas-reineke/indent-blankline.nvim",
  commit = "9637670896b68805430e2f72cf5d16be5b97a22a",
  event = { "BufReadPost", "BufNewFile" },
  enabled = false,
  config = function()
    local icons = require("config.icons")

    require("indent_blankline").setup {
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
        "neo-tree"
      },
      char = icons.ui.LineMiddle,
      context_char = icons.ui.LineMiddle,
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      use_treesitter = true,
      show_current_context = true,
    }
  end
}
