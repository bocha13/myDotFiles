return {
	tools = {
		-- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
		reload_workspace_from_cargo_toml = true,
	},
	server = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
		settings = {
			["rust-analyzer"] = {
				completion = {
					postfix = {
						enable = false,
					},
				},
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
}
