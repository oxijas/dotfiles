-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

	use { -- Highlight, edit, and navigate code
    	'nvim-treesitter/nvim-treesitter',
    	run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    	end,
  	}
    

	use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  -- use 'cpea2506/one_monokai.nvim'
	use 'nvim-lualine/lualine.nvim' -- Fancier statusline	
	use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
	use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  	-- use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
	use 'nvim-tree/nvim-web-devicons'

	use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

	use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  			require("toggleterm").setup()
	end}

	use "nvim-lua/plenary.nvim"

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

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

-- load keyboard jga
require('keymap')

require('onedark').setup {
   -- style = 'cool'
   style = 'deep'
   -- style = 'darker'
}
require('onedark').load()

-- require('one_monokai').setup {
--     transparent = true
-- }
-- require('one_monokai').load()


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    -- theme = 'one_monokai',
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

require ('nvim-web-devicons').setup()

require("bufferline").setup({
  options = {
    numbers = ordinal,
  }
})

require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'c_sharp', 'lua', 'python', 'rust', 'toml', 'markdown', 'json', 'help', 'zig' },

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

local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

local function collapse_all()
    require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
    -- open as vsplit on current node
    local action = "edit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
        view.close() -- Close the tree if file was opened

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
        view.close() -- Close the tree if file was opened
    end

end


require("nvim-tree").setup({
  sort_by = "case_insensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "l", action = "<CR>", action_cb = edit_or_open },
        { key = "h", action = "dir_up" },
        --{ key = "H", action = "collapse_all", action_cb = collapse_all }
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    open_file = {
        quit_on_open = true
    }
  }
})
