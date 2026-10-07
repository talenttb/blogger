#!/bin/sh
# 把 org/ 底下所有 .org 重新匯出成 content/ 的 md。
# 不需要開著 Emacs，只借用 Doom 已裝好的 ox-hugo / ox-zola / tomelr。
set -e
cd "$(dirname "$0")/.."

EMACS_VERSION="$(emacs --batch --eval '(princ emacs-version)')"
PKG="${PKG:-$HOME/.config/emacs/.local/straight/build-$EMACS_VERSION}"

emacs --batch -Q \
  -L "$PKG/ox-hugo" -L "$PKG/ox-zola" -L "$PKG/tomelr" \
  --eval '(setq enable-local-variables :all)' \
  --eval '(dolist (f (directory-files "org" t "\\.org\\'"'"'"))
            (with-current-buffer (find-file-noselect f)
              (ox-zola-export-wim-to-md t)))' \
  2>&1 | grep -E 'Exported|[Ee]rror'
