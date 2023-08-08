print("Wokrs")

vim.g.mapleader = " "

require('packer').startup(function(use)
	-- Packer can manage itself
	use { "wbthomason/packer.nvim" }

	-- Gruvbox theme
	use { "ellisonleao/gruvbox.nvim" }

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		 requires = { {'nvim-lua/plenary.nvim'} }
	}

	 use({
	   "chama-chomo/grail",
	   -- Optional; default configuration will be used if setup isn't called.
	   config = function()
		require("grail").setup()
	   end,
	 })

	use { "fatih/vim-go" }

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			{'neovim/nvim-lspconfig'},             	-- Required
			{'williamboman/mason.nvim'},           	-- Optional
			{'williamboman/mason-lspconfig.nvim'}, 	-- Optional
			{'hrsh7th/nvim-cmp'},         			-- Required
			{'hrsh7th/cmp-nvim-lsp'},			    -- Required
			{'hrsh7th/cmp-buffer'},    			    -- Optional
			{'hrsh7th/cmp-path'},      			    -- Optional
			{'L3MON4D3/LuaSnip'},      		        -- Required
			{'rafamadriz/friendly-snippets'}, 	    -- Optional
	},
	use {"akinsho/toggleterm.nvim", tag = '*' },
	use "jhlgns/naysayer88.vim",
	use "terrortylor/nvim-comment",
	use "CreaturePhil/vim-handmade-hero"
	}

	-- GIT
	use { "lewis6991/gitsigns.nvim" }

	-- SVELTE
	use { "evanleck/vim-svelte" }
end)

-- GIT
require('gitsigns').setup()

-- TERMINAL SETUP
require("toggleterm").setup{
	direction = "horizontal",
	size = 30,
	open_mapping = [[<C-j>]]
}

-- GRUVBOX
vim.cmd("colorscheme gruvbox")

-- LSP
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"gopls",
	"eslint",
	"pyright",
})

lsp.set_preferences({
	sign_icons = {}
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)

lsp.setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = false,
		virtual_text = true,
		underline = false,
	}
)

-- some
vim.keymap.set("n", ":ex<CR>", ":Ex<CR>")

-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<C-f>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })

-- TREESITTER
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "vim", "go", "javascript", "typescript", "python"},
	highlight = {
		enable = false,
	}
}


-- COMMENT
require("nvim_comment").setup({
	operator_mapping = "<leader>/"
})

-- Adding the same comment color in each theme
vim.cmd([[
	augroup CustomCommentCollor
		autocmd!
		autocmd VimEnter * hi Comment guifg=#2ea542
	augroup END
]])

-- Disable annoying match brackets and all the jaz
vim.cmd([[
	augroup CustomHI
		autocmd!
		autocmd VimEnter * NoMatchParen 
	augroup END
]])

vim.keymap.set("i", "jj", "<Esc>")

vim.opt.guicursor = "i:block"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.swapfile = false

vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.termguicolors = true

