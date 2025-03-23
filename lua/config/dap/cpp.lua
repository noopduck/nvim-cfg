local M = {}

function M.setup()
	-- local dap_install = require "dap-install"
	-- dap_install.config("codelldb", {})

	local dap = require("dap")
	local install_root_dir = vim.fn.stdpath("data") .. "/mason"
	local extension_path = install_root_dir .. "/packages/codelldb/extension/"
	local codelldb_path = extension_path .. "adapter/codelldb"

	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = codelldb_path,
			args = { "--port", "${port}" },

			-- On windows you may have to uncomment this:
			-- detached = false,
		},
	}

	dap.configurations.cpp = {
		{
			name = "Launch an executable",
			-- Change it to "cppdbg" if you have vscode-cpptools
			type = "codelldb",
			request = "launch",
			program = function()
				-- Compile and return exec name
				local filetype = vim.bo.filetype
				local filename = vim.fn.expand("%")
				local basename = vim.fn.expand("%:t:r")
				local makefile = os.execute("(ls | grep -i makefile)")
				if makefile == "makefile" or makefile == "Makefile" then
					os.execute("make debug")
				else
					if filetype == "c" then
						os.execute(string.format("gcc -g -o %s %s", basename, filename))
					else
						os.execute(string.format("g++ -g -o %s %s", basename, filename))
					end
				end
				return basename
			end,
			args = function()
				local argv = {}
				arg = vim.fn.input(string.format("argv: "))
				for a in string.gmatch(arg, "%S+") do
					table.insert(argv, a)
				end
				vim.cmd('echo ""')
				return argv
			end,
			cwd = "${workspaceFolder}",
			-- Uncomment if you want to stop at main
			-- stopAtEntry = true,
			MIMode = "gdb",
			miDebuggerPath = "/usr/bin/gdb",
			setupCommands = {
				{
					text = "-enable-pretty-printing",
					description = "enable pretty printing",
					ignoreFailures = false,
				},
			},
		},
	}

	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp
end

return M
