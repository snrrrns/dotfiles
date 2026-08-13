# 区切り文字やアイコン
set -l separator_triangle 
set -l icon_plus 
set -l icon_three_point_reader 
set -l icon_asease \U1f605
set -l icon_smile \U1f60a
set icon_home 
set icon_folder 

# 区切り文字の名前を登録
set segment_separator $separator_triangle
set icon_miss $icon_asease
set icon_ok $icon_smile

# バーの色
set color_user
set color_git_status_bar

# gitの状態(1プロンプト描画あたり1回だけ取得してキャッシュする)
set git_is_repo 0
set git_branch ''
set git_dirty 0

# 区切り
function _segment
    set_color -b $argv[1] $argv[2]
    echo -n "$segment_separator "
end

# ディレクトリを表示
function _prompt_dir
    if [ $HOME = $PWD ]
        printf ' %s ' $icon_home
    else
        printf ' %s ' $icon_folder
    end

    printf ' %s ' (prompt_pwd)
    _segment $color_user $color_dark
end

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

# ユーザー名を表示
function _prompt_user
    printf '%s ' (set_color $white)(whoami)

    if [ $git_is_repo = 1 ]
        _change_color_git_status_bar
        _segment $color_git_status_bar $color_user
    else
        _segment normal $color_user
    end
end

# gitのステータスごとにバーの色が変化
function _change_color_git_status_bar
    if [ $git_dirty = 1 ]
        set color_git_status_bar $color_git_dirty
    else
        set color_git_status_bar $color_git_main
    end
end

function _prompt_git
    if [ $git_is_repo = 1 ]
        _change_color_git_status_bar
        set_color -b $color_git_status_bar
        printf '%s ' (set_color $black)$git_branch
        _segment normal $color_git_status_bar
    end
end

function fish_prompt
    set -l last_status $status

    _fetch_git_status

    set_color -b $color_dark $white

    if [ $last_status -gt 0 ]
        echo -n " $icon_miss "
        set color_user $color_warning
    else
        echo -n " $icon_ok "
        set color_user $color_main
    end

    _prompt_dir
    _prompt_user
    _prompt_git
end
