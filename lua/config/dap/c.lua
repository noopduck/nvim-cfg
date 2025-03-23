-- ~/.config/nvim/lua/dap_config/c.lua
local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/lib/llvm-14/bin/lldb-vscode", -- or wherever it is on your system
	name = "lldb",
}

dap.configurations.c = {
	{
		name = "Launch file",
		type = "lldb",
		request = "launch",
		program = function()
			local result = vim.fn.system("make")
			if vim.v.shell_error ~= 0 then
				error("Build failed: " .. result)
			end

			local binary = vim.fn.input("Executable name: ", "main", "file")
			local path = vim.fn.getcwd() .. "/" .. binary
			if vim.fn.filereadable(path) == 0 then
				error("Binary not found: " .. path)
			end

			return path
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = true,
	},
}

dap.configurations.cpp = dap.configurations.c
