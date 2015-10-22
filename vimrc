"Pathogen load
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on 
colorscheme desert

set history=50
set encoding=utf8
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set textwidth=80
set formatoptions+=t
set number
set mouse=a
set t_Co=256
set cursorline
set showmatch

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim 
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

let python_highlight_all = 1
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_syntax_all = 1

let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

map <F2> :NERDTreeToggle<CR>
