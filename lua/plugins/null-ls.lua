local null_ls = require("null-ls")

local sources = {

	-- formatting
	null_ls.builtins.formatting.yapf,
	null_ls.builtins.formatting.clang_format,
	null_ls.builtins.formatting.rustfmt.with({
		extra_args = { "--edition=2021" },
	}),
	null_ls.builtins.formatting.prettier.with({
		prefer_local = "node_modules/.bin",
	}),

	null_ls.builtins.formatting.eslint.with({
		prefer_local = "node_modules/.bin",
	}),
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.latexindent.with({
		extra_args = { "-g", "/dev/null", "-c", "/tmp/", "-m", "-s", "-y='onlyOneBackUp:1'", "-w" },
	}),
	null_ls.builtins.formatting.shfmt.with({
		extra_filetypes = { "zsh" },
	}),

	null_ls.builtins.formatting.rubocop,
	null_ls.builtins.formatting.codespell,
	null_ls.builtins.formatting.trim_newlines,
	null_ls.builtins.formatting.trim_whitespace,

	-- diagnostics
	null_ls.builtins.diagnostics.eslint.with({
		prefer_local = "node_modules/.bin",
		method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}),

	null_ls.builtins.diagnostics.pylint.with({
		method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}),

	-- null_ls.builtins.diagnostics.mypy.with({
	-- 	prefer_local = ".venv/bin",
	-- method = null_ls.methods.DIAGNOSTICS_ON_SAVE
	-- }),

	null_ls.builtins.diagnostics.shellcheck,
	null_ls.builtins.diagnostics.hadolint,
	null_ls.builtins.diagnostics.chktex,
	null_ls.builtins.diagnostics.codespell,
	null_ls.builtins.diagnostics.cppcheck,
	null_ls.builtins.diagnostics.luacheck,
	null_ls.builtins.diagnostics.vale.with({
		extra_filetypes = { "vimwiki" },
	}),

	-- code actions
	null_ls.builtins.code_actions.eslint.with({
		prefer_local = "node_modules/.bin",
	}),
}

null_ls.setup({
	sources = sources,
})
