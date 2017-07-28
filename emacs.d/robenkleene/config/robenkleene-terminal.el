;;; robenkleene-terminal.el --- robenkleene-terminal
;;; Commentary:
;;; Code:

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'kleene-dark t)

;; A proper `<M-tab>' key is more important than `C-M-Tab`
(define-key key-translation-map  (kbd "C-M-i") (kbd "<M-tab>"))

(provide 'robenkleene-terminal)
;;; robenkleene-terminal.el ends here
