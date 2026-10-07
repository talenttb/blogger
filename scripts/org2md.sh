#!/bin/sh
# 把 org/ 底下所有 .org 匯出成 content/ 的 md。
# 不需要開著 Emacs，只借用 Doom 已裝好的 ox-hugo / ox-zola / tomelr。
#
# 用法：
#   ./scripts/org2md.sh          append：匯出／覆蓋 md，不刪任何檔案
#   ./scripts/org2md.sh --clean  先刪除 content/ 裡匯出的 md（保留 _index.md），再全部重產
set -e
cd "$(dirname "$0")/.."

case "${1:-}" in
  "") ;;
  --clean)
    find content -name '*.md' ! -name '_index.md' -print -delete | sed 's/^/removed: /'
    ;;
  *)
    echo "usage: $0 [--clean]" >&2
    exit 1
    ;;
esac

EMACS_VERSION="$(emacs --batch --eval '(princ emacs-version)')"
PKG="${PKG:-$HOME/.config/emacs/.local/straight/build-$EMACS_VERSION}"

emacs --batch -Q \
  -L "$PKG/ox-hugo" -L "$PKG/ox-zola" -L "$PKG/tomelr" \
  --eval '(setq enable-local-variables :all)' \
  --eval '(dolist (f (directory-files "org" t "\\.org\\'"'"'"))
            (with-current-buffer (find-file-noselect f)
              (ox-zola-export-wim-to-md t)))' \
  2>&1 | grep -E 'Exported|[Ee]rror'
