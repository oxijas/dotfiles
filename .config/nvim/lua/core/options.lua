
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Basic Keymaps ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Decrease update time
-- vim.o.updatetime = 250
-- vim.wo.signcolumn = 'yes'


-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

vim.opt.number = true
vim.opt.wrap = false
-- geen plus laten zien bij overloop
vim.opt.showbreak = ''

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- we hoeven de regel van de cursor niet te highlighten
vim.opt.cursorline = false
vim.opt.termguicolors = true
-- vim.cmd [[colorscheme onedark]]
--vim.opt.background = "dark"
--vim.cmd [[ colorscheme quantum]]

vim.opt.mouse = "a"
--vim.opt.guicursor=i:block

-- met retab! kan je spaties vervangen door tabs, uitkijken binnen quotes
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
-- zet tabs wel/niet om in spaces automatisch
-- bij wel, kan je met CTRL-V tab alsnog echte tab zetten
vim.opt.expandtab = false
vim.opt.showtabline = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
-- multiple buffers kunnen editen zonder ze eerst te saven
vim.opt.hidden = true

vim.opt.linebreak = true

vim.opt.encoding = "utf-8"
vim.opt.cmdheight = 1
vim.opt.cursorline = false

-- heeft niets met tabs in doc te maken maar of je de tabline bovenin
-- scherm laat zien, 2 = always
vim.opt.showtabline = 2

-- dit maakt opstarten extreem langzaam, waarom?
-- vim.opt.clipboard:append("unnamedplus")
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Houdt 5 regels boven/onder vrij bijscrollen
vim.opt.scrolloff = 5

-- Enables 256b colors for terminals
--vim.opt.t_Co=256

vim.opt.backspace = "indent,eol,start"


-- Save undo history
vim.opt.undofile = true

-- vim.wo.signcolumn = 'yes'

-- vim.cmd [[colorscheme onedark]]

vim.api.nvim_set_option("clipboard","unnamedplus")
