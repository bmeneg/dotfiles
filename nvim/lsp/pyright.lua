local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}

return {
	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = 'openFilesOnly',
				ignore = { '*' },
			},
		},
		pyright = {
			disableOrganizeImports = true,
		},
	},
}
