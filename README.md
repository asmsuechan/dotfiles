# Dotfiles

asmsuechanの開発環境設定ファイル集です。モダンなCLIツールと快適な開発体験を提供します。

## 環境構築手順

### クイックスタート

```bash
# リポジトリをクローン
git clone https://github.com/asmsuechan/dotfiles.git ~/dotfiles
cd ~/dotfiles

# セットアップスクリプトを実行（自動インストール）
./setup.sh

# ターミナルを再起動、またはzshを再読み込み
source ~/.zshrc
```

### 手動セットアップ

自動セットアップスクリプトを使わない場合は、以下の手順で設定できます。

#### 1. Homebrewのインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 2. 必須ツールのインストール

```bash
# シェルとプロンプト
brew install zsh starship

# モダンなCLIツール
brew install eza bat fd ripgrep fzf git-delta btop dust zoxide

# 開発ツール
brew install direnv rbenv nodenv pyenv go rust gh jq tree
```

#### 3. シンボリックリンクの作成

```bash
# zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zprofile ~/.zprofile

# vim
ln -s ~/dotfiles/.vimrc ~/.vimrc

# git
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

# tmux
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# starship
mkdir -p ~/.config
ln -s ~/dotfiles/.config/starship.toml ~/.config/starship.toml
```

#### 4. プラグインマネージャーのインストール

```bash
# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Vimプラグインをインストール
vim +PlugInstall +qall
```

#### 5. VSCode設定（VSCodeを使用している場合）

```bash
# settings.jsonをリンク
ln -s ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# 拡張機能をインストール
cat ~/dotfiles/vscode/extensions.txt | grep -v '^#' | grep -v '^$' | xargs -L 1 code --install-extension
```

#### 6. Nerd Fontのインストール（推奨）

Starshipとアイコン表示のために、Nerd Fontのインストールを推奨します。

