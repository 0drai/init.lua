local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

-- https://github.com/neovim/nvim-lspconfig
local on_attach = function(client, bufnr)
	local signature = require("lsp_signature")

	signature.on_attach({
		bind = true,
		hint_enable = true,
		floating_window = true,
		hint_prefix = " ",
		hint_scheme = "String",
		handler_opts = { border = "single" },
	})

	local rm = function(keybinding, command)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", keybinding, command, opts)
	end

	rm("gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
	rm("gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
	rm("<localleader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>")

	-- vim already has builtin docs
	if vim.bo.ft ~= "vim" then
		rm("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
	end

	rm("<localleader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
	rm("<localleader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
	rm("<localleader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
	rm("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	rm("<localleader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
	rm("<localleader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	rm("<localleader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	rm("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	rm("<localleader>d", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
	rm("<c-h>", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
	rm("<c-l>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
	rm("<space>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>")

	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
			false
		)
	end
end

local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
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
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			path = sumneko_root_path,
			diagnostics = { enable = true, globals = { "vim", "packer_plugins" } },
			runtime = { path = runtime_path, version = "LuaJIT" },
			workspace = {
				library = { library = vim.api.nvim_get_runtime_file("", true) },
			},
			telemetry = { enable = false },
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
			setenceCacheSize = 4000,
			additionalRules = { enablePickyRules = true, motherTongue = "de" },
			trace = { server = "off" },
			dictionary = {},
			disabledRules = { ["en-US"] = { "WHITESPACE_RULE" } },
			hiddenFalsePositives = {},
		},
	},
})

-- stuff like inlay hints and so on
if pcall(require, "rust-tools") and pcall(require, "lspconfig") then
	require("rust-tools").setup({
		["server"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		},
	})
end

-- use default config for these lsps
for _, lsp in ipairs({ "bashls", "denols", "jsonls", "dockerls", "texlab", "solargraph" }) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

-- require('lsp.saga')
require("lsp.handlers")
require("lsp.symbols")
