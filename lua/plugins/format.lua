require("format").setup({
	["*"] = { tempfile_dir = "/tmp/" },
	-- lua = {{cmd = {"lua-format -i"}}},
	lua = { { cmd = { "stylua -s" } } },
	go = { { cmd = { "gofmt -w", "goimports -w" } } },
	javascript = { { cmd = { "prettier -w", "./node_modules/.bin/eslint --fix" } } },
	typescript = { { cmd = { "prettier -w", "./node_modules/.bin/eslint --fix" } } },
	-- tex = {{cmd = {"blacktex -c -i"}}},
	tex = { { cmd = { [[latexindent -g /dev/null -c /tmp/ -m -s -y="onlyOneBackUp:1" -w]] } } },
	yaml = { { cmd = { "prettier -w" } } },
	sh = { { cmd = { "shfmt -w" } } },
	zsh = { { cmd = { "shfmt -w" } } }, -- :-(
	rust = { { cmd = { "rustfmt" } } },
	python = { { cmd = { "yapf -i" } } },

	markdown = { { cmd = { "prettier -w", "markdownlint -f" } } },
})
