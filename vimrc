" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" TODO: use junegunn/vim-plug instead of Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UTILITY
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'scrooloose/nerdtree'  " Tree file browser
Plugin 'majutsushi/tagbar'  " Tag tree and browser
" Plugin 'BufOnly.vim'  " Deletes non-active buffers
" Plugin 'wesQ3/vim-windowswap'  " Swaps window panes
" Plugin 'ctrlpvim/ctrlp.vim'  " Fuzzy file search
Plugin 'junegunn/fzf.vim'  " Fuzzy file search
" Plugin 'godlygeek/tabular'  " Auto tabulation of text
" Plugin 'benmills/vimux'  " tmux interaction within vim
" Plugin 'gilsondev/searchtasks.vim'  " Search for TODO, FIXME, XXX
" Plugin 'tpope/vim-dispatch'  " Async task runner
Plugin 'romainl/vim-cool'  " hls only on search
Plugin 'tpope/vim-obsession'  " Session persistance


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMPLETE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Simple
"   Plugin 'ervandew/supertab' 
" Deprecated
"   Plugin 'Shougo/neocomplete.vim'
" Complex
"   Plugin 'Shougo/deoplete.nvim'  " needs python3 compatibility and a couple submodules
"     Plugin 'roxma/nvim-yarp'
"     Plugin 'roxma/vim-hug-neovim-rpc'
"     " pip3 install --user pynvim
    Plugin 'ycm-core/YouCompleteMe'  " <--- good, needs python stuff
"     " > Vim 7.4.1578 with Python 2 or Python 3 support
"     " sudo apt install build-essential cmake python3-dev
"     " cd ~/.vim/bundle/YouCompleteMe
"     " python3 install.py 
"       " C-lang family :  --clangd-completer 
"       " C# :  install Mono and --cs-completer
"       " Go :  install Go and --go-completer
"       " TS/node :  install nodejs and npm and --ts-completer
"       " Rust :  --rust-completer
"       " Java :  install JDK8 and --java-completer
"   Plugin 'neoclide/coc.nvim' <--- good, needs node
"     " install nodejs


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TABS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JUST USE BUFFERGATOR
Plugin 'jeetsukumaran/vim-buffergator'  " Buffer manager
" Plugin 'fholgado/minibufexpl.vim'
" Plugin 'jlanzarotta/bufexplorer'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin 'SirVer/ultisnips
"   " Compatible with deoplete and YouCompleteMe
"   " Snippets are separated from the engine. Add this if you want them:
"     Plugin 'honza/vim-snippets'
"   " Trigger configuration. Do not use <tab> if you use YouCompleteMe.
"     let g:UltiSnipsExpandTrigger="<tab>"
"     let g:UltiSnipsJumpForwardTrigger="<c-b>"
"     let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"   " If you want :UltiSnipsEdit to split your window.
"     let g:UltiSnipsEditSplit="vertical"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Programming Support
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   " TODO: find a plugin that will auto-do the jjko sequence on <enter>
Plugin 'Raimondi/delimitMate'  "eclipse-liek closing tokens, compatible with YCM
" INCOMPATIBLE WITH YOUCOMPLETEME :
" Plugin 'Townk/vim-autoclose'  " eclipse-like closing tokens
Plugin 'tomtom/tcomment_vim'  " easy commenting
Plugin 'scrooloose/syntastic'  " code errors
Plugin 'tmhedberg/matchit'  " for matching HTML tags with '%'
Plugin 'tpope/vim-surround'  " tools for surrounding text
Plugin 'alvan/vim-closetag'  " auto-close HTML tags
Plugin 'mattn/emmet-vim'  " HTML easy insertion syntax
"   " ex: for HTML5 skeleton: html:5, <c-y>,
" Plugin 'honza/vim-snippets'  " JUST USE ULTISNIPS, although this is simpler
" Plugin 'janko-m/vim-test'  " Unit test runner
" Plugin 'maksimr/vim-jsbeautify'  " HTML, CSS and JS formatter
"   " needs nodejs and js-beautify


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TAGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   " exuberant ctags
"     sudo apt install exuberant-ctags
"     " go to docroot
"     ctags -R -f /path/to/output/tagfile .
"     :set tags=/path/to/output/tagfile ", if needed
Plugin 'xolox/vim-misc'  " Dependency for vim-easytags
Plugin 'xolox/vim-easytags'  " Auto-updates exuberant-ctags


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown / Writing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin 'reedes/vim-pencil'  " adds things like wrapping
" Plugin 'jtratner/vim-flavored-markdown'  " syntax highlighting for markdown
" Plugin 'LanguageTool'  " grammar checker 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript Support
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'pangloss/vim-javascript'  " JS syntax highlighting and indentation


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP Support
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin 'shawncplus/phpcomplete'  " Extension of default phpcomplete
"   " Requires autorun and universal-ctags
Plugin 'captbaritone/better-indent-support-for-php-with-html'  " what it says
" Plugin 'StanAngeloff/php.vim'
" Plugin 'phpvim/phpcd.vim'
"   " requires phpenmod: PCNTL, JSON
"   " run `composer install` in phpcd.vim directory
" Plugin 'tobyS/pdv'  " generate php doc blocks
"   " requires ultisnip


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Themes and interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'altercation/vim-colors-solarized'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'dracula/vim'
" Plugin 'sjl/badwolf'
" Plugin 'tomasr/molokai'
" Plugin 'morhetz/gruvbox'
" Plugin 'junegunn/limelight.vim'
" Plugin 'mkarmona/colorsbox'
" Plugin 'chriskempson/base16-vim'
" Plugin 'atelierbram/Base2Tone-vim'
"   " optional, recommended: k-takata/minpac
 
 
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHOW LINENUMBER
set number
set ruler

