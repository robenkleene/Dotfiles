;;; robenkleene-markdown.el --- robenkleene-markdown
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package markdown-mode
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :config
  (define-key markdown-mode-map (kbd "M-{") 'robenkleene/backward-block)
  (define-key markdown-mode-map (kbd "M-}") 'robenkleene/forward-block)

  ;; This isn't working
  ;; (add-hook 'markdown-mode-hook (lambda ()
  ;;                                 ;; Turn on auto-saving
  ;;                                 (set (make-local-variable 'auto-save-visited-file-name) t)
  ;;                                 (setq-local auto-save-default t)
  ;;                                 (auto-save-mode)
  ;;                                 )
  ;;           )
  ;; Try `flyspell-prog-mode' to prevent spelling errors in Markdown code
  ;; blocks. This seems to disable spelling altogether: (add-hook
  ;; 'markdown-mode-hook 'flyspell-prog-mode)
  )

(provide 'robenkleene-markdown)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-markdown.el ends here
