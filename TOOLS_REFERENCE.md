# ツールリファレンス

インストールされているツールとその使い方のクイックリファレンスです。

## 📂 ファイル・ディレクトリ操作

| ツール | コマンド | 説明 |
|--------|----------|------|
| eza | `l`, `ll`, `tree` | モダンなls（アイコン付き） |
| fd | `fd <pattern>` | 高速ファイル検索 |
| broot | `br` | インタラクティブなディレクトリツリー |
| zoxide | `z <dir>` | スマートcd（学習型） |

### 例
```bash
l                    # カレントディレクトリを表示
tree                 # ツリー表示
fd "*.js"           # JavaScriptファイルを検索
z dotfiles          # dotfilesディレクトリへジャンプ
```

## 🔍 検索・テキスト処理

| ツール | コマンド | 説明 |
|--------|----------|------|
| ripgrep | `rg <pattern>` | 超高速grep |
| fzf | `fzf` | ファジーファインダー |
| bat | `bat <file>` | シンタックスハイライト付きcat |

### 例
```bash
rg "TODO"           # TODOを含む行を検索
rg -i "error"       # 大文字小文字を区別しない検索
cat file.js | bat   # シンタックスハイライト表示
vim $(fzf)          # fzfで選んだファイルをvimで開く
```

## 🌳 Git操作

| ツール | コマンド | 説明 |
|--------|----------|------|
| lazygit | `lg` | Git TUI（最強） |
| tig | `tig` | Git log/diff viewer |
| delta | 自動 | git diffを美しく表示 |
| gh | `gh pr create` | GitHub CLI |

### lazygitキーバインド
```
j/k         上下移動
スペース     ステージング/アンステージング
c           コミット
P           プッシュ
p           プル
b           ブランチ切り替え
Enter       差分表示
q           終了
```

### 例
```bash
lg                  # lazygitを起動
tig                 # tig（git log）を起動
gh pr list          # PRリストを表示
gh pr create        # PRを作成
```

## 🐳 Docker操作

| ツール | コマンド | 説明 |
|--------|----------|------|
| lazydocker | `lzd` | Docker TUI |
| dive | `dive <image>` | イメージ解析 |

### lazydockerキーバインド
```
1-4         タブ切り替え（Containers/Images/Volumes/Networks）
j/k         上下移動
d           削除
s           停止/開始
Enter       詳細表示
l           ログ表示
```

### 例
```bash
lzd                 # lazydockerを起動
dive nginx:latest   # nginxイメージを解析
```

## 📊 システム監視

| ツール | コマンド | 説明 |
|--------|----------|------|
| btop | `btop` | モダンなtop |
| procs | `proc` | モダンなps |
| dust | `dust` | ディスク使用量 |
| fastfetch | `sysinfo` | システム情報 |

### 例
```bash
btop                # システムモニター
proc                # プロセス一覧
dust                # ディスク使用量（視覚的）
sysinfo             # システム情報を表示
```

## 📝 データ処理

| ツール | コマンド | 説明 |
|--------|----------|------|
| jq | `jq '.'` | JSON処理 |
| yq | `yq '.'` | YAML処理 |
| fx | `fx` | インタラクティブJSON |

### 例
```bash
# JSONを整形
cat data.json | jq '.'

# 特定のキーを抽出
cat data.json | jq '.users[0].name'

# YAMLを処理
cat config.yaml | yq '.database.host'

# インタラクティブに探索
cat data.json | fx
```

## 🌐 ネットワーク・HTTP

| ツール | コマンド | 説明 |
|--------|----------|------|
| httpie | `http` | 使いやすいHTTPクライアント |
| curlie | `curlie` | curl + httpie UI |

### 例
```bash
# GET リクエスト
http GET https://api.github.com/users/octocat

# POST リクエスト
http POST https://api.example.com/data name=John

# ヘッダー付き
http GET https://api.example.com/data Authorization:"Bearer token"

# curlieを使う
curlie GET https://api.github.com/users/octocat
```

## 📚 ドキュメント・ヘルプ

