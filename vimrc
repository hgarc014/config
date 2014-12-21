"runtime bundles/tplugin_vim/macros/tplugin.vim
"
"============================= General config =============================
set number                                  "show numbers
set mouse=a                                 "use mouse

set viminfo-=<50,s10                        "allow vim to copy lots of lines
set history=1000                            "Store lots of :cmdline history

set showcmd                                 "Show incomplete cmds down the bottom
set showmode                                "Show current mode down the bottom
set autoread                                "Reload files changed outside vim
set linebreak                               "Wrap lines at convenient points

"set nowrap                                  "Don't wrap lines
"set backspace=indent,eol,start              "Allow backspace in insert mode
"set visualbell                              "screen flash on errors

set guioptions=
set spell spelllang=en_us
syntax on
filetype plugin on

autocmd BufNewFile,BufReadPost *.md set filetype=markdown   "add md as markdown filetype
nnoremap Q <nop>                                            "remove annoying ex-mode feature
au BufWinLeave * mkview                                     "restore old state of file on reload
"au BufWinEnter * silent loadview

"============================= Tab completion =============================
set wildmode=longest,list,full
set wildmenu

"============================= History across vim sessions =============================
if has('persistent_undo')
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile
endif

"============================= Distinguish Parens (),{},etc =============================
set showmatch
hi MatchParen cterm=underline ctermbg=none ctermfg=lightcyan

"============================= Indentation =============================
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
nmap <S-Tab> <<
imap <S-Tab> <Esc><<i
" Old indent settings
" set autoindent
" set smarttab
" set softtabstop=4
 filetype plugin on
 filetype indent on

"============================= Color Highlighting =============================
set term=xterm-256color

hi clear SpellBad
hi clear SpellLocal
hi clear SpellCap
hi clear SpellRare
hi SpellBad cterm=underline
hi SpellLocal cterm=none
hi SpellCap cterm=underline
hi SpellRare cterm=underline

hi Comment cterm=none ctermfg=4             "comment color
hi Constant cterm=none ctermfg=1            "constant color (strings etc)
hi Identifier cterm=none ctermfg=6          "variable color
hi Statement cterm=none ctermfg=green       "if, else, +, -, etc color
hi PreProc cterm=none ctermfg=5             "pre processor stuff, #, etc
hi Type cterm=none ctermfg=2                "variable type, char, int, etc
hi Special cterm=none ctermfg=5             "special characters like \n

hi VarId cterm=none ctermfg=11              "not sure what this is
hi Normal cterm=none ctermfg=7              "normal text color

"============================= Spell Checking =============================
fun! IgnoreCamelCaseSpell()
    syn match CamelCase /<[A-Z][a-z]+[A-Z].{-}>/ contains=@NoSpell transparent
    syn cluster Spell add=CamelCase
endfun
autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()

"============================= Auto Insert Brackets =============================
"  :inoremap ( ()<Esc>i
"  inoremap { {<CR><BS>}<Esc>ko