" SET TABS
set tabstop=2
set shiftwidth=2
set smarttab
set autoindent
set expandtab
set softtabstop=2

" ALWAYS DISPLAY THE STATUS LINE
set laststatus=2

" HIGHLIGHTING
set cursorline
set hls
 
" MISC UTILITY
set incsearch
" set cursorcolumn
syntax enable


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS AND THEMES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" t_Co = 256

" Only needed if terminal does NOT use solarized colors:
let g:solarized_termcolors=256 

" if (has("termguicolors"))
"   set termguicolors
" endif

set background=dark
" set background=light

" let base16colorspace=256 "Access colors present in 256 colorspace
"   colorscheme base16-default-dark
"   colorscheme spacegray
"     let g:spacegray_underline_search = 1
"     let g:spacegray_italicize_comments = 1
"colorscheme solarized
"let g:airline_theme='solarized'
" AirlineTheme solarized
" let g:airline_theme='airline-theme-solarized'  " need this?
" let g:airline_solarized_bg='dark'
" let g:airline_solarized_bg='light'

" colorscheme badwolf
" let g:airline_theme='badwolf'

" colorscheme molokai
" let g:airline_theme='molokai'

" colorscheme gruvbox

" color dracula
" let g:airline_theme='dracula'

" BASE2TONE DARK
" set background=dark
" call minpac#add('k-takata/minpac', {'type': 'opt'})
" call minpac#add('atelierbram/Base2Tone-vim')
" colorscheme Base2Tone_EveningDark
" colorscheme Base2Tone_MorningDark
" colorscheme Base2Tone_SeaDark
" colorscheme Base2Tone_SpaceDark
" colorscheme Base2Tone_EarthDark
" colorscheme Base2Tone_ForestDark
" colorscheme Base2Tone_DesertDark
" colorscheme Base2Tone_LakeDark
" colorscheme Base2Tone_MeadowDark
" colorscheme Base2Tone_DrawbridgeDark
" colorscheme Base2Tone_PoolDark
" colorscheme Base2Tone_HeathDark
" colorscheme Base2Tone_CaveDark
" BASE2TONE LIGHT
" set background=light
" colorscheme Base2Tone_EveningLight
" colorscheme Base2Tone_MorningLight
" colorscheme Base2Tone_SeaLight
" colorscheme Base2Tone_SpaceLight
" colorscheme Base2Tone_EarthLight
" colorscheme Base2Tone_ForestLight
" colorscheme Base2Tone_DesertLight
" colorscheme Base2Tone_LakeLight
" colorscheme Base2Tone_MeadowLight
" colorscheme Base2Tone_DrawbridgeLight
" colorscheme Base2Tone_PoolLight
" colorscheme Base2Tone_HeathLight
" colorscheme Base2Tone_CaveLight
" BASE2TONE DARK AIRLINE
" let g:airline_theme='Base2Tone_EveningDark'
" let g:airline_theme='Base2Tone_MorningDark'
" let g:airline_theme='Base2Tone_SeaDark'
" let g:airline_theme='Base2Tone_SpaceDark'
" let g:airline_theme='Base2Tone_EarthDark'
" let g:airline_theme='Base2Tone_ForestDark'
" let g:airline_theme='Base2Tone_DesertDark'
" let g:airline_theme='Base2Tone_LakeDark'
" let g:airline_theme='Base2Tone_MeadowDark'
" let g:airline_theme='Base2Tone_DrawbridgeDark'
" let g:airline_theme='Base2Tone_PoolDark'
" let g:airline_theme='Base2Tone_HeathDark'
" let g:airline_theme='Base2Tone_CaveDark'
" BASE2TONE LIGHT AIRLINE
" let g:airline_theme='Base2Tone_EveningLight'
" let g:airline_theme='Base2Tone_MorningLight'
" let g:airline_theme='Base2Tone_SeaLight'
" let g:airline_theme='Base2Tone_SpaceLight'
" let g:airline_theme='Base2Tone_EarthLight'
" let g:airline_theme='Base2Tone_ForestLight'
" let g:airline_theme='Base2Tone_DesertLight'
" let g:airline_theme='Base2Tone_LakeLight'
" let g:airline_theme='Base2Tone_MeadowLight'
" let g:airline_theme='Base2Tone_DrawbridgeLight'
" let g:airline_theme='Base2Tone_PoolLight'
" let g:airline_theme='Base2Tone_HeathLight'
" let g:airline_theme='Base2Tone_CaveLight'

