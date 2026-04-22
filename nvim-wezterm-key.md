# WezTermKeys

| Modifier Key ||
|:--|:--|
| LD | LEADER = Win/Cmd + q
| SP | SUPER  = Ctrl
| GW | Ctrl   = Win/Cmd
| SF | Shift
| AL | Alt/Opt

| Tab ||
|:--|:--|
| SP + t | Tab新規作成
| SP + w | Tabを閉じる
| GW + Tab | Tab移動(右)
| GW + SF + Tab | Tab移動(左)

| Copy Mode ||
|:--|:--|
| LD + [ | コピーモード
| SP + c | コピー
| SP + v | ペースト

| Pane ||
|:--|:--|
| LD + d | 上下画面分割
| LD + r | 左右画面分割
| LD + x | 選択中の画面を閉じる
| LD + z | 選択中のみ表示
| LD + h | 左に移動
| LD + j | 下に移動
| LD + k | 上に移動
| LD + l | 右に移動


# Neovim

Modifier Key ||
|:--|:--|
| LD | LEADER = Space
| SP | SUPER  = Ctrl
| GW | Ctrl   = Win/Cmd
| SF | Shift
| AL | Alt/Opt

| バッファ変更 ||
|:--|:--|
| [ + b | 左のバッファに移動
| ] + b | 右のバッファに移動

### :コマンド系
:bp  :左のバッファに移動<br>
:bn  :右のバッファに移動<br>
:let @+ = expand("%") :相対パスをコピー
:let @+ = expand :フルパスをコピー
