local g = vim.g
local u = require("config.utils")
local wiki = os.getenv("WIKI")

u.command("VimwikiScratch", string.format("e %s/Scratchpad.md", wiki))

g.vimwiki_auto_header = 1
g.vimwiki_hl_headers = 1
g.vimwiki_markdown_link_ext = 1
g.vimwiki_list = {
	{
		["path"] = wiki,
		["syntax"] = "markdown",
		["ext"] = ".md",
		["auto_generate_tags"] = 1,
		["auto_generated_links"] = 1,
	},
}
g.taskwiki_markup_syntax = "markdown"
g.taskwiki_taskrc_location = os.getenv("TASKRC")
g.taskwiki_data_location = os.getenv("TASKDATA")

g.vimwiki_conceallevel = 0
