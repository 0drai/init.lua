local u = require("config.utils")

local autocmds = {
	-- disable highlighting of search result after entering insert mode
	toggle_search_highlighting = { { "InsertEnter", "*", ":nohl | redraw" } },
	lua_highlight = {
		{ "TextYankPost", "*", "silent! lua vim.highlight.on_yank{timeout=500}" },
	},
	-- return to last position
	retlast = {
		{
			"BufReadPost",
			"*",
			[[
     if line("'\"") > 0 && line("'\"") <= line("$") |
       exe "normal! g`\"" |
     endif
    ]],
		},
	},
	-- auto compile packer after saving it
	packer_compile = {
		{
			"BufWritePost",
			"init.lua",
			[[PackerCompile | echomsg 'packer compiled!']],
		},
	},
	-- delete tailing white spaces on save
	delws = { { "BufWritePre", "*", [[%s/\s\+$//e]] } },

	spell_leave = { { "BufLeave", "*", "set nospell" } },

	-- disable lsp for vimwiki
	-- wiki = {
	-- 	{ "FileType", "vimwiki", [[LspStop]] },
	-- },

	quit = {
		{ "FileType", "dashboard,help", [[nnoremap <silent> <buffer> q :q<CR>]] },
	},

	dash_enter = { { "FileType", "dashboard", [[IndentBlanklineDisable]] } },
}

u.create_augroups(autocmds)
