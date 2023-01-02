-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
	
	use 'wbthomason/packer.nvim'

	-- use { -- Autocompletion
  	--   'hrsh7th/nvim-cmp',
  	--   requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  	-- }

	use { -- Highlight, edit, and navigate code
    	'nvim-treesitter/nvim-treesitter',
    	run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    	end,
  	}


	use 'navarasu/onedark.nvim' -- Theme inspired by Atom
	use 'nvim-lualine/lualine.nvim' -- Fancier statusline	
	use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
	use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  	-- use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  	-- Fuzzy Finder (files, lsp, etc)
  	-- use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  	-- use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  	use {'luukvbaal/nnn.nvim',
   	config = function() require("nnn").setup() end
  	}
  
	use 'nvim-tree/nvim-web-devicons'

	-- use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
	use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

	-- use {'is0n/fm-nvim'}

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, 'custom.plugins')
	if has_plugins then
		plugins(use)
  	end

	if is_bootstrap then
   	require('packer').sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
 
require('options')


-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- load keyboard jga
-- kan zijn dat sommige dingen dubbel gedefineerd zijn
require('keymap')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
--   group = highlight_group,
--   pattern = '*',
-- })
--
-- Set lualine as statusline
-- See `:help lualine.txt`
--

-- Lua
require('onedark').setup {
    -- style = 'cool'
    style = 'deep'
}
require('onedark').load()


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
	 -- style = 'cool',
    component_separators = '|',
    section_separators = '',
  },
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-- require('telescope').setup {
--   defaults = {
--     mappings = {
--       i = {
--         ['<C-u>'] = false,
--         ['<C-d>'] = false,
--       },
--     },
--   },

require ('nnn').setup({
  explorer = {
		cmd = "nnn -cRHUp",       -- command overrride (-F1 flag is implied, -a flag is invalid!)
		width = 36,        -- width of the vertical split
		side = "botright",  -- or "botright", location of the explorer window
		session = "",      -- or "global" / "local" / "shared"
		tabs = true,       -- seperate nnn instance per tab
		fullscreen = true, -- whether to fullscreen explorer window when current tab is empty
	},
  picker = {
		cmd = "nnn -cRHU",       -- command override (-p flag is implied)
		style = {
			width = 0.25,     -- percentage relative to terminal size when < 1, absolute otherwise
			height = 1.0,    -- ^
			xoffset = 1.0,   -- ^
			yoffset = 0.0,   -- ^
			-- border = "single"-- border decoration for example "rounded"(:h nvim_open_win)
			border = "solid"-- border decoration for example "rounded"(:h nvim_open_win)
		},
		session = "",      -- or "global" / "local" / "shared"
		fullscreen = true, -- whether to fullscreen picker window when current tab is empty
	},
  auto_close = true
})

require ('nvim-web-devicons').setup()

require("bufferline").setup({
  options = {
    numbers = ordinal,
  }
})
-- =============================================================================
-- =============================================================================


-- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer]' })
--
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })


-- require('fm-nvim').setup{
--   -- (Vim) Command used to open files
--   edit_cmd = "edit",
--
--   -- See `Q&A` for more info
--   on_close = {},
--   on_open = {},
--
--   -- UI Options
--   ui = {
--     -- Default UI (can be "split" or "float")
--     default = "float",
--
--     float = {
--       -- Floating window border (see ':h nvim_open_win')
--       border    = "solid",
--
--       -- Highlight group for floating window/border (see ':h winhl')
--       float_hl  = "Normal",
--       border_hl = "FloatBorder",
--
--       -- Floating Window Transparency (see ':h winblend')
--       blend     = 0,
--
--       -- Num from 0 - 1 for measurements
--       height    = 0.8,
--       width     = 0.8,
--
--       -- X and Y Axis of Window
--       x = 0.5,
--       y = 0.5
--     },
--
--     split = {
--       -- Direction of split
--       direction = "topleft",
--
--       -- Size of split
--       size      = 24
--     }
--   },
--
--     -- Terminal commands used w/ file manager (have to be in your $PATH)
--     cmds = {
--     lf_cmd      = "lf", -- eg: lf_cmd = "lf -command 'set hidden'"
--     fm_cmd      = "fm",
--     nnn_cmd     = "nnn",
--     fff_cmd     = "fff",
--     twf_cmd     = "twf",
--     fzf_cmd     = "fzf", -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
--     fzy_cmd     = "find . | fzy",
--     xplr_cmd    = "xplr",
--     vifm_cmd    = "vifm",
--     skim_cmd    = "sk",
--     broot_cmd   = "broot",
--     gitui_cmd   = "gitui",
--     ranger_cmd  = "ranger",
--     joshuto_cmd = "joshuto",
--     lazygit_cmd = "lazygit",
--     neomutt_cmd = "neomutt",
--     taskwarrior_cmd = "taskwarrior-tui"
--   },
--
--   -- Mappings used with the plugin
--   mappings = {
--   vert_split = "<C-v>",
--   horz_split = "<C-h>",
--   tabedit    = "<C-t>",
--   edit       = "<C-e>",
--   ESC        = "<ESC>"
--   },
--
--   -- Path to broot config
--   broot_conf = vim.fn.stdpath("data") .. "/site/pack/packer/start/fm-nvim/assets/broot_conf.hjson"
-- }
--


require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help' },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
