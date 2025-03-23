return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
				"html",
				"jsonls",
				"clangd",
				"pyright",
				"yamlls",
				"lua_ls",
				"bashls",
				"rust_analyzer",
				"dockerls",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"codelldb",
				"prettier",
				"stylua", -- lua formatter
				"isort", -- python formatter
				"clang-format",
				"black", -- python formatter
				"shfmt", -- bash formatter
				"pylint",
				"luacheck",
				"gitui",
				"omnisharp",
			},
		})
	end,
}
