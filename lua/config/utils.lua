local M = {}

local api = vim.api

local default_map_opts = { silent = true, noremap = true }

M.map = function(mode, key, cmd, opts)
	opts = opts or default_map_opts
	vim.keymap.set(mode, key, cmd, opts)
end

-- xmap, imap, etc
for _, mode in ipairs({ "n", "o", "i", "x", "v" }) do
	M[mode .. "map"] = function(...)
		M.map(mode, ...)
	end
end

M.buf_map = function(bufnr, mode, key, cmd, opts)
	opts = opts or default_map_opts
	opts.buffer = bufnr

	M.map(mode, key, cmd, opts)
end

M.t = function(str)
	return api.nvim_replace_termcodes(str, true, true, true)
end

M.command = function(name, fn, opts)
	api.nvim_create_user_command(name, fn, opts or { nargs = 1 })
end

M.telescope_nmap = function(key, cmd)
	M.nmap(key, string.format(":Telescope %s<CR>", cmd))
end

M.saga_nmap = function(bufnr, key, cmd)
	M.buf_map(bufnr, "n", key, string.format(":Lspsaga %s<CR>", cmd))
end

M.create_augroups = function(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command("augroup " .. group_name)
		api.nvim_command("autocmd!")
		-- for _, def in ipairs(definition) do
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			api.nvim_command(command)
		end
		api.nvim_command("augroup END")
	end
end

return M
