local cmp = require("cmp")
local neogen = require("neogen")
local luasnip = require("luasnip")
-- luasnip["luasnip.loaders.from_vscode"].load()
require("luasnip.loaders.from_vscode").load()

vim.opt.pumheight = 15

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "orgmode" },
		{ name = "luasnip" },
		{ name = "emoji" },
		{ name = "path" },
		-- { name = "nuspell" },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
			vim_item.menu = ({
				-- buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				emoji = "[Emoji]",
				path = "[Path]",
				-- nuspell = "[Nuspell]",
			})[entry.source.name]
			return vim_item
		end,
	},

	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		-- ["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		-- use tab for everything
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			elseif neogen.jumpable() then
				feedkey("<cmd>lua require('neogen').jump_next()<CR>", "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, {
			"i",
			"s",
		}),
	},
})
