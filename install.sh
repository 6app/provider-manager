#!/usr/bin/env bash
set -euo pipefail
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SRC_DIR/cx"
DEST_DIR="${HOME}/.local/bin"
DEST="$DEST_DIR/cx"
mkdir -p "$DEST_DIR"
ln -sf "$SRC" "$DEST"
chmod +x "$SRC"
printf '已注册 cx -> %s\n' "$SRC"
case ":$PATH:" in
  *":$DEST_DIR:"*) ;;
  *) printf '提示：%s 不在 PATH 中，请把下面这一行加入 shell 配置：\nexport PATH="$HOME/.local/bin:$PATH"\n' "$DEST_DIR" ;;
esac
