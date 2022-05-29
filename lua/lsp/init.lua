local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")
local u = require("config.utils")

-- https://github.com/neovim/nvim-lspconfig
local on_attach = function(client, bufnr)
	local signature = require("lsp_signature")

	signature.on_attach({
		bind = true,
		hint_enable = true,
		floating_window = true,
		hint_prefix = "",
		hint_scheme = "String",
		handler_opts = { border = "rounded" },
	})

	u.buf_map(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
	u.buf_map(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
	u.buf_map(bufnr, "n", "<localleader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>")
	u.buf_map(bufnr, "n", "<localleader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
	u.buf_map(bufnr, "n", "<localleader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
	u.buf_map(bufnr, "n", "<localleader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")

	local saga = require("lspsaga")
	saga.init_lsp_saga({
		finder_action_keys = {
			open = "<CR>",
			vsplit = "<C-v>",
			split = "<C-x>",
			quit = "q",
			scroll_down = "<C-f>",
			scroll_up = "<C-b>",
		},
		code_action_keys = { quit = "q", exec = "<CR>" },
	})

	-- saga/lsp stuff

	-- scroll down hover doc or scroll in definition preview
	u.nmap("<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")

	-- scroll up hover doc
	u.nmap("<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

	-- vim already has builtin docs
	if vim.bo.ft ~= "vim" then
		u.saga_nmap(bufnr, "K", "hover_doc")
	end

	u.saga_nmap(bufnr, "<localleader>ca", "code_action")
	u.saga_nmap(bufnr, "<C-k>", "signature_help")
	u.saga_nmap(bufnr, "<localleader>rn", "rename")
	u.saga_nmap(bufnr, "<C-h>", "diagnostic_jump_prev")
	u.saga_nmap(bufnr, "<C-l>", "diagnostic_jump_next")

	-- https://github.com/glepnir/lspsaga.nvim/pull/207
	u.saga_nmap(bufnr, "gh", "lsp_finder")
	u.saga_nmap(bufnr, "gp", "preview_definition")
	u.saga_nmap(bufnr, "<localleader>d", "show_line_diagnostics")

	client.resolved_capabilities.document_formating = false
	client.resolved_capabilities.range_formating = false

end

local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.offsetEncoding = { "utf-16" }
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

-- Configure lua language server for neovim development
local sumneko_binary_path = "/opt/lua-language-server/bin/Linux/lua-language-server"
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ":h:h:h")
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				typeCheckingMode = "basic",
				-- reportMissingTypeStubs = nil,
				strictListInference = true,
				strictDictionaryInference = true,
				strictSetInference = true,
				strictParameterNoneValue = true,
				reportMissingImports = true,
				useLibraryCodeForTypes = true,
			},
			-- most importantly
			venvPath = os.getenv("CONDA_VENV_PATH"),
		},
	},
})

lspconfig.clangd.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		"clangd",
		"--background-index",
		"--suggest-missing-includes",
		"--clang-tidy",
		"--header-insertion=iwyu",
	},
})

lspconfig.ltex.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		ltex = {
			language = "en-US",
			completionEnabled = true,
			diagnosticSeverity = "information",
			checkFrequency = "save",
			setenceCacheSize = 4000,
			additionalRules = { enablePickyRules = true },
			trace = { server = "off" },
			disabledRules = { ["en-US"] = { "WHITESPACE_RULE", "MORFOLOGIK_RULE_EN_US" } },
			hiddenFalsePositives = {},
		},
	},
})

-- lspconfig.texlab.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		texlab = {
-- 			build = {
-- 				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc" },
-- 				forwardSearchAfter = true,
-- 				onSave = false,
-- 			},
-- 			forwardSearch = {
-- 				executable = "zathura",
-- 				args = { "--synctex-forward", "%l:1:%f", "%p" },
-- 				onSave = true,
-- 			},
-- 		},
-- 	},
-- })

-- lspconfig.tsserver.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { "tsserver" },
-- })

-- stuff like inlay hints and so on
require("rust-tools").setup({
	["server"] = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

require("clangd_extensions").setup({
	["server"] = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- use default config for these lsps
for _, lsp in ipairs({ "bashls", "tsserver", "dockerls", "solargraph" }) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

require("lsp.handlers")
require("lsp.symbols")
