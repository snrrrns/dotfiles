# アイコン
set -l icon_asease \U1f605
set -l icon_smile \U1f60a
set icon_miss $icon_asease
set icon_ok $icon_smile

# 現在の状態色(成功/失敗で切り替える)
set color_status

# gitの状態(1プロンプト描画あたり1回だけ取得してキャッシュする)
set git_is_repo 0
set git_branch ''
set git_dirty 0

# gitの状態をまとめて1回のgit呼び出しで取得する
# (以前はrev-parse×2 + status×2 + symbolic-ref×1 = 5プロセスに分かれていた)
function _fetch_git_status
    set git_is_repo 0
    set git_branch ''
    set git_dirty 0

    set -l lines (command git --no-optional-locks status --porcelain=v2 --branch --no-ahead-behind --ignore-submodules=dirty 2>/dev/null)
    or return

    set git_is_repo 1
    for line in $lines
        if string match -q '# branch.head *' -- $line
            set git_branch (string replace -r '^# branch\.head ' '' -- $line)
        else if not string match -q '#*' -- $line
            set git_dirty 1
        end
    end
end

# ディレクトリを表示(文字色にステータス色を使う)
function _prompt_dir
    set_color --bold $color_status
    printf '%s' (prompt_pwd)
    set_color normal
end

# gitブランチを表示(dirtyなら黄色+✗、cleanなら緑)
function _prompt_git
    if [ $git_is_repo = 1 ]
        set_color $color_discreet
        printf ' on '
        if [ $git_dirty = 1 ]
            set_color $color_git_dirty
        else
            set_color $color_git_main
        end
        printf '⎇ %s' $git_branch

        if [ $git_dirty = 1 ]
            printf ' ✗'
        end

        set_color normal
    end
end

function fish_prompt
    set -l last_status $status

    _fetch_git_status

    if [ $last_status -gt 0 ]
        echo -n "$icon_miss "
        set color_status $color_warning
    else
        echo -n "$icon_ok "
        set color_status $color_main
    end

    _prompt_dir
    _prompt_git

    # 情報行と入力行を分離し、幅が狭くても入力行が崩れないようにする
    echo
    set_color $color_status
    echo -n "❯ "
    set_color normal
end
