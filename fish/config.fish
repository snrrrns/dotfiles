if status is-interactive
    # Commands to run in interactive sessions can go here
end

# pecoとghqの連携でリポジトリを一覧表示
function peco_ghq
    set -l query (commandline)
    if test -n $query
        set peco_flags --query "$query"
    end
    ghq list --full-path | peco $peco_flags --layout=bottom-up | read recent
    if [ $recent ]
        cd $recent
        commandline -r ''
        commandline -f repaint
    end
end

# pecoとghqのバインディング
function fish_user_key_bindings
    bind \cr peco_select_history
    bind \cg peco_ghq
end

# エイリアス
alias rand='cat /dev/urandom | base64 | fold -w 16 | head -n 1'
alias dc='docker compose'

export LSCOLORS=Gxfxcxdxbxegedabagacad
