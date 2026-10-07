;; org/ 底下的 org 檔：匯出到上一層（repo 根目錄），存檔時自動匯出成 Zola md
((org-mode
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
               ;; 存檔時自動匯出
               (add-hook 'after-save-hook
                         (lambda () (ox-zola-export-wim-to-md t))
                         nil t))))))
