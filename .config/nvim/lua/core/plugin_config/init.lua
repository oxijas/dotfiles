require('core.plugin_config.onedark')
require('core.plugin_config.lualine')
require('core.plugin_config.comment')
require('core.plugin_config.nvim-web-devicons')
require('core.plugin_config.bufferline')
require('core.plugin_config.nvim-tree')
require('core.plugin_config.nvim-treesitter')


-- Automatically source and re-compile packer whenever you save this init.lua
-- local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   command = 'source <afile> | PackerCompile',
--   group = packer_group,
--   pattern = vim.fn.expand '$MYVIMRC',
-- })
