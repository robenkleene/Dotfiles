;;; robenkleene-emacs.el --- robenkleene-emacs
;;; Commentary:
;;; Code:

;; Save temporary files to tmp directory
(setq auto-save-file-name-transforms
                `((".*" ,temporary-file-directory t)))

;; Only use hl-line-mode in specific modes
(global-hl-line-mode)
(make-variable-buffer-local 'global-hl-line-mode)

;; Show trailing white space
(setq-default show-trailing-whitespace t)

(provide 'robenkleene-emacs)
;;; robenkleene-emacs.el ends here
