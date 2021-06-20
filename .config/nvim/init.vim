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
	"vifm plugin
		Plug 'vifm/vifm.vim'
		Plug 'preservim/nerdcommenter'
	"fzf
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
		Plug 'junegunn/fzf.vim'
	"sudavim om in sudo mode te saven
		Plug 'lambdalisue/suda.vim'
		"iceberg is dark rustgevend colorscheme
		Plug 'cocopon/iceberg.vim'
"		Plug 'sonph/onehalf'
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
"set filetype for chezmoi templates
"	autocmd BufRead,BufNewFile *.tmpl setfiletype sh
	autocmd BufEnter vifmrc.tmpl setfiletype vifm
	autocmd BufEnter *.tmpl setfiletype sh
augroup END
"========================== KEYS =====================

"quickly load and reload(source) vimrc file
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>bn :tabnew<cr>
nnoremap <leader>bc :tabclose<cr>

nnoremap ; :

"Ranger plugin toggle on/off
"nnoremap <leader>r :RnvimrToggle<CR>

"NNN override default die ook leader-n is
nnoremap <leader>n :NnnPicker %:p:h<CR>

"VIFM plugin
nnoremap <leader>v :VsplitVifm<cr>

"fzf snelle toegang
nnoremap <leader>f Files<cr>

" remap escape to easier combination
inoremap jj <Esc>
"inoremap <esc> <nop>

" Nerdtree
"nnoremap <M-[> :NERDTreeToggle<CR>

" Better windows management
function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
	if (t:curwin == winnr())
		if (match(a:key,'[jk]'))
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction
noremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

"custom scrolling
nnoremap <M-j> <C-d>
nnoremap <M-k> <C-u>

" Use alt + hjkl to resize windows
" nnoremap <M-j>    :resize -2<CR>
" nnoremap <M-k>    :resize +2<CR>
" nnoremap <M-h>    :vertical resize -2<CR>
" nnoremap <M-l>    :vertical resize +2<CR>

" Easy CAPS
"inoremap <c-u> <ESC>viwUi
"nnoremap <c-u> viwU<Esc>

" TAB in normal mode will move to the next buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

"nnoremap w!! w !sudo tee > /dev/null %
nnoremap wss w !sudo tee > /dev/null %

"shortcut splitting screen
"nnoremap <leader>h :split<space>
"nnoremap <leader>v :vsplit<space>

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
" let g:airline_theme = 'wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

"colortheme
"let g:airline_theme='molokai'
let g:airline_theme='onedark'

"this will automatically populate the g:airline symbols
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.whitespace = ' '

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''

