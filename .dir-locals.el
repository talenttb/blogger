;; repo 內所有 org 檔：載入 doom/snippets/ 的 yasnippet
;; org/ 底下的 org 檔：匯出到上一層（repo 根目錄），存檔時自動匯出成 Zola md
((org-mode
  . ((eval . (with-eval-after-load 'yasnippet
               (let ((dir (expand-file-name
                           "doom/snippets/"
                           (locate-dominating-file default-directory ".dir-locals.el"))))
                 (unless (member dir yas-snippet-dirs)
                   (add-to-list 'yas-snippet-dirs dir t)
                   (yas-load-directory dir)))))))
 ("org/"
  . ((org-mode
      . ((org-hugo-base-dir . "../")
         (eval . (progn
                   (require 'ox-zola)
                   ;; ox-zola 把 [taxonomies] 放在最前面，TOML 會解析錯誤；改成放到最後
                   (defun my/ox-zola-taxonomies-last (fm)
                     (let ((tax (assq 'taxonomies fm)))
                       (if tax
                           (append (assq-delete-all 'taxonomies (copy-alist fm)) (list tax))
                         fm)))
                   (advice-add 'ox-zola--transform-frontmatter
                               :filter-return #'my/ox-zola-taxonomies-last)
                   ;; 連結改用 ox-zola 的寫法（跨檔連結 → @/posts/x.md）；圖片一律輸出成 ![alt](src)
                   (defun my/ox-zola-link (link desc info)
                     (cl-letf (((symbol-function 'org-html-standalone-image-p) #'ignore))
                       (ox-zola-link link desc info)))
                   (advice-add 'org-hugo-link :override #'my/ox-zola-link)
                   ;; 存檔時自動匯出
                   (add-hook 'after-save-hook
                             (lambda () (ox-zola-export-wim-to-md t))
                             nil t))))))))
