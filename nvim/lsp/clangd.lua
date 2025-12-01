vim.lsp.config['clangd'] = {
	cmd = {'clangd-17', '--background-index', '--clang-tidy', '--log=verbose'},
	filetypes = { 'c', 'cpp', 'h', 'hpp' },
	init_options = {
		fallbackFlags = { '-std=c++17' },
	},
}
