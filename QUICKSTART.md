# クイックスタートガイド

新しくセットアップした環境を最大限活用するための簡単なガイドです。

## 🚀 初回セットアップ（5分）

```bash
# 1. Nerd Fontのインストールと設定
./install-nerd-font.sh

# 2. iTerm2を設定（スクリプトの指示に従う）
# - Preferences → Profiles → Text
# - Font: JetBrainsMono Nerd Font
# - Non-ASCII Font: JetBrainsMono Nerd Font

# 3. iTerm2を完全に再起動
# Command+Q で終了 → 再起動

# 4. アイコン表示を確認
./test-icons.sh

# 5. 推奨ツールをインストール
./install-recommended-tools.sh

# 6. シェルを再読み込み
source ~/.zshrc
```

## 💡 今すぐ試せる便利機能

### ディレクトリ移動
```bash
# 普通のcd
cd ~/src/myproject

# zoxideで学習させる（何度か使うと記憶される）
z myproject    # 部分一致で移動！

# インタラクティブ選択
zi             # fzfで選択
```

### Git操作
```bash
# lazygit（最高に便利！）
lg             # または lazygit

# 操作方法:
# - j/k: 上下移動
# - スペース: ステージング
# - c: コミット
# - P: プッシュ
# - q: 終了
```

### ファイル検索
```bash
# ファイル名で検索（fzf）
vim $(fzf)

# 内容で検索（ripgrep + fzf）
rg "検索文字列" | fzf

# Vimから
# ,p でファイル検索
# ,f で文字列検索
```

### システム情報
```bash
# 美しいシステム情報
sysinfo        # または fastfetch

# システムモニター
btop

# プロセス一覧
procs
```

### コマンド修正
```bash
# わざと間違ったコマンドを実行
sl             # command not found

# 修正
fuck           # → ls に修正される！
```

### Docker管理
```bash
# Docker TUI
lzd            # または lazydocker

# イメージの中身を探索
dive nginx:latest
```

## 📝 Vimでメモを取る

### 集中執筆モード
```vim
" Vimを開く
vim memo.md

" 集中モードに入る（気が散る要素を非表示）
<Leader>g

" もう一度押すと通常モードに戻る
<Leader>g
```

### VimWiki（パーソナルWiki）
```vim
" メインページを開く
<Leader>ww

" 新しいページを作成
" 1. [[新しいページ]]と書く
" 2. Enterキーでリンク先を作成

" インデックスに戻る
<Leader>ww
```

### Undo履歴の可視化
```vim
" Vimで編集中に
<Leader>u

" ツリー構造でundo履歴を表示
" j/k で移動、Enter で選択
```

## 🔧 よく使うエイリアス

```bash
# Git
gs             # git status
gd             # git diff
gl             # git log --oneline --graph
lg             # lazygit

# ナビゲーション
..             # cd ..
...            # cd ../..
....           # cd ../../..

# システム
c              # clear
h              # history
sysinfo        # システム情報
proc           # プロセス一覧

# 編集
zshconfig      # ~/.zshrc を開く
vimconfig      # ~/.vimrc を開く
```

## 📚 もっと知りたい時

```bash
# コマンドのヘルプ（簡潔版）
tldr git

# 通常のman
man git

# HTTPリクエスト
http GET https://api.github.com/users/octocat

# JSONを整形して表示
cat data.json | jq

# Markdownをターミナルで表示
glow README.md
```

## ⚡ プロのTips

### 1. 履歴検索を活用
```bash
# Ctrl+R を押す → atuinの強力な検索画面が開く
# 過去のコマンドを瞬時に検索・実行
```

### 2. zoxideを育てる
```bash
# よく使うディレクトリに何度かcdする
cd ~/src/myproject
cd ~/Documents/notes
cd ~/Downloads

# 数回後からは...
z proj    # ~/src/myproject へジャンプ！
z notes   # ~/Documents/notes へジャンプ！
```

### 3. lazygitを使いこなす
```bash
lg

# ステージング: スペース
# コミット: c
# プッシュ: P
# プル: p
# ブランチ切り替え: b
# 差分表示: Enter
```

### 4. Vimで効率的にメモ
```vim
" 1. VimWikiを開く
<Leader>ww

" 2. 毎日のメモ
[[2025-12-18]]  " 日付のリンクを作成
<Enter>         " ページを開く

" 3. タスクリスト
- [ ] タスク1
- [X] 完了したタスク
```

### 5. JSONデータを探索
```bash
# APIからデータを取得して探索
curl -s https://api.github.com/users/octocat | fx

# インタラクティブに探索できる
```

## 🎨 カスタマイズ

### プロンプトの時間表示を変更
```bash
vim ~/.config/starship.toml

# time_format を編集
# "%H:%M:%S" → 24時間表示
# "%I:%M:%S %p" → 12時間表示
```

### エイリアスを追加
```bash
vim ~/.zsh_aliases

# 例
alias myproject='cd ~/src/myproject'
alias deploy='./scripts/deploy.sh'
```

### Vimのカラースキームを変更
```vim
" .vimrc を開く
vim ~/.vimrc

" colorscheme の行を変更
colorscheme gruvbox    " または dracula, catppuccin
```

## 🆘 困った時は

```bash
# README.mdを確認
glow README.md

# トラブルシューティングを見る
cat README.md | grep -A 10 "トラブルシューティング"

# 設定ファイルの場所
ls -la ~ | grep "^\."

# プラグインを再インストール
vim +PlugClean +PlugInstall +qall
```

## 🎯 次のステップ

1. **毎日使う**: zoxide、lazygit、fzfは毎日使うと手放せなくなります
2. **カスタマイズ**: 自分の workflow に合わせてエイリアスを追加
3. **探索**: `brew search` で新しいツールを探してみる
4. **共有**: チームメンバーにも教えてあげる

楽しい開発ライフを！ 🚀
