return {
	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
			-- gofumpt = true,
		},
	},
	on_attach = function(client, bufnr)
        if client:supports_method("textDocument/formatting") then
            -- Enable formatting on save using an autocmd
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = true })
                end,
            })
        end
    end,
}
