" 挙動を vi 互換ではなく、Vim のデフォルト設定にする設定
set nocompatible
" スワップファイルは使わない
set noswapfile
" タブ文字の表示幅
set tabstop=2
" インデント幅
set shiftwidth=2
" 行番号を表示
set number
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]]
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 256色に対応
set t_Co=256
" カラースキーマの指定
colorscheme molokai
" 構文ごとに文字色を変化
syntax on

"""""""""""""""""""""""""""""""""""""
" プラグインのセットアップ
"""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" ファイルオープンを便利に
Plug 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
Plug 'Shougo/neomru.vim'
" シンタックスハイライトに対応するファイルを拡張
Plug 'sheerun/vim-polyglot'
" インデントの可視化
Plug 'nathanaelkane/vim-indent-guides'
" ファイルをtree表示
Plug 'scrooloose/nerdtree'
" Ruby向けにendを自動挿入する
Plug 'tpope/vim-endwise'
" コメントON/OFFを手軽に実行
Plug 'tomtom/tcomment_vim'
" シングルクオートをダブルクオートの入れ替え等
Plug 'tpope/vim-surround'
" 行末の半角スペースを可視化
Plug 'bronson/vim-trailing-whitespace'
" 閉じカッコを補完
Plug 'cohama/lexima.vim'

call plug#end()
""""""""""""""""""""""""""""""""""""""

" マークダウンはvim-poluglotを対象外にする
let g:polyglot_disabled = ['markdown']

""""""""""""""""""""""""""""""""""""""
" Unite.vimの設定
""""""""""""""""""""""""""""""""""""""
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウインドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウインドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""""""""""

" vimを立ち上げた時にvim-indent-guidesが自動起動する
let g:indent_guides_enable_on_vim_startup = 1

" 全角スペースを可視化
function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd ColorScheme * call ZenkakuSpace()
	  autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
	augroup END
	call ZenkakuSpace()
endif

