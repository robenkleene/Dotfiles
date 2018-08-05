;;; robenkleene-god-mode-modes.el --- robenkleene-god-mode-modes
;;; Commentary:
;;; Code:

;; `yassnippet'
(add-to-list 'god-exempt-major-modes 'snippet-mode)
(defcustom robenkleene/mortal-exempt-major-modes
  '(git-commit-mode
    vc-annotate-mode
    git-commit-mode
    snippet-mode)
  "List of major modes that should not use the override map."
  :type '(function)
  )

(with-current-buffer "*Messages*"
  (robenkleene/mortal-mode)
  )

(add-hook 'help-mode-hook
          (lambda ()
            (define-key help-mode-map "p" 'previous-line)
            (define-key help-mode-map "n" 'next-line)
            )
          )

(add-hook 'magit-status-mode-hook
          (lambda ()
            (make-local-variable 'robenkleene/mortal-mode-map)
            (setq robenkleene/mortal-mode-map (copy-tree robenkleene/mortal-mode-map))
            (define-key robenkleene/mortal-mode-map (kbd "c") nil)
            (define-key robenkleene/mortal-mode-map (kbd "r") nil)
            (define-key robenkleene/mortal-mode-map (kbd "s") nil)
            )
          )

(provide 'robenkleene-god-mode-modes)
;;; robenkleene-god-mode-modes.el ends here
