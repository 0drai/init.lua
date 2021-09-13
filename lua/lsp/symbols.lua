local lsp_symbols = {
  Text = ' (text)',
  Method = ' (method)',
  Function = ' (func)',
  Ctor = ' (ctor)',
  Field = ' (field)',
  Variable = ' (var)',
  Class = ' (class)',
  Interface = 'ﰮ (interface)',
  Module = ' (module)',
  Property = ' (property)',
  Unit = 'ﰩ (unit)',
  Value = ' (value)',
  Enum = '練(enum)',
  Keyword = ' (keyword)',
  Snippet = '﬌ (snippet)',
  Color = ' (color)',
  File = ' (file)',
  Reference = ' (ref)',
  Folder = ' (folder)',
  EnumMember = ' (enum member)',
  Constant = 'ﱃ (const)',
  Struct = ' (struct)',
  Event = ' (event)',
  Operator = '璉(operator)',
  TypeParameter = ' (type param)',
}

for kind, symbol in pairs(lsp_symbols) do
  local kinds = vim.lsp.protocol.CompletionItemKind
  local index = kinds[kind]

  if index ~= nil then
    kinds[index] = symbol
  end
end

-- replace the default lsp diagnostic symbols
local lsp_symbol = function(name, icon)
  vim.fn.sign_define('LspDiagnosticsSign' .. name, { text = icon, numhl = 'LspDiagnosticsDefaul' .. name })
end

lsp_symbol('Error', '')
lsp_symbol('Warning', '')
lsp_symbol('Information', '')
lsp_symbol('Hint', '')
