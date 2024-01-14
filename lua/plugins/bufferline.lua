return {
  "akinsho/bufferline.nvim",
  event = "BufWinEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
    },
  },
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    { "<Leader-b-f>", "<Cmd>BufferLinePick<CR>", desc = "Pick tab" },
  },
}
