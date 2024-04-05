filetype on

call plug#begin('~/local/vim/plug_config')
	
	Plug 'sheerun/vim-polyglot'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'nvim-tree/nvim-web-devicons'
	
	Plug 'mattn/emmet-vim'
	Plug 'junegunn/limelight.vim'
	Plug 'jiangmiao/auto-pairs'
	
	Plug 'wfxr/minimap.vim'
	
call plug#end()

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

source $HOME/.vim/plug_config/coc.vim


" FILE SEARCHING
" search subfolders when using :find
" tab-completion for anything file related
set path+=**
" DISPLAY ALL MATCHING FILES FOR TAB-COMPLETE
set wildmenu

" Python provider
let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.7/bin/python3'

" VISUAL FILE BROWSING
let g:netrw_banner=0		" disable banner
let g:netrw_browse_split=4	" open in prior window
let g:netrw_altv=1			" open splits to right
let g:netrw_liststyle=3		" tree view

let g:minimap_width=12
let g:minimap_auto_start=1
let g:minimap_auto_start_win_enter=1

let g:limelight_conceal_guifg = 235
let g:limelight_paragraph_span = 1


let g:mapleader=" "

" CREATE SIDE FILE EXPLORER
nnoremap <leader>f <Esc><C-W>v:edit .<CR><C-W>100<<C-W>30>

" LIMELIGHT MAPPINGS
nnoremap <Leader>l :Limelight!!0.7<CR>

" COPY DEFAULT SKELETON FORMAT
nnoremap ,html :-1read ~/.vim/.skeleton.html<CR>3jwf>a
nnoremap ,cpp :-1read ~/.vim/.skeleton.cc<CR>G2kA
nnoremap ,usaco :-1read ~/.vim/.skeletonusaco.cc<CR>G2kA

" OTHER MAPPINGS
nnoremap r <C-R>
nnoremap <Tab> <S-A>
nnoremap ; :
cnoremap <C-N> <C-G>
cnoremap <C-P> <C-T>

" TAB NAVIGATION
nnoremap <leader>t :tabnew 
nnoremap H gT
nnoremap L gt

" WINDOW NAVIGATION
nnoremap <Up>	 <C-W>k
nnoremap <Down>  <C-W>j
nnoremap <Left>  <C-W>h
nnoremap <Right> <C-W>l

" WINDOW RESIZING
nnoremap <C-H> <C-W><
nnoremap <C-L> <C-W>>
nnoremap <C-J> <C-W>-
nnoremap <C-K> <C-W>+


au InsertEnter * set cursorline nocursorcolumn
au WinEnter * set cursorline
set cursorline

au BufNewFile,BufRead,BufEnter *.* silent loadview
au BufLeave,BufWinLeave *.* mkview

au BufReadPost,BufNewFile *.o %!xxd :set ft=xxd

au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif


set updatetime=300
" navigating complete menu
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1) :
	\ CheckBackspace() ? "<TAB>" :
	\ coc#refresh()
inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : ""
inoremap <silent><expr> <C-J> coc#pum#visible() ? coc#pum#next(1) : "j"
inoremap <silent><expr> <C-K> coc#pum#visible() ? coc#pum#prev(1) : "k"
" select complete menu item
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() :
	\ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" cancel complete menu
inoremap <silent><expr> <ESC> coc#pum#visible() ? coc#pum#cancel() : "<ESC>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction



autocmd CursorHold * silent call CocActionAsync('highlight')


" Terminal emulator
tnoremap <Esc> <C-\><C-N>


" AutoPair config
let AutoPairsFlyMode=1
au FileType html let b:AutoPairs = AutoPairsDefine({'<!--':'-->', '<':'>'})


" Slower Scrolling
noremap <ScrollWheelUp> <C-Y>k
noremap <ScrollWheelDown> <C-E>j

" GENERAL CONFIG
set title

if !has('gui_running')
	set t_Co=256
endif


set backspace=indent,eol,start

let statuscolumn='%s%=%{v:relnum?v:relnum:v:lnum} %C'


function MyFoldText()
	let ln = getline(v:foldstart)
	let nl = v:foldend - v:foldstart + 1
	let linetext = substitute(ln, "^ *", "", 1)
	return '[ ' . linetext . ' : length ' . nl . ' ]'
endfunction
set foldtext=MyFoldText()
set fillchars=fold:\ 
set fillchars+=foldclose:►
set fillchars+=foldopen:▼
set foldcolumn=1

set signcolumn=auto

filetype plugin on
set completeopt=menuone,preview,noinsert,noselect
set smarttab
set tabstop=4 softtabstop=4
set shiftwidth=4


set number relativenumber numberwidth=4
set scl=yes
set showcmd
set noshowmode
set nostartofline
set incsearch
set inccommand
set cmdheight=2
set pumheight=20
set nowrap
set showmatch
set list

set termguicolors
set t_Co=256
let &t_Cs = "\e[60m"

set autoindent
set listchars=tab:\│\ 
filetype plugin indent on

" match highlighting on when searching, off when done
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

set mouse=a
set mousemodel=extend


" ------------------------------------
" HIGHLIGHTING
" ------------------------------------

" VIM EDITOR HIGHLIGHTING
syntax on
colorscheme slate

hi Pmenu guifg=LightGray guibg=#1a1a1a
hi PmenuSel gui=bold guifg=Cyan guibg=#252525
hi def link PmenuKind Pmenu
hi PmenuThumb guibg=#252525

hi Visual gui=none guifg=LightGray guibg=#306080

hi Directory guifg=#9DD9D2

hi VertSplit guibg=none

hi LineNr guifg=Gray guibg=#0e0e0e
hi CursorLine guibg=#080808
hi CursorLineNr gui=bold guifg=LightGray guibg=#080808
hi Cursor guibg=Gray

hi TabLineSel guifg=LightGray guibg=#306080

" CODE RELATED
hi Normal guifg=LightGray
hi NonText guifg=Yellow

hi MatchParen guibg=White

hi SpecialKey guifg=DarkGray

hi Underlined gui=underline guifg=blue

hi include guifg=#F4D06F
hi macro guifg=#F4D06F

" LEFT COLUMN
hi Folded guifg=LightGray guibg=#0e0e0e
hi foldcolumn guifg=White guibg=#0e0e0e
hi signcolumn guibg=#0e0e0e

hi Function gui=bold guifg=#e1e289

" TYPES AND VALUES
hi Type guifg=#0f88d4

hi Constant guifg=130

hi Number guifg=Orange
hi String guifg=LightGreen
hi Character guifg=LightGreen
hi Boolean guifg=LightRed

" OTHER
hi Comment gui=italic guifg=white guibg=#3f3f3f
hi Statement guifg=#f34213
hi Conditional guifg=#f34213
hi Repeat guifg=#f34213
hi Operator guifg=#ffd700
