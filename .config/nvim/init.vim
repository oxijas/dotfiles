"	_	 ___		_____ __  __
" | \ | \ \   / /_ _|  \/	|
" |  \| |\ \ / / | || |\/| |
" | |\  | \ V /  | || |  | |
" |_| \_|  \_/  |___|_|  |_|
"
"de autoload directory wordt automatisch aangemaakt en
"gevuld met de plugings - niet in dotfiles meenemen.
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	 \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	"syntax highlighting many languages
	Plug 'sheerun/vim-polyglot'
	"auto pair {{()}}
	"Plug 'jiangmiao/auto-pairs'
	"spice up iconen for Nerdtree and airline
	Plug 'ryanoasis/vim-devicons'
	" nnn integratie, standaard is <leader>n
	Plug 'mcchrish/nnn.vim'
	" om iets als comment om te zetten gebruik gcc, of in visual gc
	Plug 'tpope/vim-commentary'
	" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
	" Plug 'junegunn/fzf.vim'
	Plug 'lambdalisue/suda.vim'
	Plug 'sainnhe/sonokai'
	Plug 'simeji/winresizer'
	" alternatieve colors
	" Plug 'drewtempelmeyer/palenight.vim'
	Plug 'ayu-theme/ayu-vim'

	" Volgende 2 plugins voor integration lf
	" standaard key is <leader> f, om te openen moet met lf open command,
	" standaard onder 'o' gemapped
	Plug 'ptzz/lf.vim'
   Plug 'voldikss/vim-floaterm'
call plug#end()

let mapleader=" "
syntax enable
set ignorecase
set mouse=a
set guicursor=i:block

let ayucolor="dark"
" let ayucolor="mirage"
" let ayucolor="light"

"je kan dit dynamisch aanpakken door live te veranderen
"met retab! kan je spaties vervangen door tabs, uitkijken binnen quotes
set tabstop=3
set shiftwidth=3
" zet tabs wel/niet om in spaces automatisch
" bij wel, kan je met CTRL-V tab alsnog echte tab zetten
set noexpandtab
" verschillende betekenis tab, begin regel=shiftwidth, ander tabstop
" verwarrend daarom uitgezte
set smartindent
set autoindent
"multiple buffers kunnen editen zonder ze eerst te saven
set hidden
set encoding=utf-8
set cmdheight=1
set nocursorline
" heeft niets met tabs in doc te maken maar of je de tabline bovenin
" scherm laat zien
set showtabline=2
set clipboard+=unnamedplus
set termguicolors
"set number relativenumber
set number
set splitbelow
set splitright
" Houdt 5 regels boven/onder vrij bijscrollen
set scrolloff=5
" Enables 256b colors for terminals
set t_Co=256
"theme related settings
set background=dark

let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
"colorscheme sonokai
colorscheme onehalfdark

" overloop/wordwrap
"set nowrap
set wrap
"laat geen plus zien bij overloop/wrap
set showbreak=
"zorg dat aleen hele woorden afgebroken worden bij wrap on
set linebreak

" Color column
"set colorcolumn=80

"highlight ColorColumn ctermbg=0 guibg=lightgrey
set listchars=tab:▸\ ,eol:¬
set list " To enable by default

"by default al on wrs
set filetype=on

augroup myau
" Remove all myau autocommands
	autocmd!
"remove trailing white spaces
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufEnter *.tmpl setfiletype sh
	autocmd BufEnter configrc setfiletype sh
	autocmd BufEnter tint2rc setfiletype sh
	autocmd BufEnter lfrc setfiletype sh
	autocmd BufEnter *.zsh-theme setfiletype zsh
	autocmd BufEnter vifmrc setfiletype vim
augroup END

augroup vimrc_help
	autocmd!
	autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

"========================== KEYS =====================
nnoremap ; :
" remap escape to easier combination
inoremap jj <Esc>

"NNN override default die ook leader-n is
nnoremap <leader>n :NnnPicker %:p:h<CR>

"custom scrolling
nnoremap <M-j> <C-d>
nnoremap <M-k> <C-u>
"
" Use alt + hjkl to resize windows
"nnoremap <M-j>		:resize -2<CR>
"nnoremap <M-k>		:resize +2<CR>
nnoremap <M-h>		:vertical resize -2<CR>
nnoremap <M-l>		:vertical resize +2<CR>

nnoremap <S-l>	<End>
nnoremap <S-h>	<Home>

"
" Easy CAPS
"inoremap <c-u> <ESC>viwUi
"nnoremap <c-u> viwU<Esc>

"================== BUFFERS - WINDOWS - TABS ===================
" beter om met buffers/windows te werken dan met tabs, tabs is gewoon een layout
" de 'tabs' boven in beeld kunnen zowel buffers als tabs weergeven, staat
" erbij.
"
" buffer = in memory of a file
"					<TAB> = ga naar volgende buffer! dus niet volgende tab
" window = viewport on a buffer
"					you can have multiple windows for same buffer
"					ctrl-w c = close window
"					ctrl-w v/h = vert/hor split
" CTRL-W + hoofdletter HJKL verplaatst het hele window
" bij nnn plugin is <leader>ho een plaating in een nw window
" :n <naam> om een nieuwe buffer te openen,naam is optioneel
" :vnew om verticale split te maken met nieuwe buffer
" :ls om lijst van buffers te zien, % geeft huidige window aan
" :bd om buffer te sluiten (=bdelete <nr>)
" :bad <naam> maakt nwe buffer zonder window, naam verplicht (:badd zelfde)
" :sav <fname> sla op onder een andere naam
" :close alleen window closen, buffer behouden
"
" tab		= layout of windows
"					gt = gotab, ga naar volgende tab
"					:tabnew = creer tab


" TAB in normal mode will move to the next buffer
" niet gekozen <tab> switch window want meestal werken met 1 window
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>
"gebruik leader-l om te switchen tussen windows
"had ook w kunnen gebruiken maar l is makkelijker bereikbaar
nnoremap <leader>l :wincmd w<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>

"shortcut splitting screen
nnoremap <leader>o :split<space>
nnoremap <leader>v :vsplit<space>

" nnoremap   <silent>   <F12>    :FloatermNew hexer %:p<CR>
nnoremap   <leader>\  :FloatermNew hexer %:p<CR>
nnoremap   <leader>t  :FloatermNew<CR>
"==============================================================

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"nnoremap w!! w !sudo tee > /dev/null %
nnoremap wss w !sudo tee > /dev/null %


"moet de cursor regel gehighlight worden? onderstaand zet dit uit.
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

" ==== NNN
let g:nnn#set_defaults_mappings = 0
let g:nnn#layout = { 'right': '~25%'  }
let g:nnn#command = 'nnn -acRHU'
let g:nnn#action = {
	\ '<leader>t': 'tab split',
  \ '<leader>o': 'split',
  \ '<leader>v': 'vsplit' }

" ===== floaterm

let g:floaterm_wintype='vsplit'
let g:floaterm_autoclose=1

" ==== lf
let g:lf_width = 0.7
let g:lf_height = 0.9

" nerd commenter vervangen door vim commentary - simpler
" <num>gcc  en <visual>gc
"
"
" ==== AIRLINE PLUGIN
" dit geeft boven in beeld ofwel de buffers bij 1 tab ofwel de tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
"colortheme
let g:airline_theme='sonokai'
" let g:airline_theme = "palenight"
"this will automatically populate the g:airline symbols
"let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	 let g:airline_symbols = {}
endif

let g:airline_detect_modified=1
let g:airline_symbols.whitespace = ' '
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''
