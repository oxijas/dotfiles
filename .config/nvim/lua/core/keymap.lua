vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local opts2 = { noremap = true }

-- general keymap
keymap.set("i", "jj", "<ESC>", opts)
keymap.set("n", "-", "<End>", opts)
-- niet silent maken
keymap.set("n", ";", ":")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


-- Remap for dealing with word wrap
-- geen idee wat dit doet
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})



--================= BUFFERS - WINDOWS - TABS ===================
-- beter om met buffers/windows te werken dan met tabs, tabs is gewoon een layout
-- de 'tabs' boven in beeld kunnen zowel buffers als tabs weergeven, staat erbij.
-- 
-- dus tab = collection of windows
-- window is bepaald gedeelte van het scherm
-- buffer = geheugenstuk dat in een window gedisplayed wordt
--
-- buffer = in memory of a file
--	<TAB> = ga naar volgende buffer! dus niet volgende tab
-- window = viewport on a buffer
--	you can have multiple windows for same buffer
--	ctrl-w c = close window
--	ctrl-w v/h = vert/hor split
-- CTRL-W + hoofdletter HJKL verplaatst het hele window
-- bij nnn plugin is <leader>ho een plaating in een nw window
-- :n <naam> om een nieuwe buffer te openen,naam is optioneel
-- :vnew om verticale split te maken met nieuwe buffer
-- :ls om lijst van buffers te zien, % geeft huidige window aan
-- :bd om buffer te sluiten (=bdelete <nr>)
-- :bad <naam> maakt nwe buffer zonder window, naam verplicht (:badd zelfde)
-- :sav <fname> sla op onder een andere naam
-- :close alleen window closen, buffer behouden
--
-- tab		= layout of windows
--					gt = gotab, ga naar volgende tab
--					:tabnew = creer tab
-- keymap.set("n", "<TAB>",  ":bnext<CR>", opts)
-- keymap.set("n", "<S-TAB>",  ":bprevious<CR>", opts)


-- we hebben het omgedraaid - tab is naar volgende window
-- en leader+TAB is naar volgende buffer
-- keymap.set("n", "<TAB>",  "<C-W>w", opts)
-- keymap.set("n", "<S-TAB>",  "<C-W>W", opts)

-- buffer
keymap.set("n", "<TAB>",  ":bnext<CR>", opts)
keymap.set("n", "<S-TAB>",  ":bprev<CR>", opts)

-- windows
keymap.set("n", "<leader>wc", "<C-w>q", opts)
keymap.set("n", "<leader>wn", ":vne<CR>", opts)

--buffers
keymap.set("n", "<leader>bc", ":bd<CR>", opts)
keymap.set("n", "<leader>bn", ":vne<CR>", opts)


-- splitting screen horizontal / vertical = window new
keymap.set("n", "<leader>wh", ":split<CR>", opts)
keymap.set("n", "<leader>wv", ":vsplit<CR>", opts)
-- use resize the window
-- keymap.set("n", "M-j",  ":vertical resize -2<CR>", opts)
-- keymap.set("n", "M-k",  ":vertical resize +2<CR>", opts)
-- keymap.set("n", "M-h",  ":horizontal resize -2<CR>", opts)
-- keymap.set("n", "M-l",  ":horizontal resize +2<CR>", opts)

keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>")

-- custom scrolling
-- halve pagina is standaard ctrl-u / ctrl-d
keymap.set("n", "{", "<PageUp>", opts)
keymap.set("n", "}", "<PageDown>", opts)


