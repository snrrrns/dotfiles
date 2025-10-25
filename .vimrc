" マークダウンはvim-poluglotを対象外にする
let g:polyglot_disabled = ['markdown']

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
" クリップボードの共有
set clipboard=unnamed

" カラースキーマの指定
colorscheme molokai
" 構文ごとに文字色を変化
syntax on

"""""""""""""""""""""""""""""""""""""
" プラグインのセットアップ
"""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" シンタックスハイライトに対応するファイルを拡張
Plug 'sheerun/vim-polyglot'
" インデントの可視化
Plug 'nathanaelkane/vim-indent-guides'
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
" gitの差分を表示
Plug 'airblade/vim-gitgutter'
" emmetが利用できる
Plug 'mattn/emmet-vim'
call plug#end()
""""""""""""""""""""""""""""""""""""""

" 背景色を記号の列と一致
let g:gitgutter_set_sign_backgrounds = 1
" 記号色を設定
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" vimを立ち上げた時にvim-indent-guidesが自動起動する
let g:indent_guides_enable_on_vim_startup = 1
" 可視化を行う改装を設定
let g:indent_guides_start_level = 2
" 可視化領域のサイズ
let g:indent_guides_guide_size = 1
" 可視化を無効化するファイルを指定
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']

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
