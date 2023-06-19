;;; robenkleene-auto-dim-other-buffers.el --- robenkleene-auto-dim-other-buffers
;;; Commentary:
;;; Code:

(use-package auto-dim-other-buffers
  :init
  (add-hook 'after-init-hook (lambda ()
                               (when (fboundp 'auto-dim-other-buffers-mode)
                                 (auto-dim-other-buffers-mode t))))
  )

(provide 'robenkleene-auto-dim-other-buffers)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-auto-dim-other-buffers.el ends here
