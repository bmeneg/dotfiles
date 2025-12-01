-- start lazy.nvim pkg manager (./lua/config/lazy.lua)
require('config.lazy')

-- general nvim options
vim.opt.mouse = 'a'
vim.opt.backup = false
vim.opt.compatible = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.title = true
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.undodir = '.nvim/'
vim.opt.laststatus = 2
vim.opt.background = 'dark'
vim.opt.listchars = { space = '_', tab = '> ' }
vim.opt.encoding = 'UTF-8'

-- global variables watched by some plugins
vim.g.EditorConfig_max_line_indicator = 'none'
vim.g.airline_theme = 'base16_gruvbox_dark_pale'
vim.g.rustfmt_autosave = 1
vim.g.linuxsty_patterns = { "/usr/src/", "/home/bmeneg/git/linux" }

-- visuals
vim.cmd.colorscheme('tokyonight')
--- display diagnostic information as virtual lines
vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- keymaps
vim.keymap.set({ 'n', 'i', 'v' }, '<F2>', vim.cmd.NERDTreeToggle)
vim.keymap.set({ 'n', 'i', 'v' }, '<F3>', vim.cmd.TagbarToggle)

-- LSPs
--- general configuration for all LSPs to be merged later
local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config('*', {
	capabilities = capabilities,
	root_markers = { '.git' },
})
--- enable LSPs configured under lsp/ dir
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
