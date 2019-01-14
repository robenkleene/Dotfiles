;;; robenkleene-markdown.el --- robenkleene-markdown
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package markdown-mode
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :config
  (define-key markdown-mode-map (kbd "M-{") 'robenkleene/backward-block)
  (define-key markdown-mode-map (kbd "M-}") 'robenkleene/forward-block)
  )



(provide 'robenkleene-markdown)
;;; robenkleene-markdown.el ends here
