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
	virtual_text = { source = "always", prefix = "●" },
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

vim.lsp.handlers["textDocument/codeAction"] = function(_, actions)
	if actions == nil or vim.tbl_isempty(actions) then
		print("No code actions available")
		return
	end
end

-- Go-to definition in a split window
local function goto_definition(split_cmd)
	local util = vim.lsp.util
	local log = require("vim.lsp.log")
	local api = vim.api

	-- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, "No location found")
			return nil
		end

		if split_cmd then
			vim.cmd(split_cmd)
		end

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

vim.lsp.handlers["textDocument/definition"] = goto_definition("tab")
