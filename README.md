# dotfiles

そのうちちゃんと作りたいと思っているdotfiles(物置)

## セットアップ

前提: Homebrewで `fish` / `peco` / `ghq` / Cousine Nerd Font を導入済みで、
`~/dotfiles` にこのリポジトリをcloneしていること。
既存の設定ファイルがある場合は事前に退避・削除しておく。

```bash
mkdir -p ~/.config/ghostty ~/.config/herdr

ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -s ~/dotfiles/herdr/config.toml ~/.config/herdr/config.toml
```

iTerm2のカラースキーム(`iterm2/colors/tokyo-night-default.itermcolors`)は
iTerm2の Preferences > Profiles > Colors > Color Presets > Import から読み込む。
