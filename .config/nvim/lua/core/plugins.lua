local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
	use 'navarasu/onedark.nvim' -- Theme inspired by Atom
	use 'nvim-lualine/lualine.nvim' -- Fancier statusline	
	use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
	use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
	use 'nvim-tree/nvim-web-devicons'
	use 'akinsho/bufferline.nvim'
	use 'nvim-tree/nvim-tree.lua'
   use { -- Highlight, edit, and navigate code
    	  'nvim-treesitter/nvim-treesitter',
    	  run = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
    	  end,
  	}
	use { 'dasupradyumna/midnight.nvim' }
	use { 'folke/which-key.nvim',
  			config = function()
    		vim.o.timeout = true
    		vim.o.timeoutlen = 300
    		require("which-key").setup {
      		-- your configuration comes here
      		-- or leave it empty to use the default settings
      		-- refer to the configuration section below
    	}
  end
}
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

