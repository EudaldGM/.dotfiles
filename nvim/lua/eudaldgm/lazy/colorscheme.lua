return {
	"navarasu/onedark.nvim",
	priority = 1000,
	config = function()
		-- Define custom colors
		local white = "#bcbcbc"
		local gray = "#6c7d82"
		local black = "#000000"
		local orange = "#ff8800"
		local yellow = "#ffb86c"
		local lightred = "#f72a42"
		local lightblue = "#00ffff"

		require('onedark').setup {
			style = 'darker',
			highlights = {
				MiniTablineCurrent = { fg = white, fmt = "bold" },
				MiniTablineFill = { fg = gray, bg = black },
				MiniTablineHidden = { fg = gray, bg = black },
				MiniTablineModifiedCurrent = { fg = orange, fmt = "bold,italic" },
				MiniTablineModifiedHidden = { fg = gray, bg = black, fmt = "italic" },
				MiniTablineModifiedVisible = { fg = yellow, bg = black, fmt = "italic" },
				MiniTablineTabpagesection = { fg = black, bg = yellow },
				MiniTablineVisible = { fg = gray, bg = black },
				DiagnosticVirtualTextError = { fg = lightred, bg = black },
				DiagnosticVirtualTextWarn = { fg = yellow, bg = black },
				DiagnosticVirtualTextInfo = { fg = lightblue, bg = black },
				DiagnosticVirtualTextHint = { fg = white, bg = black },
			}
		}
		require('onedark').load()
	end
}
