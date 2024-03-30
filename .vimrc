filetype on

call plug#begin('~/local/vim/plug_config')
	
	Plug 'sheerun/vim-polyglot'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	Plug 'vim-airline/vim-airline'
	
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

let g:limelight_conceal_ctermfg = 235
let g:limelight_paragraph_span = 1

" CREATE SIDE FILE EXPLORER
nnoremap ,f <Esc><C-W>v:edit .<CR><C-W>100<<C-W>30>

" LIMELIGHT MAPPINGS
nnoremap <Leader>l :Limelight!!0.7<CR>

" COPY DEFAULT SKELETON FORMAT
nnoremap ,html :-1read ~/.vim/.skeleton.html<CR>3jwf>a
nnoremap ,cpp :-1read ~/.vim/.skeleton.cc<CR>G2kA
nnoremap ,usaco :-1read ~/.vim/.skeletonusaco.cc<CR>G2kA

" OTHER MAPPINGS
nnoremap r <C-R>
vnoremap f :zf<CR>
nnoremap <Tab> <S-A>
nnoremap ; :
cnoremap <C-N> <C-G>
cnoremap <C-P> <C-T>

" TAB NAVIGATION
nnoremap ,t :tabnew 
" nnoremap ,to :call TABOptions()<CR>
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


" FUNCTIONS
" function! TABOptions()
"	call popup_menu([':tabnew', ':tabedit', ':tabc'],#{
"				\ callback: ('s:selectedCommand')
"				\ })
" endfunction

function! BlockComment(start, end)
	execute 'normal! '. a:start. 'GO/*'
	execute 'normal! '. a:end. 'Go*/'
endfunction


au InsertEnter * set cursorline nocursorcolumn
au WinEnter * set cursorline

au BufNewFile,BufRead,BufEnter *.* silent loadview
au BufLeave,BufWinLeave *.* mkview

au BufReadPost,BufNewFile *.o %!xxd :set ft=xxd

au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif


" Navigating complete menu
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1) :
	\ CheckBackspace() ? "<Tab>" :
	\ coc#refresh()
inoremap <silent><expr> j coc#pum#visible() ? coc#pum#next(1) : "j"
inoremap <silent><expr> k coc#pum#visible() ? coc#pum#prev(1) : "k"
" Select complete menu item
inoremap <silent><expr> <RIGHT> coc#pum#visible() ? coc#pum#confirm() : "<RIGHT>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() :
	\ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Cancels complete menu
inoremap <expr> <LEFT> coc#pum#visible() ? coc#pum$cancel() : "<LEFT>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction


autocmd CursorHold * silent call CocActionAsync('highlight')


" Comment current line
nnoremap <C-C> 0wi//<Esc>
inoremap <C-C> <Esc>0wi//<Esc>``i
" Comment visual selection lines
vnoremap <C-C> <Esc>:'<,'>s!^!//!<cr>:noh<cr>

" Terminal emulator
tnoremap <Esc> <C-\><C-N>


" AutoPair config
au FileType html let b:AutoPairs = AutoPairsDefine({'<!--':'-->', '<':'>'})


" nnoremap <expr> <S-F> (GetCurrentChar() =~ '(') ? "%x``x" :":echo GetCurrentChar()<cr>"

" Slower Scrolling
noremap <ScrollWheelUp> <C-Y>k
noremap <ScrollWheelDown> <C-E>j

" GENERAL CONFIG
set title

set t_Co=256

syntax on

set backspace=indent,eol,start

let statuscolumn='%=%{v:relnum?v:relnum:v:lnum} %C%s'



function MyFoldText()
	let ln = getline(v:foldstart)
	let nl = v:foldend - v:foldstart + 1
	let linetext = substitute(ln, "^ *", "", 1)
	return '> ' . linetext . ' : length ' . nl . ' '
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
set cmdheight=2
set pumheight=20
set nowrap
set showmatch
set list

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


" CUSTOM STATUSLINE
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_section_z = "cursor %3.l:%2.c"
let g:airline_detect_modified=1


" ------------------------------------
" HIGHLIGHTING
" ------------------------------------

" syntax highlighting
colorscheme slate
hi Normal ctermfg=254
hi Pmenu ctermfg=white ctermbg=darkgrey
hi PmenuSel cterm=bold ctermfg=white ctermbg=DarkCyan

hi VertSplit ctermbg=233

hi LineNr ctermfg=darkgrey
hi CursorLine cterm=none ctermbg=234
hi Cursor ctermbg=grey
hi NonText ctermfg=yellow

hi MatchParen ctermbg=white

hi SpecialKey ctermfg=darkgrey

hi Underlined ctermfg=blue

hi include ctermfg=187
hi macro ctermfg=187

" folds
hi Folded ctermfg=252 ctermbg=234
hi foldcolumn ctermfg=252 ctermbg=235

hi Function cterm=bold ctermfg=172

" TYPES AND VALUES
hi Type ctermfg=darkblue
hi Constant ctermfg=130
hi Number ctermfg=117
hi String ctermfg=LightGreen
hi Character ctermfg=LightGreen
hi Boolean ctermfg=red

hi Comment cterm=italic ctermfg=white ctermbg=237
hi Statement ctermfg=red
hi Conditional ctermfg=197
hi Repeat ctermfg=197
