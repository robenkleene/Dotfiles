;;; robenkleene-markdown.el --- robenkleene-markdown
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package markdown-mode
  :ensure t
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode))


(provide 'robenkleene-markdown)
;;; robenkleene-markdown.el ends here
