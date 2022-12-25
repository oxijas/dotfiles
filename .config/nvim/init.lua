--  packer
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

  use 'navarasu/onedark.nvim' -- Theme inspired by Atom

  use 'nvim-tree/nvim-web-devicons'

  use 'nvim-lualine/lualine.nvim'

  use {'luukvbaal/nnn.nvim',
    config = function() require("nnn").setup() end
  }

  -- use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  -- local has_plugins, plugins = pcall(require, 'custom.plugins')
  local has_plugins, plugins = pcall(require, 'plugin')
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


-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymap")


-- deze regel moet erin anders kan je niet gebruiken bij lualine
vim.cmd [[colorscheme onedark]]
-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  }
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}


require ('nnn').setup({
  explorer = {
		cmd = "nnn -cRHU",       -- command overrride (-F1 flag is implied, -a flag is invalid!)
		width = 36,        -- width of the vertical split
		side = "botright",  -- or "botright", location of the explorer window
		session = "",      -- or "global" / "local" / "shared"
		tabs = true,       -- seperate nnn instance per tab
		fullscreen = true, -- whether to fullscreen explorer window when current tab is empty
	},
  picker = {
		cmd = "nnn -cRHU",       -- command override (-p flag is implied)
		style = {
			width = 0.4,     -- percentage relative to terminal size when < 1, absolute otherwise
			height = 1.0,    -- ^
			xoffset = 0.9,   -- ^
			yoffset = 0.0,   -- ^
			-- border = "single"-- border decoration for example "rounded"(:h nvim_open_win)
			border = "rounded"-- border decoration for example "rounded"(:h nvim_open_win)
		},
		session = "",      -- or "global" / "local" / "shared"
		fullscreen = true, -- whether to fullscreen picker window when current tab is empty
	},
  auto_close = true
})

require ('nvim-web-devicons').setup()

-- dit is blijkbaar niet nodig voor barbar
-- require ('barbar').setup()

require("bufferline").setup({
  options = {
    numbers = ordinal,
        
  }
})


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
