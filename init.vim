""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Info                                                                     @info
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" # About
"
" Author: Daniil Velichko <danvelduck@gmail.com>
"
" # Keymap 
"
" All custom commands are categorized under leader.
" <leader>[<category>]<map>
"
" Some common commands have alternate mapping with <space>-<map>
"
" ## Meta
" 
" <leader>mc : open vim config
" <leader>mr : reload vim config
" <leader>mu : open undo editor
"
" ## File
"
" <leader>ft | <space>t : show file tree
" <leader>fp | <space>p : go to file in project
" <leader>fs | <space>/ : search in files under CWD
" <leader>fa | <space>. : go to alternate file
"
" ## Window
"
" <C-j> : move to next window below
" <C-k> : move to next window above
" <C-h> : move to next window to the left
" <C-l> : move to next window to the right
"
" ## Buffer
"
" <leader>bb | <space>b : go to opened buffer
" <leader>br | <space>r : go to recently used buffer
" <leader>bs | <space>s : save buffer
" <leader>/             : disable search highlighting
"
" ## Text
" 
" <leader>ta | <space>a : align text
" <leader>ts | <space>, : search in project for text for the next movement
"
" ## Code
"
" <leader>cd | <space>d : go to definition
" <leader>cu | <space>d : show usages
" <leader>ci | <space>i : show info about symbol under cursor
" <leader>cr            : rename symbol under cursor
"
" # Native keymap
" 
" Just a reference for useful native commands
"
" ## Window
"
" <C-w>q : close current window
" <C-w>o : close all windows except current
" <C-w>= : resize all windows equally
" <C-w>r : swap window position
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                               @plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" # Init
"
call plug#begin('~/.local/share/nvim/plugged')
"
" # Integration
"
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
"
" # Appearance
"
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
"
" # Navigation
"
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'uptech/alt'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'dyng/ctrlsf.vim'
"
" # Utility
"
Plug 'roxma/nvim-completion-manager'
Plug 'sjl/gundo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
"
" # Languages
"
Plug 'leafgarland/typescript-vim'
Plug 'mhartington/nvim-typescript'
"
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim configuration                                                   @vimconfig
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" # General
"
let mapleader=","
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
"
" # Editing
"
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
"
" UI
"
set termguicolors
set background=dark
colorscheme gruvbox
hi Normal ctermbg=NONE guibg=NONE
set wildmenu
set mouse=a
set showtabline=0
set noshowmode
set lazyredraw
set hidden
set relativenumber
set noshowmatch
set shortmess+=c
set fillchars=
set splitbelow
set splitright
set wmh=0
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration                                            @pluginconfig
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" lightline
"
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }
let g:lightline.colorscheme = 'gruvbox'
"
" nerdtree
"
let NERDTreeMinimalUI=1
"
" gitgutter
"
let g:gitgutter_map_keys = 0
"
" ale
"
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_linters = {
\   'javascript': ['eslint'],
\ }
let g:ale_fixers = {
\   'javascript': ['prettier_eslint'],
\ }
"
" alt
"
function! AltCommand(path, vim_command)
	let l:alternate = system("find . -path ./_site -prune -or -path ./target -prune -or -path ./.DS_Store -prune -or -path ./build -prune -or -path ./Carthage -prune -or -path tags -prune -or -path ./tmp -prune -or -path ./log -prune -or -path ./.git -prune -or -path ./dist -prune -or -path ./node_modules -prune -or -type f -print | alt -f - " . a:path)
	if empty(l:alternate)
		echo "No alternate file for " . a:path . " exists!"
	else
		exec a:vim_command . " " . l:alternate
	endif
endfunction
"
" LeaderF
"
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_ShortcutF = '<leader>fp'
let g:Lf_ShortcutB = '<leader>bb'
let g:Lf_DefaultMode= 'FullPath'
let g:Lf_CursorBlink = 0

function! s:getTermColor(group)
  let termColor = synIDattr(hlID(a:group), "fg", "cterm")
  return  termColor
endfunction

function! s:getGuiColor(group)
  let guiColor = synIDattr(hlID(a:group), "fg", "gui")
  return guiColor
endfunction

let s:termbg0  = s:getTermColor('GruvboxBg0')
let s:termbg1  = s:getTermColor('GruvboxBg1')
let s:termbg2  = s:getTermColor('GruvboxBg2')
let s:termbg4  = s:getTermColor('GruvboxBg4')
let s:termfg1  = s:getTermColor('GruvboxFg1')
let s:termfg4  = s:getTermColor('GruvboxFg4')

let s:guibg0  = s:getGuiColor('GruvboxBg0')
let s:guibg1  = s:getGuiColor('GruvboxBg1')
let s:guibg2  = s:getGuiColor('GruvboxBg2')
let s:guibg4  = s:getGuiColor('GruvboxBg4')
let s:guifg1  = s:getGuiColor('GruvboxFg1')
let s:guifg4  = s:getGuiColor('GruvboxFg4')