" HORIZONTAL LIMIT COLORS
" set cc=81,121
highlight ColorColumn ctermbg=235 guibg=#2c2d27
execute "set colorcolumn=" . join(range(81,335), ',')


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Supertab Configuration
" let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" Deoplete
" let g:deoplete#enable_at_startup = 1

" Tagbar
map <C-m> :TagbarToggle<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 
" let g:airline_theme='hybrid'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
 
" Default fzf layout
set rtp+=~/.fzf
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
nnoremap <C-p> :Files<Cr>

" NERDTree
" Toggle hidden files in NERDTree by default
let NERDTreeShowHidden=1
" Automatically start NERDTree
autocmd vimenter * NERDTree
" Automatically start NERDTree even with no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim if NERDTree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Auto focus the file instead of NERDTree
autocmd VimEnter * wincmd p | NERDTreeFind | wincmd p
" Open the focused file in NERDTree (THIS MESSES WITH VERTICAL OPENS)
" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif

" Vim-PDV Configuration
" let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
 
" Markdown Syntax Support
" augroup markdown
"     au!
"     au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
" augroup END
 
" " Settings for Writing
" let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
" let g:languagetool_jar  = '/opt/languagetool/languagetool-commandline.jar'
 
" Vim-pencil Configuration
" augroup pencil
"   autocmd!
"   autocmd FileType markdown,mkd call pencil#init()
"   autocmd FileType text         call pencil#init()
" augroup END
 
" Vim-UtilSnips Configuration
" " Trigger configuration. Do not use <tab> if you use YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsEditSplit="vertical"  " If you want :UltiSnipsEdit to split your window.
 
" " Vim-Test Configuration
" let test#strategy = "vimux"


""""""""""""""""""""""""""""""""""""""
" MAPPINGS
""""""""""""""""""""""""""""""""""""""
imap jj <Esc>

" use \zz to toggle scrolling of cursor
set scrolloff=999
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Omnicomplete Better Nav
" inoremap <expr> <c-j> ("\<C-n>")
" inoremap <expr> <c-k> ("\<C-p>")

" CtrlP
" nnoremap <Leader>O :CtrlP<CR>

" FZF 
nnoremap <Leader>o :Files<CR>
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Mapping selecting Mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Vim-Test Mappings
" nmap <silent> <leader>t :TestNearest<CR>
" nmap <silent> <leader>T :TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>
 
" Vim-PDV Mappings
" autocmd FileType php inoremap <C-p> <ESC>:call pdv#DocumentWithSnip()<CR>i
" autocmd FileType php nnoremap <C-p> :call pdv#DocumentWithSnip()<CR>
" autocmd FileType php setlocal omnifunc=phpcd#CompletePHP
 
" Enable Elite mode
let g:elite_mode=1
" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
	nnoremap <Up>    :resize +2<CR>
	nnoremap <Down>  :resize -2<CR>
	nnoremap <Left>  :vertical resize +2<CR>
	nnoremap <Right> :vertical resize -2<CR>
endif
" map <silent> <LocalLeader>ws :highlight clear ExtraWhitespace<CR>

" Reference: https://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html
"
