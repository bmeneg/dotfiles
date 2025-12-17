return {
	cmd = { 'clangd-17', '--background-index', '--pretty', '--clang-tidy', '--log=verbose' },
	filetypes = { 'c', 'cpp' },
	init_options = {
		fallbackFlags = {
			'-std=c17',
			'-Wall',
			'-Wextra',
			'-pedantic',
		},
	},
}
