# 区切り文字やアイコン
set -l separator_triangle \ue0b0
set -l icon_plus \uf067
set -l icon_three_point_reader \uf015
set -l icon_asease \U1f605
set -l icon_smile \U1f60a
set icon_home \uf015
set icon_folder \uf07c

# 区切り文字の名前を登録
set segment_separator $separator_triangle
set icon_miss $icon_asease
set icon_ok $icon_smile

# バーの色
set color_user
set color_git_status_bar

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

# ユーザー名を表示
function _prompt_user
    printf '%s ' (set_color $white)(whoami)

    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        _change_color_git_status_bar
        _segment $color_git_status_bar $color_user
    else
        _segment normal $color_user
    end
end

# gitのステータスごとにバーの色が変化
function _change_color_git_status_bar
    if [ (_is_git_dirty) ]
        set color_git_status_bar $color_git_dirty
    else
        set color_git_status_bar $color_git_main
    end
end

# gitのステータスがdirtyかどうか
function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function _prompt_git
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
        _change_color_git_status_bar
        set_color -b $color_git_status_bar
        printf '%s ' (set_color $black)$git_branch
        _segment normal $color_git_status_bar
    end
end

function fish_prompt
    set -l last_status $status

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
