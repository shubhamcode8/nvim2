return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- Import mason
		local mason = require("mason")

		-- Import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- Import mason-tool-installer
		local mason_tool_installer = require("mason-tool-installer")

		-- Enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Setup mason-lspconfig
		mason_lspconfig.setup({
			ensure_installed = {
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"clangd", -- C/C++ support
			},
		})

		-- Setup mason-tool-installer
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- Prettier formatter
				"stylua", -- Lua formatter
				"eslint_d", -- ESLint Daemon
			},
		})

		-- Setup handlers for LSP servers
		mason_lspconfig.setup_handlers({
			-- Default handler for all servers
			function(server_name)
				-- Handle TypeScript server specifically
				if server_name == "typescript-language-server" then
					server_name = "tsserver" -- Update to correct server name for handling
				end

				-- Setup LSP capabilities
				local capabilities = require("cmp_nvim_lsp").default_capabilities()
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
		})
	end,
}
