return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui", -- Optional UI
		"theHamsta/nvim-dap-virtual-text", -- Optional inline values
		"nvim-telescope/telescope-dap.nvim", -- Optional DAP pickers
	},
	config = function()
		require("dapui").setup()
		require("nvim-dap-virtual-text").setup()
	end,
}
