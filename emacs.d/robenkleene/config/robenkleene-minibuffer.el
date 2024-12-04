;;; robenkleene-minibuffer.el --- robenkleene-minibuffer
;;; Commentary:
;;; Code:

;; Persist minibuffer history between restarts (packages like `vertico' will use
;; this to prioritized commonly used commands)
(savehist-mode)

(with-eval-after-load "minibuffer"
  (define-key minibuffer-local-map (kbd "<up>") 'previous-complete-history-element)
  (define-key minibuffer-local-map (kbd "<down>") 'next-complete-history-element)
  )

;; Enable recursive minibuffers so `C-u M-! <command>' can be used when naming
;; files.
;; This fixes an issue where using `M-!' (`M-x shell-command') printed an error
;; when using Terminal Emacs through `emacsclient'
;; This breaks using `M-n' after `M-!' to run a shell command on the current
;; buffer
;; Try disabling recursive minibuffers, in practice it's really confusing
;; (setq enable-recursive-minibuffers t)

(provide 'robenkleene-minibuffer)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-minibuffer.el ends here
