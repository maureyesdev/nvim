return {
  "Djancyp/better-comments.nvim",
  config = function()
    local better_comments = require("better-comment")
    -- TODO: NEED TO SET THIS UP
    better_comments.Setup({
      tags = {
        -- IMPORTANT - green
        {
          name = "*",
          fg = "#98C379",
          bg = "",
          bold = true,
        },
        -- ALERT - red
        {
          name = "!",
          fg = "#FF2D00",
          bg = "",
          bold = true,
        },
        -- QUESTION - blue
        {
          name = "?",
          fg = "#3498DB",
          bg = "",
          bold = true,
        },
        -- TODO
        {
          name = "TODO",
          fg = "#FF8C00",
          bg = "",
          bold = true,
          virtual_text = "",
        },
        {
          name = "FIX",
          fg = "white",
          bg = "#f44747",
          bold = true,
          virtual_text = "This is virtual Text from FIX",
        },
        {
          name = "WARNING",
          fg = "#FFA500",
          bg = "",
          bold = false,
          virtual_text = "This is virtual Text from WARNING",
        },

      }
    })
  end,
}
