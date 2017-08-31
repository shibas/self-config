set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8

set number
set title
set showmatch

syntax on
set tabstop=2
set shiftwidth=2

set smartindent
set expandtab

set foldmethod=marker

set ignorecase
set smartcase
set wrapscan

set backspace=indent,eol,start


if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundl..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'
" ↓こんな感じが基本の書き方
" NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'PDV--phpDocumentor-for-Vim'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'nicklasos/vim-jsx-riot'
NeoBundle 'ryym/vim-riot'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'xsbeats/vim-blade'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'othree/html5.vim' 
NeoBundle 'heavenshell/vim-jsdoc'
NeoBundleLazy 'othree/yajs.vim', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy 'stephpy/vim-php-cs-fixer', {'functions': 'PhpCsFixerFixFile'}
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy 'leafgarland/typescript-vim', {'autoload' : {'filetypes' : ['typescript'] }}
NeoBundleLazy 'jason0x43/vim-js-indent', {'autoload' : {'filetypes' : ['javascript', 'typescript', 'html'],}}

NeoBundleCheck
call neobundle#end()

filetype plugin indent on
" どうせだから jellybeans カラースキーマを使ってみましょう
set t_Co=256
syntax on
set background=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid

autocmd BufRead,BufNewFile *.es6 setfiletype javascript

inoremap <C-P> <Esc>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocSingle()<CR>

" JSDoc
let g:jsdoc_enable_es6 = 1
let g:jsdoc_return = 1
let g:jsdoc_return_description = 1
let g:jsdoc_tags = {} | let g:jsdoc_tags['returns'] = 'return'
let g:jsdoc_default_mapping = 0
nnoremap <silent> <C-J> :JsDoc<CR>

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_php_checkers=['phpcs']
let g:syntastic_php_phpcs_args='--standard=psr2'

"let g:syntastic_javascript_checker = "jshint"
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_save = 1
"let g:syntastic_javascript_checkers = ['jshint', 'jslint']
let g:syntastic_javascript_checkers = ['eslint']

nnoremap <silent><leader>cd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>cf :call PhpCsFixerFixFile()<CR>
let s:hooks = neobundle#get_hooks('vim-php-cs-fixer')

function! s:hooks.on_source(bundle) abort "{{{
  let g:php_cs_fixer_path = "~/.vim/phpCsFixer/php-cs-fixer"
  let g:php_cs_fixer_config = 'default'
  let g:php_cs_fixer_dry_run = 0
  let g:php_cs_fixer_enable_default_mapping = 1
  "let g:php_cs_fixer_fixers_list = '-unalign_equals,-unalign_double_arrow,-psr0'
  let g:php_cs_fixer_fixers_list = '-psr0'
  let g:php_cs_fixer_level = 'psr2'
  let g:php_cs_fixer_php_path = 'php'
  let g:php_cs_fixer_verbose = 0
endfunction "}}}

" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" " この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1
let g:indent_guides_enable_on_vim_startup = 1
au BufNewFile,BufRead *.tag setlocal ft=javascript
augroup vimrc
  autocmd! FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4 autoindent
  autocmd! FileType blade setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd! FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2 autoindent
  "autocmd! FileType css  setlocal shiftwidth=2 tabstop=2 softtabstop=2
  "autocmd! FileType js  setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go'
call plug#end()

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/vundled')
Plugin 'VundleVim/Vundle.vim'
Plugin 'posva/vim-vue'
call vundle#end()            " required

let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <leader>b <Plug>(go-build)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_interfaces = 1

" vim-indent-guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2

" vim-vue-syntastic
autocmd BufNewFile,BufRead *.vue set filetype=vue autoindent
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_vue_checkers = ['eslint']
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
    let g:syntastic_javascript_eslint_exec = local_eslint
    let g:syntastic_vue_eslint_exec = local_eslint
endif

" typescript-vim
let g:js_indent_typescript = 1