let s:termyellow = s:getTermColor('GruvboxYellow')
let s:termblue   = s:getTermColor('GruvboxBlue')
let s:termaqua   = s:getTermColor('GruvboxAqua')
let s:termorange = s:getTermColor('GruvboxOrange')
let s:termgreen  = s:getTermColor('GruvboxGreen')
let s:termred    = s:getTermColor('GruvboxRed')
let s:termpurple = s:getTermColor('GruvboxPurple')

let s:guiyellow = s:getGuiColor('GruvboxYellow')
let s:guiblue   = s:getGuiColor('GruvboxBlue')
let s:guiaqua   = s:getGuiColor('GruvboxAqua')
let s:guiorange = s:getGuiColor('GruvboxOrange')
let s:guigreen  = s:getGuiColor('GruvboxGreen')
let s:guired    = s:getGuiColor('GruvboxRed')
let s:guipurple = s:getGuiColor('GruvboxPurple')

let s:palette = {
            \   'stlName': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': s:guibg0,
            \       'guibg': s:guiyellow,
            \       'cterm': 'bold',
            \       'ctermfg': s:termbg0,
            \       'ctermbg': s:termyellow
            \   },
            \   'stlCategory': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': s:guibg0,
            \       'guibg': s:guiaqua,
            \       'cterm': 'NONE',
            \       'ctermfg': s:termbg0,
            \       'ctermbg': s:termaqua
            \   },
            \   'stlNameOnlyMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': s:guibg0,
            \       'guibg': s:guiblue,
            \       'cterm': 'NONE',
            \       'ctermfg': s:termbg0,
            \       'ctermbg': s:termblue
            \   },
            \   'stlFullPathMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': s:guibg0,
            \       'guibg': s:guipurple,
            \       'cterm': 'NONE',
            \       'ctermfg': s:termbg0,
            \       'ctermbg': s:termpurple
            \   },
            \   'stlFuzzyMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': s:guibg0,
            \       'guibg': s:guired,
            \       'cterm': 'NONE',
            \       'ctermfg': s:termbg0,
            \       'ctermbg': s:termred
            \   },
            \   'stlRegexMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': s:guibg0,
            \       'guibg': s:guigreen,
            \       'cterm': 'NONE',
            \       'ctermfg': s:termbg0,
            \       'ctermbg': s:termgreen
            \   },
            \   'stlCwd': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': s:guifg1,
            \       'guibg': s:guibg2,
            \       'cterm': 'NONE',
            \       'ctermfg': s:termfg1,
            \       'ctermbg': s:termbg2
            \   },
            \   'stlBlank': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': s:guifg4,
            \       'guibg': s:guibg2,
            \       'cterm': 'NONE',
            \       'ctermfg': s:termbg4,
            \       'ctermbg': s:termbg2
            \   }
            \ }

let s:palette.stlLineInfo = s:palette.stlCwd
let s:palette.stlTotal = s:palette.stlName

let g:Lf_StlPalette = s:palette
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom code                                                            @custom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymap                                                                 @keymap
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" # Vim
"
nnoremap j gj
nnoremap k gk

nmap <leader>mc :e $MYVIMRC<cr>
nmap <leader>mr :so $MYVIMRC<cr>

nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

nnoremap <leader>bs :w<cr>
nnoremap <space>s :w<cr>

nmap <silent> ,/ :nohlsearch<cr>
"
" # nvim-completion-manager
"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
" # nerdtree
"
nnoremap <silent> <leader>t :NERDTreeToggle<cr>
nnoremap <silent> <space>t :NERDTreeToggle<cr>
"
" LeaderF
"
nnoremap <leader>fp :LeaderfFile<cr>
nnoremap <space>p :LeaderfFile<cr>

nnoremap <leader>bb :LeaderfBuffer<cr>
nnoremap <space>b :LeaderfBuffer<cr>

nnoremap <leader>br :LeaderfMru<cr>
nnoremap <space>r :LeaderfMru<cr>
"
" # CtrlSF
"
nnoremap <leader>fs :CtrlSF<space>
nnoremap <space>/ :CtrlSF<space>

nnoremap <leader>ts :CtrlSF<cr>
nnoremap <space>, :CtrlSF<cr>
"
" # gundo
"
nnoremap <leader>mu :GundoToggle<cr>
"
" # vim-easy-align
"
nmap <leader>ta <Plug>(EasyAlign)
xmap <space>a <Plug>(EasyAlign)
"
" # alt
"
nnoremap <leader>fa :w<cr>:call AltCommand(expand('%'), ':e')<cr>
nnoremap <space>. :w<cr>:call AltCommand(expand('%'), ':e')<cr>
"
" # nvim-typescript
"
autocmd FileType typescript nnoremap <leader>cd :TSDef<cr>
autocmd FileType typescript nnoremap <space>d :TSDef<cr>

autocmd FileType typescript nnoremap <leader>cu :TSRefs<cr>
autocmd FileType typescript nnoremap <space>u :TSRefs<cr>

autocmd FileType typescript nnoremap <leader>ci :TSType<cr>
autocmd FileType typescript nnoremap <space>i :TSType<cr>

autocmd FileType typescript nnoremap <leader>cr :TSRename<cr>
