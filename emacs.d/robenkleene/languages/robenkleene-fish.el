;;; robenkleene-fish.el --- robenkleene-fish
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package fish-mode
  :mode "\\.fish\\'"
  :config
  (add-hook 'fish-mode-hook
            (lambda ()
              (when (boundp 'whitespace-style)
                (setq-local whitespace-style (push 'lines-tail
                                                   whitespace-style)))
              ))
  )

(provide 'robenkleene-fish)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-fish.el ends here
