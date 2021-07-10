" JGA settings

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
	"status regel onderin scherm - vervangen door airline
		"Plug 'itchyny/lightline.vim'
	"status bar
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		"syntax highlighting many languages
		Plug 'sheerun/vim-polyglot'
	"file manageri - prefer to use vifm or NNN
		"Plug 'scrooloose/NERDTree'
	"auto pair {{()}}
		Plug 'jiangmiao/auto-pairs'
	"spice up iconen for Nerdtree and airline"
		Plug 'ryanoasis/vim-devicons'
	"nnn plugin
		Plug 'mcchrish/nnn.vim'
	"vifm plugin - niet gebruikt meer beter met nnn
	 "Plug 'vifm/vifm.vim'
		Plug 'preservim/nerdcommenter'
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
		Plug 'junegunn/fzf.vim'
		Plug 'lambdalisue/suda.vim'
		Plug 'sainnhe/sonokai'

call plug#end()

let mapleader=" "
syntax enable
set ignorecase
set mouse=a
set tabstop=2
set showtabline=2
set expandtab
set number
set smartindent
set autoindent
"multiple buffers kunnen editen zonder ze eerst te saven
set hidden
set encoding=utf-8
set cmdheight=1
set cursorline
set clipboard+=unnamedplus
set termguicolors
set splitbelow
set splitright

" Enables 256b colors for terminals
set t_Co=256

"theme related settings
set background=dark


let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai

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
"set filetype for chezmoi templates
"	autocmd BufRead,BufNewFile *.tmpl setfiletype sh
	autocmd BufEnter vifmrc.tmpl setfiletype vifm
	autocmd BufEnter *.tmpl setfiletype sh
augroup END
"========================== KEYS =====================

"
"
"
"quickly load and reload(source) vimrc file
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>bn :tabnew<cr>
nnoremap <leader>bc :tabclose<cr>

nnoremap ; :
" remap escape to easier combination
inoremap jj <Esc>

"NNN override default die ook leader-n is
nnoremap <leader>n :NnnPicker %:p:h<CR>

"VIFM plugin - niet meer in gebruik
"nnoremap <leader>v :VsplitVifm<cr>

"fzf snelle toegang
nnoremap <leader>f Files<cr>

"custom scrolling
"nnoremap <M-j> <C-d>
"nnoremap <M-k> <C-u>
"
" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

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
"
" :n <naam> om een nieuwe buffer te openen,naam is optioneel
" :vnew om verticale split te maken met nieuwe buffer
" :ls om lijst van buffers te zien, % geeft huidige window aan
" :bd om buffer te sluiten (=bdelete <nr>)
" :bad <naam> maakt nwe buffer zonder window, naam verplicht (:badd zelfde)
"
" tab    = layout of windows
"					gt = gotab, ga naar volgende tab
"					:tabnew = creer tab



" TAB in normal mode will move to the next buffer
" niet gekozen <tab> switch window want meestal werken met 1 window
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>
"gebruik leader-l om te switchen tussen windows
"had ook w kunnen gebruiken maar l is makkelijker bereikbaar
nnoremap <leader>l <C-w>w<CR>

"shortcut splitting screen
nnoremap <leader>h :split<space>
nnoremap <leader>v :vsplit<space>

"==============================================================

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"nnoremap w!! w !sudo tee > /dev/null %
nnoremap wss w !sudo tee > /dev/null %


"moet de cursor regel gehighlight worden? onderstaand zet dit uit.
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

" ==== NNN
let g:nnn#set_defaults_mappings = 0
" let g:nnn#layout = { 'window': { 'width': 0.5, 'height': 0.95, 'highlight': 'Debug'  }  }
let g:nnn#layout = { 'right': '~40%'  }

" ==== NERD COMMENTER
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1"


" ==== AIRLINE PLUGIN
" dit geeft boven in beeld ofwel de buffers bij 1 tab ofwel de tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
"colortheme
let g:airline_theme='sonokai'
"this will automatically populate the g:airline symbols
"let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Display a short path in statusline: >
  let g:airline_stl_path_style = 'short'
" Display a only file name in statusline: >
"  let g:airline_section_c_only_filename = 1

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
