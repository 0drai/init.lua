-- show source in diagnostic
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- require("nvim-ale-diagnostic")

local signs = {
	{ name = "LspDiagnosticsSignError", text = "" },
	{ name = "LspDiagnosticsSignWarning", text = "" },
	{ name = "LspDiagnosticsSignHint", text = "" },
	{ name = "LspDiagnosticsSignInformation", text = "" },
}

local sign_names = {
	"DiagnosticSignError",
	"DiagnosticSignWarn",
	"DiagnosticSignInfo",
	"DiagnosticSignHint",
}

for i, sign in ipairs(signs) do
	vim.fn.sign_define(sign_names[i], { texthl = sign_names[i], text = sign.text, numhl = "" })
end

local config = {
	virtual_text = true,
	signs = signs,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})

-- vim.lsp.handlers['textDocument/publishDiagnostics'] = function(_, _, params, client_id, _)
-- local config = {
-- underline = true,
-- virtual_text = true,
-- signs = true,
-- update_in_insert = false,
-- }
-- local uri = params.uri
-- local bufnr = vim.uri_to_bufnr(uri)

-- if not bufnr then
-- return
-- end

-- local diagnostics = params.diagnostics

-- for i, v in ipairs(diagnostics) do
-- if v.source ~= nil then
-- diagnostics[i].message = string.format('%s: %s', v.source, v.message)
-- else
-- diagnostics[i].message = v.message
-- end
-- end

-- vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

-- if not vim.api.nvim_buf_is_loaded(bufnr) then
-- return
-- end

-- vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
-- end

-- Go-to definition in a split window
vim.lsp.handlers["textDocument/definition"] = function()
	local util = vim.lsp.util
	local log = require("vim.lsp.log")
	local api = vim.api

	local handler = function(_, method, result)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(method, "No location found")
			return nil
		end

		-- we only vertical split here
		vim.cmd("split")

		if vim.tbl_islist(result) then
			util.jump_to_location(result[1])

			if #result > 1 then
				util.set_qflist(util.locations_to_items(result))
				api.nvim_command("copen")
				api.nvim_command("wincmd p")
			end
		else
			util.jump_to_location(result)
		end
	end

	return handler
end