1. [Nerd Fonts](https://www.nerdfonts.com/)から好みのフォントをダウンロード
2. 推奨フォント：JetBrains Mono Nerd Font、Fira Code Nerd Font
3. iTerm2の設定：Preferences → Profiles → Text → Font で設定

## 主要な機能

### シェル環境（zsh）

- **Starship**: 高速で美しいプロンプト
- **Vi Mode**: `jj`でノーマルモードに移行
- **自動補完**: 強化された補完機能
- **履歴検索**: Ctrl+P/N で履歴を検索
- **ディレクトリ移動**: `cd`すると自動的に`eza`で内容を表示

### モダンなCLIツール

| 従来のツール | モダンな代替 | 説明 |
|------------|------------|------|
| ls | eza | アイコン表示、Gitステータス対応 |
| cat | bat | シンタックスハイライト |
| find | fd | より高速で使いやすい検索 |
| grep | ripgrep | 超高速なコード検索 |
| cd | zoxide | よく使うディレクトリへ素早く移動 |
| top | btop | 美しいシステムモニター |
| du | dust | 視覚的なディスク使用量表示 |
| diff | delta | Gitの差分を美しく表示 |

### Vim設定

#### キーマップ

**基本操作**
- `jj`: ノーマルモードへ移行（インサートモード）
- `<ESC><ESC>`: ハイライト解除

**タブ操作**
- `<C-p>`: 右隣のタブに移動
- `<C-n>`: 左隣のタブに移動
- `<C-c>`: タブを閉じる

**ファイル・検索**
- `<C-e>`: NERDTreeトグル
- `,p`: ファイル検索（FZF）
- `,f`: 文字列検索（Ripgrep）
- `,b`: バッファ検索

**LSP・補完（Coc.nvim）**
- `gd`: 定義ジャンプ
- `gy`: 型定義ジャンプ
- `gi`: 実装ジャンプ
- `gr`: 参照を表示
- `K`: ドキュメント表示
- `<Tab>`: 補完候補を次へ
- `<S-Tab>`: 補完候補を前へ

**編集**
- `gcc`: 行コメントアウト（vim-commentary）
- `PP`: 0レジスタからペースト

**Git**
- `,gl`: GitGutter行ハイライトトグル

#### プラグイン

- **Coc.nvim**: LSPベースの補完
- **NERDTree**: ファイルツリー
- **FZF**: ファジーファインダー
- **Fugitive**: Git統合
- **GitGutter**: Git差分表示
- **vim-surround**: 括弧・クォート操作
- **vim-commentary**: コメント操作
- **Markdown Preview**: Markdownプレビュー
- **カラースキーム**: hybrid、gruvbox、dracula、catppuccin

### Git設定

#### エイリアス

```bash
git st        # status
git co        # checkout
git br        # branch
git l         # ログをグラフで表示
git ll        # 詳細なログ表示
git d         # diff
git dc        # diff --cached
git amend     # commit --amend
git cleanup   # マージ済みブランチを削除
git undo      # 最後のコミットを取り消し（変更は保持）
```

#### 機能

- **Delta**: 美しいdiff表示
- **自動プルーニング**: リモートで削除されたブランチを自動削除
- **自動リモート設定**: プッシュ時に自動でリモートブランチを設定
- **diff3スタイル**: コンフリクト解決時に共通祖先を表示

### VSCode設定

- **フォント**: JetBrains Mono、Fira Code（リガチャ有効）
- **自動保存**: 1秒後に自動保存
- **フォーマット**: 保存時に自動フォーマット
- **Vim拡張**: `jj`でノーマルモード移行
- **推奨拡張機能**: extensions.txtに記載

## ファイル構成

```
dotfiles/
├── .zshrc              # zsh設定（プラグイン、プロンプト、キーバインド）
├── .zprofile           # 環境変数、エイリアス、関数定義
├── .vimrc              # Vim設定とプラグイン
├── .gitconfig          # Git設定とエイリアス
├── .tmux.conf          # tmux設定
├── .config/
│   └── starship.toml   # Starshipプロンプト設定
├── vscode/
│   ├── settings.json   # VSCode設定
│   └── extensions.txt  # 推奨拡張機能リスト
├── setup.sh            # 自動セットアップスクリプト
└── README.md           # このファイル
```

## カスタマイズ

### プロンプトのカスタマイズ

Starshipの設定は `.config/starship.toml` で変更できます。

```bash
vim ~/.config/starship.toml
```

詳細は[Starship公式ドキュメント](https://starship.rs/config/)を参照。

### Vimプラグインの追加

`.vimrc`の`call plug#begin()`と`call plug#end()`の間にプラグインを追加し、以下を実行：

```bash
vim +PlugInstall +qall
```

### エイリアスの追加

個人用のエイリアスは `.zprofile` に追加してください。

## トラブルシューティング

### セットアップスクリプトが失敗する

**症状**: `declare -A symlinks` でエラーが出る

**原因**: macOSのデフォルトbashがバージョン3.xで連想配列をサポートしていない

**解決方法**:
```bash
# Homebrewでbash 4以降をインストール
brew install bash

# または、修正済みのスクリプトを再度git pullして使用
```

### zplugのインストールに失敗する

```bash
# Homebrewでインストール（推奨）
brew install zplug

# または手動でインストール
rm -rf ~/.zplug
git clone https://github.com/zplug/zplug ~/.zplug
```

### Vimプラグインがインストールされない

```bash
vim +PlugClean +PlugInstall +qall
```

### VSCode拡張機能のインストール中にクラッシュする

**症状**: セットアップスクリプトでVSCode拡張機能をインストール中に`FATAL ERROR: v8::ToLocalChecked Empty MaybeLocal`エラーが出る

**原因**: VSCode自体の既知の問題

**解決方法**:
```bash
# 専用のインストールスクリプトを使用（再試行に対応）
cd ~/dotfiles/vscode
./install-extensions.sh

# または、手動で1つずつインストール
code --install-extension <extension-id>
```

拡張機能は後からVSCodeのExtensions パネルから手動でインストールすることもできます。

### Starshipが表示されない

1. Starshipがインストールされているか確認: `which starship`
2. フォントがNerd Fontか確認
3. iTerm2のフォント設定を確認

### アイコンが文字化けする

Nerd Fontがインストールされていない可能性があります。上記「Nerd Fontのインストール」を参照。

### Homebrew がカスタムパスにインストールされている

Homebrewが標準パス以外（例：`$HOME/homebrew`）にある場合、`.zshrc`が自動的に検出します。
検出されない場合は、`.zprofile`に以下を追加：

```bash
export PATH="$HOME/homebrew/bin:$PATH"
```

## 便利なコマンド

### zsh

```bash
# ディレクトリへ素早く移動（zoxide）
z <ディレクトリ名の一部>

# fzfでファイルを開く
vim $(fzf)

# 履歴をfzfで検索
Ctrl+R
```

### Git

```bash
# マージ済みブランチを一括削除
git cleanup

# 直前のコミットを修正
git amend

# ブランチを日付順でソート
git recent
```

### Vim

```bash
# Markdownをプレビュー
:MarkdownPreview

# NERDTreeを開く/閉じる
Ctrl+e

# ファイルを検索
,p

# 文字列を検索
,f

# バッファを検索
,b

# タブ移動
Ctrl+p (右へ)
Ctrl+n (左へ)
```

## 対応環境

- **OS**: macOS（主にDarwin）
- **シェル**: zsh
- **エディタ**: Vim 8.0+、VSCode
- **ターミナル**: iTerm2（推奨）

## ライセンス

MIT License

## 更新履歴

- 2025-12: モダンなツールへアップデート（Starship、eza、bat等）
- 以前: 初期バージョン

## 参考リンク

- [Starship](https://starship.rs/)
- [eza](https://github.com/eza-community/eza)
- [bat](https://github.com/sharkdp/bat)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [delta](https://github.com/dandavison/delta)
- [vim-plug](https://github.com/junegunn/vim-plug)
- [zplug](https://github.com/zplug/zplug)
