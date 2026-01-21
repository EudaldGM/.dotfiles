return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    local colors = {
      white = "#bcbcbc",
      gray = "#6c7d82",
      black = "#000000",
      orange = "#ff8800",
      yellow = "#ffb86c",
      lightred = "#f72a42",
      lightblue = "#00ffff",
      darkblue = "#20213b",
    }

    require('onedark').setup {
      transparent = true,
      style = 'darker',
      code_style = {
        comments = 'italic',
      },
      highlights = {
        MiniTablineCurrent = { fg = colors.white, fmt = "bold" },
        MiniTablineFill = { fg = colors.gray, bg = colors.black },
        MiniTablineHidden = { fg = colors.gray, bg = colors.black },
        MiniTablineModifiedCurrent = { fg = colors.orange, fmt = "bold,italic" },
        MiniTablineModifiedHidden = { fg = colors.gray, bg = colors.black, fmt = "italic" },
        MiniTablineModifiedVisible = { fg = colors.yellow, bg = colors.black, fmt = "italic" },
        MiniTablineTabpagesection = { fg = colors.black, bg = colors.yellow },
        MiniTablineVisible = { fg = colors.gray, bg = colors.black },

        DiagnosticVirtualTextError = { fg = colors.lightred, bg = colors.black },
        DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = colors.black },
        DiagnosticVirtualTextInfo = { fg = colors.lightblue, bg = colors.black },
        DiagnosticVirtualTextHint = { fg = colors.white, bg = colors.black },

        Visual = { bg = colors.darkblue },
      }
    }

    require('onedark').load()
  end
}