| ツール | コマンド | 説明 |
|--------|----------|------|
| tldr | `tldr <cmd>` | 簡潔なヘルプ |
| cheat | `cheat <cmd>` | チートシート |
| glow | `glow <file.md>` | Markdown表示 |

### 例
```bash
tldr git            # gitの簡潔なヘルプ
tldr tar            # tarの使い方（超便利！）
cheat docker        # dockerのチートシート
glow README.md      # Markdownを美しく表示
```

## 🔧 ユーティリティ

| ツール | コマンド | 説明 |
|--------|----------|------|
| zoxide | `z <dir>` | スマートcd |
| atuin | Ctrl+R | 高機能履歴検索 |
| thefuck | `fuck` | コマンド修正 |

### 例
```bash
# zoxide（使うほど賢くなる）
cd ~/src/myproject  # 何度か行く
z proj              # 部分一致でジャンプ！
zi                  # インタラクティブ選択

# atuin（履歴検索）
# Ctrl+R を押す → 検索画面が開く
# 入力すると履歴から検索

# thefuck
sl                  # 間違えた
fuck                # → ls に修正される
```

## 🎨 Vim プラグイン

### ファイル操作
| コマンド | 説明 |
|----------|------|
| `<C-e>` | NERDTree トグル |
| `,p` | ファイル検索（FZF） |
| `,f` | 文字列検索（ripgrep） |
| `,b` | バッファ検索 |

### Git
| コマンド | 説明 |
|----------|------|
| `:Git` | Fugitiveコマンド |
| `:Gdiff` | Git diff |
| `:Gblame` | Git blame |
| `,gl` | GitGutter ハイライト |

### LSP・補完（Coc）
| コマンド | 説明 |
|----------|------|
| `gd` | 定義ジャンプ |
| `gr` | 参照を表示 |
| `K` | ドキュメント表示 |
| `Tab` | 補完候補を進む |

### メモ・執筆
| コマンド | 説明 |
|----------|------|
| `<Leader>g` | Goyo（集中モード） |
| `<Leader>u` | Undotree |
| `<Leader>ww` | VimWiki メイン |
| `:MarkdownPreview` | Markdownプレビュー |

### 編集
| コマンド | 説明 |
|----------|------|
| `gcc` | コメントトグル |
| `cs"'` | クォート変更 |
| `ds"` | クォート削除 |
| `ysiw"` | 単語をクォートで囲む |

## 🔑 よく使うエイリアス

```bash
# Git
lg              # lazygit
gs              # git status
gd              # git diff
gl              # git log --oneline --graph

# Docker
lzd             # lazydocker
dps             # docker ps
dimg            # docker images

# ナビゲーション
..              # cd ..
...             # cd ../..
....            # cd ../../..

# システム
c               # clear
h               # history
sysinfo         # fastfetch
proc            # procs

# エディタ
zshconfig       # vim ~/.zshrc
vimconfig       # vim ~/.vimrc

# 便利
myip            # 外部IPを表示
ports           # リスニングポートを表示
```

## 📖 学習リソース

### 公式ドキュメント
- [Starship](https://starship.rs/) - プロンプト
- [zoxide](https://github.com/ajeetdsouza/zoxide) - スマートcd
- [lazygit](https://github.com/jesseduffield/lazygit) - Git TUI
- [fzf](https://github.com/junegunn/fzf) - ファジーファインダー

### Vimプラグイン
- [vim-plug](https://github.com/junegunn/vim-plug) - プラグインマネージャー
- [coc.nvim](https://github.com/neoclide/coc.nvim) - LSP
- [VimWiki](https://github.com/vimwiki/vimwiki) - パーソナルWiki

## 💡 Tips

1. **zoxideを育てる**: よく使うディレクトリに数回cdすると記憶される
2. **Ctrl+R を使う**: atuinの履歴検索は超強力
3. **lazygitを使う**: Gitの複雑な操作も直感的に
4. **tldrを使う**: manより分かりやすい
5. **fzfと組み合わせる**: `vim $(fzf)`, `cd $(fd --type d | fzf)`

---

詳細は [README.md](README.md) と [QUICKSTART.md](QUICKSTART.md) を参照してください。
