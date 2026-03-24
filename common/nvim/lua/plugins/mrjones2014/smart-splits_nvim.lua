---@type LazyPluginSpec
return {
  "mrjones2014/smart-splits.nvim",
  opts = {},
  keys = {
    { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize Split Left" },
    { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize Split Down" },
    { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize Split Up" },
    { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize Split Right" },
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move Cursor Left" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move Cursor Down" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move Cursor Up" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move Cursor Right" },
    { "<C-\\>", function() require("smart-splits").move_cursor_previous() end, desc = "Move Cursor Previous" },
    { "<leader><leader>h", function() require("smart-splits").swap_buf_left() end, desc = "Swap Buffer Left" },
    { "<leader><leader>j", function() require("smart-splits").swap_buf_down() end, desc = "Swap Buffer Down" },
    { "<leader><leader>k", function() require("smart-splits").swap_buf_up() end, desc = "Swap Buffer Up" },
    { "<leader><leader>l", function() require("smart-splits").swap_buf_right() end, desc = "Swap Buffer Right" },
  },
  config = function(_, opts)
    require("smart-splits").setup(opts)
  end,
}
