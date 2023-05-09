;;; robenkleene-pulsar.el --- robenkleene-pulsar
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package pulsar
  :init
  (pulsar-global-mode)
  (add-hook 'consult-after-jump-hook #'pulsar-reveal-entry)
  (add-hook 'next-error-hook #'pulsar-pulse-line)
  (add-hook 'imenu-after-jump-hook #'pulsar-reveal-entry)
  ;; (setq pulsar-delay 0.02)
  (setq pulsar-iterations 15)
  (setq pulsar-face 'pulsar-magenta)
  (setq pulsar-pulse-functions (append pulsar-pulse-functions
                                       '(
                                         rk/other-window-reverse
                                         rk/split-vertical
                                         rk/split-horizontal
                                         rk/delete-window
                                         ;; Not sure why none of these work?
                                         ;; rk/switch-to-buffer
                                         ;; eshell
                                         ;; dired-jump
                                         ;; describe-function
                                         ;; describe-mode
                                         ;; describe-key
                                         ;; magit-status
                                         )))
  ;; Not sure why this isn't working?
  ;; (defadvice select-window (after rk/switch-to-buffer-pulsar)
  ;;   "Trigger Pulsar after switching to a buffer."
  ;;   (pulsar-pulse-line)
  ;;   )
  ;; Not sure why this isn't working?
  ;; (add-function :after after-focus-change-function #'pulsar-pulse-line)
  )

(provide 'robenkleene-pulsar)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-pulsar.el ends here
