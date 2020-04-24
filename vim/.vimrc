" ==============================================================================
" basic configuration

set relativenumber
syntax on
set tabstop=2
set shiftwidth=4

" ==============================================================================
" Plugins

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'tomasiser/vim-code-dark'
Plug 'sheerun/vim-polyglot'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'preservim/nerdtree'

call plug#end()

" ==============================================================================
" CoC configuration

set hidden

set nobackup
set nowritebackup

set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

let g:coc_global_extensions = [
	\ 'coc-snippets',
	\ 'coc-pairs',
	\ 'coc-tsserver',
	\ 'coc-prettier',
	\ 'coc-json',
	\ 'coc-git'
\]

" Use Tab for trigger completion

inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>":
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" ==============================================================================
" Lightlane configuration

set laststatus=2
set noshowmode

if !has('gui_running')
	set t_Co=256
endif

colorscheme codedark

let g:lightline = {
	\ 'colorscheme': 'powerline',
	\ 'active': {
	\ 'left': [ [ 'mode', 'paste' ],
	\ 	     [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\},
	\ 'component_function': {
	\		'gitbranch': 'gitbranch#name'
	\}
	\}

" ==============================================================================
"  vim-indent-guides configurations

let g:indent_guides_guide_size=1
"let g:indent_guides_enable_on_vim_startup=1


" ==============================================================================
"  NERDTree configuration

autocmd vimenter * NERDTree

" open NERDTree automatically when vim starts up if no file name provided
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif





