" Set not compatible with vi
set nocompatible

filetype on

call plug#begin('~/local/vim/plug_config')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'

Plug 'mattn/emmet-vim'
Plug 'junegunn/limelight.vim'
Plug 'jiangmiao/auto-pairs'

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


" VISUAL FILE BROWSING
let g:netrw_banner=0        " disable banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to right
let g:netrw_liststyle=3     " tree view


let g:limelight_conceal_ctermfg = 235
let g:limelight_paragraph_span = 1

" CREATE SIDE FILE EXPLORER
nnoremap ,f <Esc><C-W>v:edit .<CR><C-W>100<<C-W>30>

" LIMELIGHT MAPPINGS
nnoremap <Leader>l :Limelight<CR>
inoremap <Leader>l :Limelight<CR>

" COPY DEFAULT SKELETON FORMAT
nnoremap ,html :-1read ~/.vim/.skeleton.html<CR>3jwf>a
nnoremap ,cpp :-1read ~/.vim/.skeleton.cc<CR>G2kA
nnoremap ,usaco :-1read ~/.vim/.skeletonusaco.cc<CR>G2kA

" OTHER MAPPINGS
nnoremap ,goSearch :<silent>!bash ~/Desktop/Other/Coding/google.sh
nnoremap <C-S> :w<CR>
nnoremap ,q :q<CR>
nnoremap ,x :x<CR>
nnoremap r <C-R>
vnoremap f :zf<CR>
nnoremap <Tab> <S-A>
nnoremap ; :

" TAB NAVIGATION
nnoremap tt :tabnew 
nnoremap ,to :call TABOptions()
nnoremap H gT
nnoremap L gt

" WINDOW NAVIGATION
nnoremap <Up>    <C-W>k
nnoremap <Down>  <C-W>j
nnoremap <Left>  <C-W>h
nnoremap <Right> <C-W>l

" WINDOW RESIZING
nnoremap <C-H> <C-W><
nnoremap <C-L> <C-W>>
nnoremap <C-J> <C-W>-
nnoremap <C-K> <C-W>+


" CUSTOM COMMANDS
command! -nargs=* CPP :call CPPCompile(<f-args>)
command! -nargs=* CC :call BlockComment(<f-args>)

" FUNCTIONS
" function! TABOptions()
" 	call popup_menu([':tabnew', ':tabedit', ':tabc'],#{
" 				\ callback: ('s:selectedCommand')
" 				\ })
" endfunction

function! Focus()
	:set cursorline
	:set cursorcolumn
endfunction

function! BlockComment(start, end)
	execute 'normal! '. a:start. 'GO/*'
	execute 'normal! '. a:end. 'Go*/'
endfunction

function! SmartTab()
	if getline('.') =~ '^\s*$'
		silent! execute "normal \<S-S>"
		echo "empty"
	else
		silent! execute "normal \<S-A>"
		echo "not empty"
	endif
endfunction


function! AutoComplete()
	if v:char =~ '\K'
		\ && getline('.')[col('.') - 3] !~ '\K'
		" \ && getline('.')[col('.') - 3] =~ '\K'
		\ && getline('.')[col('.') - 2] =~ '\K'
		\ && getline('.')[col('.') - 1] !~ '\K'
		
		silent! call feedkeys("\<C-N>", 'n')
		silent! call feedkeys("\<C-P>", 'n')
	end
endfunction


function MyFoldText()
	let ln = getline(v:foldstart)
	let nl = v:foldend - v:foldstart + 1
	let linetext = substitute(ln, "^ *", "", 1)
	return '+ ' . linetext . ' : length ' . nl
endfunction
set foldtext=MyFoldText()


au InsertEnter * :set nocursorline
au InsertEnter * :set nocursorcolumn
au WinEnter * :set cursorline
" au InsertCharPre * :call AutoComplete()

au BufNewFile,BufRead,BufEnter * :silent loadview
au BufLeave,BufWinLeave * :mkview

au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

" Navigating complete menu
inoremap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
inoremap <expr> <Down> pumvisible() ? "<C-N>" : "<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-P>" : "<Up>"
" Select complete menu item
inoremap <expr> <Right> pumvisible() ? "<C-Y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-Y>" : "<CR>"
" Cancels complete menu
inoremap <expr> <Left> pumvisible() ? "<C-E>" : "<Left>"
" Save
inoremap <C-S> <Esc>:w<CR>i
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
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>

" GENERAL CONFIG
syntax on

set backspace=indent,eol,start

set fillchars+=vert:\
set fillchars=fold:\ 
set completeopt=menuone,preview,noinsert,noselect
set completepopup=align:item,border:on
filetype plugin on
set omnifunc=syntaxcomplete#Complete

set tabstop=4 softtabstop=4
set shiftwidth=4
set number
set scl=yes
set showcmd
set noshowmode
set nostartofline
set autoindent
set smartindent
set ruler
set incsearch
set cmdheight=2
set pumheight=20
set nowrap
set showmatch
set list
set hlsearch

set listchars=tab:\│\ 

set mouse=a
set mousemodel=extend

set foldcolumn=1

" CUSTOM STATUSLINE
function! Mode()
	let l:MODE = mode()
	return {'i': 'INSERT', 'n': 'NORMAL', 'v': 'VISUAL', 'R': 'REPLACE'}[l:MODE]
endfunction

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_section_z = "%3p%% %l:%c"
let g:airline_detect_modified=1

set laststatus=2
set statusline=
set statusline+=\ %#Pmenu#
set statusline+=\ %{Mode()}\ \|\ %f\ %m\ \|\ lines:\ %L
set statusline+=\ %#CursorColumn#
set statusline+=\ %= " left align
set statusline+=\ %y
set statusline+=\ %r
set statusline+=\ line\ %l:%c


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
hi CursorColumn ctermbg=darkgrey
hi Cursor ctermbg=grey
hi NonText ctermfg=yellow

hi MatchParen ctermbg=white

hi SpecialKey ctermfg=darkgrey

hi Underlined ctermfg=blue

hi include ctermfg=187
hi macro ctermfg=187


" folds
hi Folded ctermfg=252 ctermbg=234
hi foldcolumn ctermfg=252 ctermbg=234

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
h
