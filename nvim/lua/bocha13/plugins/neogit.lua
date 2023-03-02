return {
	"TimUntersberger/neogit",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Neogit",
	config = function()
		require("neogit").setup({
			integrations = {
				diffview = true,
			},
		})
	end,
}
