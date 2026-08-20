# 使いたい色の変数(Tokyo Nightのパレット)
set -l blue             7aa2f7
set -l light_blue       7dcfff
set -l green            9ece6a
set -l dark_green       3b4261
set -l red              f7768e
set -l pink             bb9af7
set -l light_pink       bb9af7
set -l orange           ff9e64
set -l yellow           e0af68

# 白と黒は誰が見ても同じなので、グローバルに登録
set -g white            c0caf5
set -g black            1a1b26

# 抽象的な名前でグローバルに登録
set -g color_dark       24283b
set -g color_discreet   565f89

set -g color_main       $blue
set -g color_main_light $light_blue
set -g color_warning    $red

# git color
set -g color_git_main   $green
set -g color_git_dirty  $yellow

# fish color
set -g fish_color_normal            $white                          # デフォルトの色
set -g fish_color_autosuggestion    $color_discreet                 # コマンドの提案の色
set -g fish_color_cancel            --background=$color_main        # 「^c」の色
set -g fish_color_command           $color_main_light               # コマンドの色
set -g fish_color_comment           $color_discreet                 # コメントの色
set -g fish_color_end               $color_main_light               # ; や & などの色
set -g fish_color_error             $red                            # エラーの色
set -g fish_color_escape            $color_discreet                 # \n や \x70 などのエスケープ文字の色
set -g fish_color_match             --background=$color_main_light  # 検索した文字とマッチした時の背景色
set -g fish_color_operator          $light_pink                     # パラメータ演算子の色
set -g fish_color_param             $light_pink                     # 変数
set -g fish_color_search_match      --background=$color_main        # Tab候補の選択などでの背景色
set -g fish_color_selection         --background=$dark_green        # vi、選択モードで選択された部分の背景色
set -g fish_color_quote             $light_pink                     # echo ''など

set -g fish_pager_color_progress    $color_main_light               # Tabキーで表示される補完一覧の、左下に表示される文字の色
set -g fish_pager_color_completion  $white                          # Tabキーで表示される補完一覧の文字色
set -g fish_pager_color_prefix      $color_main_light               # Tabキーで表示される補完一覧の、一致した文字の色
