vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- general keymap
keymap.set("i", "jj", "<ESC>", opts)
keymap.set("n", "-", "<End>", opts)
-- niet silent maken
keymap.set("n", ";", ":")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- custom scrolling
keymap.set("n", "M-j", "<PageUp>")
-- keymap.set("n", "<leader>p", "<PageUp>")
keymap.set("n", "M-k", "<PageDown>")

-- use alt + hjkl to resize window
keymap.set("n", "M-h",  ":vertical resize -2<CR>", opts)
keymap.set("n", "M-l",  ":vertical resize +2<CR>", opts)

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
keymap.set("n", "<TAB>",  ":bnext<CR>", opts)
keymap.set("n", "<S-TAB>",  ":bprevious<CR>", opts)
-- switchen tussen windows
keymap.set("n", "<leader>l", ":wincmd w<CR>", opts)
keymap.set("n", "<leader>h", ":wincmd h<CR>", opts)
keymap.set("n", "<leader>j", ":wincmd j<CR>", opts)
keymap.set("n", "<leader>k", ":wincmd k<CR>", opts)
-- close window
keymap.set("n", "<leader>wc", "<C-w>c", opts)
-- close buffer
keymap.set("n", "<leader>bd", ":bd<CR>", opts)

-- splitting screen
keymap.set("n", "<leader>o", ":split<CR>", opts)
keymap.set("n", "<leader>v", ":vsplit<CR>", opts)

keymap.set("n", "<leader>,", ":NvimTreeToggle<CR>")
-- keymap.set("n", "<leader>[", ":NnnPicker %:p:h<CR>")
-- keymap.set("n", "<leader>f", ":NnnExplorer %:p:h<CR>")
-- keymap.set("n", "<leader>f", ":Lf<CR>")
-- keymap.set("n", "<leader>f", ":NnnExplorer<CR>")


