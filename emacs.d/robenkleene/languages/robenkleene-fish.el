;;; robenkleene-fish.el --- robenkleene-fish
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package fish-mode
  :mode "\\.fish\\'"
  :config
  (add-hook 'fish-mode-hook
            (lambda ()

              ))
  )

(provide 'robenkleene-fish)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-fish.el ends here
