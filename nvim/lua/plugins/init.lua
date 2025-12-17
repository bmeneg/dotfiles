return {
	-- appearance
	{ 'flazz/vim-colorschemes' },
	{ 'folke/tokyonight.nvim' },
	{ 'NLKNguyen/papercolor-theme' },
	{
		'vim-airline/vim-airline',
		dependencies = { 'vim-airline/vim-airline-themes' },
		init = function ()
			vim.g.airline_theme = 'base16_gruvbox_dark_pale'
		end
	},
	{ 'edkolev/tmuxline.vim' },
	{ 'ryanoasis/vim-devicons' },
	-- coding styles
	{
		'editorconfig/editorconfig-vim',
		init = function ()
			vim.g.EditorConfig_max_line_indicator = 'none'
		end
	},
	{
		'gregkh/kernel-coding-style',
		init = function ()
			vim.g.linuxsty_patterns = { "/usr/src/", "/home/bmeneg/git/linux" }
		end
	},
	-- git integration
	{ 'tpope/vim-fugitive' },
	{ 'mhinz/vim-signify' },
	-- coding utilities
	{ 'nvim-treesitter/nvim-treesitter'},
	{ 'tpope/vim-commentary' },
	{
		'preservim/nerdtree',
		cmd = 'NERDTreeToggle',
	},
	{
		'majutsushi/tagbar',
		cmd = 'TagbarToggle',
	},
	--{ 'joe-skb7/cscope-maps' },
	{
		'nvim-telescope/telescope.nvim',
		 dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{ 'nvim-telescope/telescope-fzf-native.nvim' },
	-- debugger integration
	{ 'mfussenegger/nvim-dap' },
	{ 'rcarriga/nvim-dap-ui' },
	{ 'theHamsta/nvim-dap-virtual-text' },
	{ 'stevearc/overseer.nvim' },
	{ 'Civitasv/cmake-tools.nvim' },
	{ 'leoluz/nvim-dap-go' },
	{ 'nvim-neotest/nvim-nio' },
	-- LSP-related 
	{
		'folke/lazydev.nvim',
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = { 'rafamadriz/friendly-snippets' },
		version = '1.*',
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			keymap = { preset = 'default' },
			appearance = {
				nerd_font_variant = 'mono'
			},
			completion = { documentation = { auto_show = false } },
			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	}
}
