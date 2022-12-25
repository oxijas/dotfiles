local opt = vim.opt

opt.number = true
opt.wrap = false
-- geen plus laten zien bij overloop
opt.showbreak = ''

opt.ignorecase = true
opt.smartcase = true

-- we hoeven de regel van de cursor niet te highlighten
opt.cursorline = false
opt.termguicolors = true
opt.background = "dark"
opt.mouse = "a"
--opt.guicursor=i:block

-- met retab! kan je spaties vervangen door tabs, uitkijken binnen quotes
opt.tabstop = 3
opt.shiftwidth = 3
-- zet tabs wel/niet om in spaces automatisch
-- bij wel, kan je met CTRL-V tab alsnog echte tab zetten
opt.expandtab = false
opt.showtabline = 2
opt.smartindent = true
opt.autoindent = true
-- multiple buffers kunnen editen zonder ze eerst te saven
opt.hidden = true

opt.linebreak = true

opt.encoding = "utf-8"
opt.cmdheight = 1
opt.cursorline = false

-- heeft niets met tabs in doc te maken maar of je de tabline bovenin
-- scherm laat zien, 2 = always
opt.showtabline = 2

opt.clipboard:append("unnamedplus")
opt.splitbelow = true
opt.splitright = true

-- Houdt 5 regels boven/onder vrij bijscrollen
opt.scrolloff = 5

-- Enables 256b colors for terminals
--opt.t_Co=256

opt.backspace = "indent,eol,start"


-- Save undo history
opt.undofile = true

-- vim.wo.signcolumn = 'yes'

-- vim.cmd [[colorscheme onedark]]


