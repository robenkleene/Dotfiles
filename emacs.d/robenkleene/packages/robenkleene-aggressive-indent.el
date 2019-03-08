;;; robenkleene-aggressive-indent.el --- robenkleene-aggressive-indent
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package aggressive-indent
  :init
  ;; (global-aggressive-indent-mode 1)
  ;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  ;; (add-to-list 'aggressive-indent-excluded-modes 'swift-mode)
  ;; (add-to-list 'aggressive-indent-excluded-modes 'markdown-mode)
  ;; (add-to-list 'aggressive-indent-excluded-modes 'enh-ruby-mode)
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  )

(provide 'robenkleene-aggressive-indent)
;;; robenkleene-aggressive-indent.el ends here
